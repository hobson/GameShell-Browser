# Ansible deployment for GameShell-Browser (Hetzner + Contabo)

## Context

GameShell-Browser serves the GameShell shell tutorial over the web: Caddy (public HTTPS)
→ ttyd on `127.0.0.1:7682` → one throwaway `--network none` Docker container per player,
plus a janitor service that reaps orphaned `gsh-*` containers.

Today that is deployed by hand. `docs/browser-deployment.md` is a 7-step manual runbook,
and `docs/deploy_gameshell_run_inside_vm.sh` is a partial, non-idempotent distillation of a
real VM session (`hist_logs/`) with known defects: it `sed`s the checked-in unit files
in place (dirtying the working tree, and non-repeatable), unconditionally re-`export`s
`FQDN` over any value the operator set, `apt install caddy` without adding the Caddy apt
repo, `ln` (hard link) instead of `cp` into `/etc/caddy`, and never runs `ufw enable`.
There is no VM provisioning at all — the Hetzner box was created by hand.

The goal is a single idempotent `ansible-playbook site.yml` that provisions a VM on
**either Hetzner Cloud or Contabo** and configures it end to end, re-runnable safely.

A second goal: `~/code/od/rtod/ansible/` already has a production-quality Hetzner
provisioning playbook and a **broken** Contabo one (wrong endpoint `/v1/cloud/servers`,
no OAuth2, no `x-request-id`, `ignore_errors: true`, and it `add_host`s a literal
`"pending-contabo-ip"`). Contabo has no official Ansible collection. So the provisioning
logic gets consolidated into a new shared collection that rtod and openfreemap can adopt
later.

## Decisions taken

| Decision | Choice |
|---|---|
| Scope | Provision **and** configure |
| Consolidation | Custom Contabo modules + provider-agnostic `cloud_vm` dispatcher role; keep `hetzner.hcloud` for Hetzner |
| Code location | New shared repo `~/code/od/ansible-cloud` holding the `totalgood.cloud` collection |
| Docker image | `gsh_image_source: build \| registry` variable |
| TLS | Caddy automatic Let's Encrypt; DNS A record is an operator prerequisite |
| Contabo lifecycle | `state=present` only — create-if-absent, **never** delete (instances are paid orders) |

---

# Part 1 — New shared collection: `~/code/od/ansible-cloud`

```
~/code/od/ansible-cloud/
├── README.md
└── ansible_collections/totalgood/cloud/
    ├── galaxy.yml                        # namespace totalgood, name cloud
    ├── plugins/
    │   ├── module_utils/contabo.py       # OAuth2 + request helper
    │   └── modules/
    │       ├── contabo_ssh_key.py
    │       └── contabo_instance.py
    └── roles/cloud_vm/
        ├── defaults/main.yml
        └── tasks/{main,hcloud,contabo,register}.yml
```

## `module_utils/contabo.py`

Shared helper, so both modules stay thin:

- `get_token(module)` — POST to
  `https://auth.contabo.com/auth/realms/contabo/protocol/openid-connect/token`
  with `client_id`, `client_secret`, `username`, `password`, `grant_type=password`.
  Credentials from module params, defaulting to env vars
  `CONTABO_CLIENT_ID`, `CONTABO_CLIENT_SECRET`, `CONTABO_API_USER`, `CONTABO_API_PASSWORD`.
  **Note:** rtod's existing `CONTABO_ID`/`CONTABO_TOKEN` names are wrong — a raw bearer
  token is not what Contabo issues. Use the four names above and document the rename.
- `request(module, method, path, body=None)` — wraps
  `ansible.module_utils.urls.fetch_url`, injecting `Authorization: Bearer <token>`,
  `Content-Type: application/json`, and a fresh `x-request-id` UUID per call
  (Contabo requires it and uses it for dedupe).
- Mark every credential param `no_log=True`.

> **Verify during implementation:** confirm the exact endpoints, field names, and the
> auth `grant_type` against Contabo's current API docs before writing the tasks — the
> paths below are the intended shape, not verified constants. Write them so a wrong guess
> surfaces as a clear failure, not `ignore_errors`.

