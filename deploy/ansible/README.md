# Ansible deployment for browser GameShell

One idempotent command to provision a VM on **Hetzner Cloud** or **Contabo** and
deploy browser GameShell onto it, end to end.

This automates [`docs/browser-deployment.md`](../../docs/browser-deployment.md),
which remains the reference for *why* the pieces are shaped the way they are, and
the fallback if you want to do it by hand.

```
browser ──HTTPS──> Caddy ──> ttyd (127.0.0.1:7682) ──> one Docker container per player
                                                        + janitor reaping abandoned ones
```

## Prerequisites

1. **Collections**

   ```sh
   ansible-galaxy collection install -r requirements.yml
   ```

   The `cloud_vm` role and the Contabo modules live in the shared
   [`totalgood.cloud`](https://github.com/totalgood/ansible-cloud) collection.
   `ansible.cfg` already looks in `~/code/od/ansible-cloud`; if your checkout is
   elsewhere, `export ANSIBLE_COLLECTIONS_PATH=/path/to/ansible-cloud`.

2. **DNS.** Every name in `gsh_domains` needs an `A` record pointing at the VM
   *before* you run this — Caddy cannot get a certificate otherwise, and Let's
   Encrypt will not issue for a bare IP. Behind Cloudflare, records must be
   **DNS-only (grey cloud)**; ACME cannot validate through the orange-cloud proxy.

3. **Credentials, from the environment only** — never a var file, never vault:

   ```sh
   # Hetzner
   export HCLOUD_TOKEN=...

   # Contabo (all four)
   export CONTABO_CLIENT_ID=...        # API section of the Contabo panel
   export CONTABO_CLIENT_SECRET=...
   export CONTABO_API_USER=...         # your account email
   export CONTABO_API_PASSWORD=...     # the *API* password, not the panel password
   ```

4. **An SSH keypair** at `ssh_key_public_path` (default `~/.ssh/id_ed25519.pub`).

## Configure

Edit `playbooks/group_vars/all.yml`. Three variables have no default and the run
refuses to start without them:

| Variable | What it is |
|---|---|
| `gsh_domains` | Domains Caddy requests a cert for. A **list**. |
| `app_authorized_keys` | SSH keys allowed in as `app_user`. Empty ⇒ you get locked out. |
| `gsh_repo_url` | Which GameShell-Browser fork to deploy. |

## Run

```sh
# provision a VM and deploy onto it
ansible-playbook playbooks/site.yml

# same, on Contabo
ansible-playbook playbooks/site.yml -e cloud_provider=contabo

# deploy to a box that already exists (add it to inventory/hosts.ini first)
ansible-playbook playbooks/configure.yml --limit gameshell

# redeploy just the app after pushing a commit
ansible-playbook playbooks/configure.yml --limit gameshell \
    --tags gameshell -e gsh_force_image_build=true
```

**Re-running is safe, and the second run reporting `changed=0` is the real test
of this playbook.** The image is only rebuilt when the checkout actually moved,
the image is missing, or you pass `gsh_force_image_build=true`.

Tags: `provision`, `bootstrap`, `base`, `docker`, `gameshell`, `caddy`.

## What it does

**`provision.yml`** → `totalgood.cloud.cloud_vm` creates the VM, waits for SSH,
and adds it to an in-memory `hcloud_new` / `contabo_new` group.

**`configure.yml`** runs in two plays, because the connection details change
underneath it: a brand-new VM only has `root` on port 22, but once `base` has
hardened sshd everything after must come back as `app_user` on `ssh_port`.

| Role | Does |
|---|---|
| `base` | packages, `app_user`, SSH hardening, fail2ban, ufw |
| `docker` | Docker CE from the official repo, `app_user` in the `docker` group |
| `gameshell` | ttyd, the repo, the image, the two systemd services |
| `caddy` | Caddy from its official repo, templated Caddyfile, auto-HTTPS |

## Things that will bite you if you change them

**Never open `gsh_port` (7682) in the firewall.** ttyd serves an
unauthenticated, fully interactive terminal. It binds loopback only and Caddy is
the sole public listener. The `gameshell` role asserts this after starting the
service, and the run fails if ttyd ever ends up on a public interface.

**ttyd must be ≥ 1.7.0.** Older builds lack `-W` (writable), and without it the
terminal renders perfectly and silently swallows every keystroke — the most
confusing way this deployment can fail. Ubuntu 22.04 ships 1.6.x, so the role
falls back to the upstream static binary and re-asserts the version.

**The janitor is not optional.** ttyd SIGKILLs its child process group on
disconnect, so the `docker run` client dies without removing its container.
Without the janitor, abandoned containers accumulate until the box runs out of
memory. See "Why the janitor exists" in `docs/browser-deployment.md`.

**Ubuntu 24.04 socket-activates sshd.** When `ssh.socket` is enabled, `Port` in
`sshd_config` is *silently ignored*. The `base` role detects this and drives the
port from a `ssh.socket` drop-in instead; the empty `ListenStream=` reset in that
drop-in is required, or you end up listening on both 22 and `ssh_port`.

**Contabo has no cloud firewall and its instances are purchases.** On Contabo the
guest's own ufw rules are your *only* firewall. And ordering an instance buys a
subscription: `contabo_instance` is create-if-absent, matches on `display_name`
before it will ever order, and has no `state=absent` at all. Cancel by hand in the
customer panel. Use `--check` to confirm what a run would order without spending.

## Verify a deployment

```sh
ssh -p 2222 gsh@<ip> systemctl status gameshell-ttyd gameshell-janitor caddy --no-pager
ssh -p 2222 gsh@<ip> 'ss -ltn | grep 7682'   # 127.0.0.1:7682 ONLY, never 0.0.0.0
ssh -p 2222 gsh@<ip> sudo ufw status         # 2222/80/443 only; 7682 absent
```

- Load `https://<domain>` — padlock, GameShell banner, and keystrokes echo
  (proves ttyd got `-W`).
- Two tabs ⇒ two independent games; `docker ps --filter name=^gsh-` shows two.
- Close one tab, wait ~10 s ⇒ that container is gone (proves the janitor).
- Fork bomb `:(){ :|:& };:` in a session ⇒ `Resource temporarily unavailable`
  (proves `--pids-limit 128`).
- `sudo reboot`, wait, reload ⇒ everything returns (proves `enable --now`).

## Relationship to the checked-in `deploy/` files

The playbook **never modifies the working tree**. It renders its own systemd units
and Caddyfile from templates in `playbooks/roles/*/templates/`.

`deploy/systemd/*.service` and `deploy/Caddyfile` keep their literal
`$USER` / `$HOME` / `0.0.0.0` placeholders and remain the manual-install path.
`docs/deploy_gameshell_run_inside_vm.sh` — which `sed`s those files in place — is
superseded by this playbook.