## `contabo_ssh_key.py`

`state: present` only. Contabo stores SSH keys in the Secrets API:
`GET /v1/secrets?type=ssh` → match on `name` → reuse `secretId`; else
`POST /v1/secrets` `{"name": ..., "type": "ssh", "value": "<pubkey>"}`.
Returns `secret_id` (int) — what `contabo_instance` needs. Supports `check_mode`.

## `contabo_instance.py`

The safety-critical module. `state: present` **only**; `state: absent` must fail with an
explicit message pointing the operator at the Contabo panel — never issue a cancellation.

1. `GET /v1/compute/instances` and match on `displayName`. If found → return it,
   `changed: false`. This is the whole idempotency guarantee, and it must run before
   anything that could spend money.
2. If absent: `POST /v1/compute/instances` with `imageId`, `productId`, `region`,
   `sshKeys: [<secret_id>]`, `period`, `displayName`, optional `userData`.
3. Poll `GET /v1/compute/instances/{instanceId}` until `status == "running"`
   (`wait_timeout`, default 900s — Contabo provisioning takes minutes, unlike Hetzner).
4. Return `instance_id`, `ipv4` (from `ipConfig.v4.ip`), `status`.

`check_mode` must do step 1 and then report what it *would* order, without ordering.

## `roles/cloud_vm` — the dispatcher

One provider-agnostic interface. `tasks/main.yml` asserts `cloud_provider` is
`hcloud` or `contabo`, then includes the matching file, then always `register.yml`.

- **`hcloud.yml`** — lifted nearly verbatim from
  `~/code/od/rtod/ansible/playbooks/provision.yml`: fail-fast on missing `HCLOUD_TOKEN`,
  then `hetzner.hcloud.hcloud_ssh_key` → `hcloud_firewall` (tcp `ssh_port`/80/443 + icmp
  from `0.0.0.0/0`,`::/0`) → `hcloud_server`. Sets the common facts.
- **`contabo.yml`** — `totalgood.cloud.contabo_ssh_key` → `contabo_instance`. Contabo has
  no cloud firewall API equivalent, so the `base` role's ufw rules are the only firewall;
  note that difference in the role README.
- **`register.yml`** — the shared tail, written once instead of twice:
  `wait_for` port **22** (not `ssh_port`; the box is still stock), `add_host` into
  `{{ cloud_provider }}_new`, and write `.provisioned_hosts.yml`.

Both branches normalise to: `cloud_vm_name`, `cloud_vm_ipv4`, `cloud_vm_id`.

**Carry over two hard-won details from rtod's `provision.yml`:**

- In `add_host`, set `ansible_host` **only** — deliberately *not* `ansible_user` or
  `ansible_port`. `add_host` host-vars outrank per-play vars, so setting them there breaks
  the root@22 bootstrap → app_user@2222 handoff on re-runs. Keep rtod's comment explaining it.
- Contabo ships partially-routed IPv6 (documented in
  `openfreemap/modules/http_host/http_host_lib/nginx.py:88`). Expose a
  `caddy_disable_ipv6` var, defaulted `true` when `cloud_provider == 'contabo'`.

---

# Part 2 — `deploy/ansible/` in GameShell-Browser

```
deploy/ansible/
├── ansible.cfg              # roles_path, host_key_checking=False, interpreter_python=auto_silent, pipelining
├── requirements.yml         # hetzner.hcloud>=7.0.0, ansible.posix>=2.2.0, community.general>=9.0.0
│                            #   + totalgood.cloud (path/git source)
├── README.md
├── inventory/hosts.ini      # [gameshell] for already-provisioned boxes
└── playbooks/
    ├── site.yml
    ├── provision.yml
    ├── configure.yml
    ├── group_vars/all.yml
    └── roles/{base,docker,gameshell,caddy}/
```

`requirements.yml` pins `ansible.posix>=2.2.0` — below that it imports
`ansible.module_utils._text`, removed in ansible-core 2.24. Locally installed already:
ansible-core 2.20.1, `hetzner.hcloud` 7.0.0, `ansible.posix` 2.2.2, `community.general` 13.3.0.

## Playbooks

**`provision.yml`** — `hosts: localhost`, `connection: local`, one role:
`totalgood.cloud.cloud_vm`.

**`configure.yml`** — two plays, mirroring rtod's proven structure:

1. *Bootstrap as root* — `hosts: hcloud_new:contabo_new`, `ansible_user: root`,
   `ansible_port: 22`, role `base`. Only works on a brand-new box.
2. *Configure* — `hosts: hcloud_new:contabo_new:gameshell`, `become: true`,
   `ansible_user: "{{ app_user }}"`, `ansible_port: "{{ ssh_port }}"`, roles
   `base`, `docker`, `gameshell`, `caddy`.

**`site.yml`** — imports `provision.yml` then `configure.yml`, so one command does the
whole thing. Give every role an explicit `tags:` entry — a bare string under `roles:`
carries no tag, so `--tags gameshell` would otherwise silently match nothing.

## Roles

### `base`
Port `~/code/od/rtod/ansible/roles/base/tasks/main.yml`, **dropping** NodeSource/Node.js,
`uv`, and `python3-psycopg2` (all rtod-specific). Keep:

- apt packages: `fail2ban ufw curl jq debian-keyring debian-archive-keyring apt-transport-https gnupg ca-certificates`
- `app_user` + group, `groups: sudo`, `/etc/sudoers.d/90-{{ app_user }}` with `validate: "visudo -cf %s"`
- `ansible.posix.authorized_key` loop over `app_authorized_keys`
- SSH hardening template → `/etc/ssh/sshd_config.d/ssh-hardening.conf`, `validate: "sshd -t -f %s"`
- fail2ban `jail.local` on `{{ ssh_port }}`
- ufw: allow `{{ ssh_port }}`/80/443 → `state: enabled, policy: deny`.
  **Never open 7682** — ttyd binds loopback only and Caddy is the sole public listener.
- `meta: flush_handlers` immediately after — this restarts sshd onto `ssh_port`
  *before* the root@22 connection is lost. Without it the play hangs. Keep rtod's comment.

### `docker` (new)
Not in rtod. Official Docker apt repo, and follow rtod's `caddy` role lesson: write
`/etc/apt/sources.list.d/docker.list` with `copy: content:` rather than `apt_repository`,
which *appends* and produces apt's `Conflicting values set for option Signed-By`.

- `get_url` the GPG key → `gpg --dearmor` with `creates:` → `copy` the deb line
- install `docker-ce docker-ce-cli containerd.io docker-buildx-plugin`
- `user: name={{ app_user }} groups=docker append=yes`
- systemd `docker` enabled + started
- **`meta: reset_connection`** after the group change, or `docker` commands as `app_user`
  fail with a permission error for the rest of the run.

### `gameshell` (new — the core of this deployment)
Vars: `gsh_image` (`gameshell`), `gsh_port` (7682), `gsh_iface` (`lo`),
`gsh_janitor_interval` (5), `gsh_image_source` (`build`|`registry`), `gsh_registry_image`,
`repo_url`, `repo_version`, `repo_dir` (`/home/{{ app_user }}/GameShell-Browser`).

1. **ttyd** — `apt: name=ttyd`, then assert `ttyd --version` ≥ 1.7.0 (the `-W` writable
   flag does not exist before that; without it typing is silently ignored). Ubuntu 22.04's
   packaged ttyd may be too old — if the assert fails, fall back to a `get_url` of the
   upstream static binary to `/usr/local/bin/ttyd`.
2. **Repo** — `ansible.builtin.git` clone/update `repo_url` at `repo_version` into
   `repo_dir`, owned by `app_user`. Three different repo URLs appear across the tree
   (`aboudia9`, `aboutalib1953`, and the local `hobson` remote) — make `repo_url` an
   explicit required var rather than guessing a default.
3. **Image**, on `gsh_image_source`:
   - `build`: `community.docker.docker_image` (or `command: docker build -t {{ gsh_image }} .`
     guarded by a `docker image inspect` check) in `repo_dir`. Add a `force_image_build`
     var so `--tags gameshell -e force_image_build=true` rebuilds after a `git pull`.
   - `registry`: pull `gsh_registry_image` and `docker tag` it to `gsh_image`, so
     `gsh-session.sh` needs no change either way.
   The Dockerfile's `LegacyKeyValueFormat` warning from the `ENV LANG` line is expected
   and harmless. **Note:** `Dockerfile` currently has an *uncommitted* change adding
   `python3` + `python-is-python3`. Commit that first, or a `build` from a fresh clone
   silently produces a different image than the local one.
4. **Scripts** — ensure `deploy/*.sh` are `mode: 0755` (already correct in git; this makes
   it explicit and survives a clone with a broken umask).
5. **systemd units** — new `.j2` templates in this role, rendering directly to
   `/etc/systemd/system/`. Do **not** `sed` the checked-in
   `deploy/systemd/*.service` files: that dirties the working tree and is what makes the
   existing script non-idempotent. The checked-in files stay as the manual/standalone path.
   Templates set `User={{ app_user }}`, `ExecStart={{ repo_dir }}/deploy/gsh-serve.sh`,
   and — the real gain over `sed` — `Environment=` lines for `GSH_PORT`, `GSH_IFACE`,
   `GSH_IMAGE`, `GSH_JANITOR_INTERVAL`, so those vars actually reach the scripts instead
   of silently falling back to the shell defaults.
   `notify` handlers → `daemon_reload` + restart.
6. `systemd: daemon_reload=true enabled=true state=started` for
   `gameshell-janitor.service` and `gameshell-ttyd.service`.

### `caddy`
Reuse the *structure* of `~/code/od/rtod/ansible/roles/caddy/tasks/main.yml` — including
its `copy: content:` apt-source pattern — but **not** its unit override or
`cap_net_bind_service` task. rtod overrides the packaged unit to run Caddy as `app_user`
against a repo Caddyfile; GameShell has no such need, so keep the stock packaged unit and
the stock `caddy` system user. Just template a simple Caddyfile:

```jinja
{{ gsh_domains | join(', ') }} {
    reverse_proxy 127.0.0.1:{{ gsh_port }}
}
```

to `/etc/caddy/Caddyfile`, `notify: reload caddy` (reload, not restart). `gsh_domains` is
a **list**, which cleanly handles the multi-domain case the existing script hacks in as a
comma string (`'gsh.proai.org, bash.proai.org, sh.proai.org'`). Add `validate` via
`caddy validate --config %s --adapter caddyfile` so a bad template can't take the site down.

## `group_vars/all.yml`

```yaml
cloud_provider: hcloud            # hcloud | contabo

hcloud_server_name: gameshell
hcloud_server_type: cx22          # 2 vCPU, 4GB - doc says >=1GB serves ~15 players
hcloud_location: hel1
hcloud_image: ubuntu-24.04

contabo_display_name: gameshell
contabo_product_id: V45
contabo_region: US-central
contabo_image_id: ""              # Contabo uses image UUIDs; look up once and pin

app_user: gsh
ssh_port: 2222
app_authorized_keys: []           # required
ssh_key_public_path: "{{ lookup('env','HOME') }}/.ssh/id_ed25519.pub"

gsh_domains: []                   # required, e.g. [gsh.proai.org, sh.proai.org]
repo_url: ""                      # required
repo_version: main
gsh_image_source: build
gsh_port: 7682                    # 7681 avoided: DigitalOcean's droplet-agent uses it
gsh_iface: lo
gsh_janitor_interval: 5
```

`assert` that `gsh_domains`, `app_authorized_keys`, and `repo_url` are non-empty at the
top of `configure.yml` — failing fast beats provisioning a VM Caddy can't get a cert for.

## Secrets

Follow the established repo convention: cloud credentials come from the **environment
only**, never a var file and never vault — `HCLOUD_TOKEN` for Hetzner, and the four
`CONTABO_*` vars for Contabo. Fail fast at the top of `provision.yml` with a message
naming the exact export. GameShell itself has no application secrets (no auth, no
database), so there is no `.credentials/` equivalent to build here.

---

## Files to create

**`~/code/od/ansible-cloud/`** (new repo): `galaxy.yml`, `README.md`,
`plugins/module_utils/contabo.py`, `plugins/modules/contabo_ssh_key.py`,
`plugins/modules/contabo_instance.py`, `roles/cloud_vm/{defaults,tasks}/`.

**`GameShell-Browser/deploy/ansible/`** (new): `ansible.cfg`, `requirements.yml`,
`README.md`, `inventory/hosts.ini`, `playbooks/{site,provision,configure}.yml`,
`playbooks/group_vars/all.yml`, and roles `base`, `docker`, `gameshell`, `caddy`.

**Modified:** `.gitignore` (add `deploy/ansible/.provisioned_hosts.yml`, `*.retry`);
`docs/browser-deployment.md` (add an "Automated deployment" section pointing at the
playbook, keep the manual runbook as the fallback and as the reference the roles encode);
`docs/deploy_gameshell_run_inside_vm.sh` (mark superseded — leave it, it documents the
original hand-run session).

`deploy/*.sh`, `deploy/Caddyfile`, and `deploy/systemd/*.service` stay **unchanged** — the
playbook templates its own copies and never mutates the working tree.

---

## Verification

**Static, no VM, no spend:**
```sh
cd deploy/ansible
ansible-galaxy collection install -r requirements.yml
ansible-lint playbooks/                     # if available
ansible-playbook playbooks/site.yml --syntax-check
python -c "import ast,sys; [ast.parse(open(f).read()) for f in sys.argv[1:]]" \
  ~/code/od/ansible-cloud/ansible_collections/totalgood/cloud/plugins/modules/*.py
ansible-doc -M .../plugins/modules contabo_instance      # DOCUMENTATION block parses
```
Assert `contabo_instance` with `state: absent` fails with the "cancel via the panel"
message, and that `--check` against an existing `displayName` reports `changed: false`
without a POST.

**Against a real Hetzner VM** (cheap, instantly destroyable — do Hetzner first):
```sh
export HCLOUD_TOKEN=$(cat ~/.config/od/hcloud_token)
ansible-playbook playbooks/site.yml -e cloud_provider=hcloud
ansible-playbook playbooks/site.yml -e cloud_provider=hcloud   # 2nd run: changed=0
```
The second run reporting `changed=0` is the actual idempotency test and the whole point
of this work. Expect `docker build` to need a `creates`-style guard to reach it.

**End-to-end, from `docs/browser-deployment.md`'s own verification section:**
```sh
ssh -p 2222 gsh@<ip> systemctl status gameshell-ttyd gameshell-janitor caddy --no-pager
ssh -p 2222 gsh@<ip> 'ss -ltn | grep 7682'     # 127.0.0.1:7682 ONLY, never 0.0.0.0
ssh -p 2222 gsh@<ip> sudo ufw status           # 2222/80/443 only; 7682 absent
```
- Load `https://<domain>` — padlock, GameShell banner, keystrokes echo (proves ttyd `-W`).
- Two browser tabs → two independent games; `docker ps --filter name=^gsh-` shows two.
- Close one tab, wait ~10s → that container is gone (proves the janitor).
- Fork bomb `:(){ :|:& };:` inside a session → `Resource temporarily unavailable`
  (proves `--pids-limit 128`).
- `sudo reboot`, wait, reload the page → everything comes back (proves `enable --now`).
- Re-run with `--tags gameshell -e force_image_build=true` after a commit → image rebuilds,
  ttyd restarts, other roles report `changed=0`.

**Contabo** last, and only once Hetzner is green: run `provision.yml --check` first to
confirm it reports "would order" without spending, then a real run, then `site.yml` a
second time to confirm it reuses the instance rather than ordering a second one.

## Out of scope (existing limitations, flagged not fixed)

No cap on concurrent sessions, no max session lifetime, no authentication (Caddy
`basic_auth` is the documented option), no saved player progress, and
`intermediate/04_bg_xeyes` cannot work headless. Adding a `gsh_max_sessions` knob would
mean changing `gsh-serve.sh` / `gsh-session.sh`, which this plan deliberately leaves alone.

--- 

## Implemented Plan Part 1

From claude:

```
Part 1 — ~/code/od/ansible-cloud (new repo, committed): the totalgood.cloud collection.
- contabo_ssh_key / contabo_instance modules with a real OAuth2 flow (auth.contabo.com) and x-request-id headers — the piece rtod's broken provision-contabo.yml never had.
- contabo_instance is create-if-absent only; state=absent refuses with a message pointing at the customer panel (tested — it fires correctly).
- cloud_vm role dispatches to hetzner.hcloud (adapted from rtod's working provision.yml, updated to the v7 module names) or the Contabo modules, converging on cloud_vm_name/cloud_vm_ipv4/cloud_vm_id and an in-memory <provider>_new inventory group.
- Passes ansible-lint at the production profile (5/5).

Part 2 — deploy/ansible/ in this repo (untracked, not committed): site.yml / provision.yml / configure.yml, roles base (SSH hardening, incl. Ubuntu 24.04's socket-activated sshd), docker, gameshell (ttyd version guard, build-or-registry image, templated systemd units with real Environment= vars instead of the old sed approach), caddy (auto-HTTPS). Also passes ansible-lint cleanly.
- docs/browser-deployment.md now points at the playbook as the primary path; docs/deploy_gameshell_run_inside_vm.sh is marked superseded with its specific defects documented.
```

## Verified 

Before claude ran out of tokens, according to claude it verified:

```
- Every YAML/Python file parses; ansible-doc resolves both Contabo modules; --syntax-check passes for both playbook trees.
- Required-var assertions fire with clear messages when gsh_domains/app_authorized_keys/gsh_repo_url are unset.
- All four templates (gameshell-ttyd.service, gameshell-janitor.service, Caddyfile, sshd_hardening.conf) rendered with realistic values and validated with the real tools (caddy validate, sshd -t, systemd-analyze verify).
- contabo_instance state=absent confirmed to fail with the panel-redirect message.
```

## Not yet done

Claude thought it would need hetzner cloud credentials but `ssh gsh` should give you access to an existing VM that I'd like to reconfigure with this new ansible code and the latest revision of GameShell-Browser that includes a Python interpretter accessible within the GameShell for students and game players.

Here's Claude's "not yet done" list:

```
- Deploy the latest code to an existing VM on hetzner cloud
- End-to-end browser verification (two tabs, janitor reaping, fork-bomb, reboot survival).
```

The User has committed the latest Game-Browser, and you should be able to do a live verification of the ansible playbook, without provisioning a new VM.

### User Prompt to Claude:

Use the new ansible-cloud module to deploy gameshell-browser to deploy the latest gameshell-browser with a python interpretter inside the docker containers.

### Claude's reply:

```
Also worth confirming: Python is already baked in. The current Dockerfile (committed at 79e8aab) already installs python3/python-is-python3, and deploy/gsh-session.sh defaults GSH_ENABLE_PYTHON=1 unless deploy/config.env says otherwise — so a plain deploy of main already gives every session a Python interpreter with no extra flags needed.

● User answered Claude's questions:
· Which cloud provider should I provision on, and how should I get the API credentials? → Use the option for this playbook that allows it to reconfigure an existing GameShell-Browser VM.
· Where should I get the credential value(s) from? I can't type a secret for you -- point me at where it already lives, or tell me the file to write it to. → OBE
· Which domain(s) should Caddy request a certificate for? gsh.proai.org / bash.proai.org / sh.proai.org appear in the old deploy script and don't currently resolve to anything -- reusable if you control that zone. → gsh.proai.org (+ bash/sh aliases)
· This will create a real, billed VM and expose it to the public internet on ports 80/443. Confirm you want me to actually run this now. → Yes, provision and deploy now (Recommended)
```
