Running /home/hobs/.bashrc with /usr/bin/bash
# a62e438ec191935dff55f5bf6f55bd91  /home/hobs/.bash_history    55805   143156  1437748 Sun Aug  9 02:38:17 PM PDT 2026 hobs   
# a688c04fbe68fa5a504fbf8fd9ccab09  /home/hobs/.bash_history    55806   143170  1437871
Exporting environment variables within /home/hobs/bin/.bash_env.sh
Exporting UV_PUBLISH_TOKENS (pypi) environment variables in /usr/bin/bash (/home/hobs/bin/.bash_env.sh)

NOT running .workon script found in /home/hobs/.workon
hobs@ai16:~$ ssh gsh
X11 forwarding request failed on channel 0
Welcome to Ubuntu 24.04.1 LTS (GNU/Linux 6.8.0-52-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Sun Aug  9 10:01:05 PM UTC 2026

  System load:  0.02              Processes:             142
  Usage of /:   3.0% of 74.79GB   Users logged in:       0
  Memory usage: 4%                IPv4 address for eth0: 204.168.165.176
  Swap usage:   0%                IPv6 address for eth0: 2a01:4f9:c013:f317::1

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Applications is not enabled.

88 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


*** System restart required ***
Last login: Thu Aug  6 21:31:47 2026 from 70.183.106.164
root@docker-ce-ubuntu-8gb-hel1-1:~# ls GameShell-Browser/
deploy  doc  Dockerfile  i18n  Images  lib  LICENSE  Makefile  man  missions  README-fr.md  README-it.md  README.md  scripts  start.sh  utils
root@docker-ce-ubuntu-8gb-hel1-1:~# cd GameShell-Browser/
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git pull
remote: Enumerating objects: 11, done.
remote: Counting objects: 100% (11/11), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 9 (delta 4), reused 6 (delta 2), pack-reused 0 (from 0)
Unpacking objects: 100% (9/9), 9.26 KiB | 4.63 MiB/s, done.
From https://github.com/aboudia9/GameShell-Browser
   4b67b27..4a3794d  master     -> origin/master
Updating 4b67b27..4a3794d
Fast-forward
 README-Browser.md         | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/browser-deployment.md | 377 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 569 insertions(+)
 create mode 100644 README-Browser.md
 create mode 100644 doc/browser-deployment.md
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git remote add fork git@github.com:GameShell-Browser
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git pull fork main
The authenticity of host 'github.com (140.82.121.4)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git remote add gitlab git@gitlab.com:GameShell-Browser
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# ls ~/.ssh
authorized_keys  known_hosts
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git remote remove gitlab
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git remote remove fork
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git remote rename origin upstream
Renaming remote references: 100% (3/3), done.
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git remote rename fork origin
error: No such remote: 'fork'
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git remote -v
upstream    https://github.com/aboudia9/GameShell-Browser (fetch)
upstream    https://github.com/aboudia9/GameShell-Browser (push)
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git remote add origin https://github.com/hobson/GameShell-Browser
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git pull -u origin main
error: unknown switch `u'
usage: git pull [<options>] [<repository> [<refspec>...]]

    -v, --[no-]verbose    be more verbose
    -q, --[no-]quiet      be more quiet
    --[no-]progress       force progress reporting
    --[no-]recurse-submodules[=<on-demand>]
                          control for recursive fetching of submodules

Options related to merging
    -r, --[no-]rebase[=(false|true|merges|interactive)]
                          incorporate changes by rebasing rather than merging
    -n                    do not show a diffstat at the end of the merge
    --[no-]stat           show a diffstat at the end of the merge
    --[no-]log[=<n>]      add (at most <n>) entries from shortlog to merge commit message
    --[no-]signoff[=...]  add a Signed-off-by trailer
    --[no-]squash         create a single commit instead of doing a merge
    --[no-]commit         perform a commit if the merge succeeds (default)
    --[no-]edit           edit message before committing
    --[no-]cleanup <mode> how to strip spaces and #comments from message
    --[no-]ff             allow fast-forward
    --ff-only             abort if fast-forward is not possible
    --[no-]verify         control use of pre-merge-commit and commit-msg hooks
    --[no-]verify-signatures
                          verify that the named commit has a valid GPG signature
    --[no-]autostash      automatically stash/stash pop before and after
    -s, --[no-]strategy <strategy>
                          merge strategy to use
    -X, --[no-]strategy-option <option=value>
                          option for selected merge strategy
    -S, --[no-]gpg-sign[=<key-id>]
                          GPG sign commit
    --[no-]allow-unrelated-histories
                          allow merging unrelated histories

Options related to fetching
    --[no-]all            fetch from all remotes
    -a, --[no-]append     append to .git/FETCH_HEAD instead of overwriting
    --[no-]upload-pack <path>
                          path to upload pack on remote end
    -f, --[no-]force      force overwrite of local branch
    -t, --[no-]tags       fetch all tags and associated objects
    -p, --[no-]prune      prune remote-tracking branches no longer on remote
    -j, --[no-]jobs[=<n>] number of submodules pulled in parallel
    --[no-]dry-run        dry run
    -k, --[no-]keep       keep downloaded pack
    --[no-]depth <depth>  deepen history of shallow clone
    --[no-]shallow-since <time>
                          deepen history of shallow repository based on time
    --[no-]shallow-exclude <revision>
                          deepen history of shallow clone, excluding rev
    --[no-]deepen <n>     deepen history of shallow clone
    --unshallow           convert to a complete repository
    --[no-]update-shallow accept refs that update .git/shallow
    --refmap <refmap>     specify fetch refmap
    -o, --[no-]server-option <server-specific>
                          option to transmit
    -4, --[no-]ipv4       use IPv4 addresses only
    -6, --[no-]ipv6       use IPv6 addresses only
    --[no-]negotiation-tip <revision>
                          report that we have only objects reachable from this object
    --[no-]show-forced-updates
                          check for forced-updates on all updated branches
    --[no-]set-upstream   set upstream for git pull/fetch

root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git pull origin main
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (1/1), done.
remote: Total 3 (delta 2), reused 3 (delta 2), pack-reused 0 (from 0)
Unpacking objects: 100% (3/3), 289 bytes | 289.00 KiB/s, done.
From https://github.com/hobson/GameShell-Browser
 * branch            main       -> FETCH_HEAD
 * [new branch]      main       -> origin/main
Updating 4a3794d..fb262bf
error: Your local changes to the following files would be overwritten by merge:
    deploy/gsh-serve.sh
Please commit your changes or stash them before you merge.
Aborting
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git status
On branch master
Your branch is up to date with 'upstream/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    modified:   deploy/gsh-serve.sh
    modified:   deploy/systemd/gameshell-janitor.service
    modified:   deploy/systemd/gameshell-ttyd.service

no changes added to commit (use "git add" and/or "git commit -a")
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git checkout -b hobs
Switched to a new branch 'hobs'
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git diff
diff --git a/deploy/gsh-serve.sh b/deploy/gsh-serve.sh
index 56c602e..d28dcab 100644
--- a/deploy/gsh-serve.sh
+++ b/deploy/gsh-serve.sh
@@ -54,6 +54,7 @@ exec ttyd \
     -i "$IFACE" \
     -p "$PORT" \
     -t "theme=${THEME}" \
-    -t fontSize=16 \
+    -t fontSize=14 \
     -t 'titleFixed=GameShell' \
     "$SESSION"
+
diff --git a/deploy/systemd/gameshell-janitor.service b/deploy/systemd/gameshell-janitor.service
old mode 100644
new mode 100755
diff --git a/deploy/systemd/gameshell-ttyd.service b/deploy/systemd/gameshell-ttyd.service
old mode 100644
new mode 100755
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git commit -am 'chmod +x *.service and fontSize=14 (was 16)'
Author identity unknown

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: unable to auto-detect email address (got 'root@docker-ce-ubuntu-8gb-hel1-1.(none)')
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git config --global user.email git@totalgood.com
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git config --global user.name gitter
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git commit -am 'chmod +x *.service and fontSize=14 (was 16)'
[hobs e8a9bd1] chmod +x *.service and fontSize=14 (was 16)
 3 files changed, 2 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 deploy/systemd/gameshell-janitor.service
 mode change 100644 => 100755 deploy/systemd/gameshell-ttyd.service
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git checkout master
Switched to branch 'master'
Your branch is up to date with 'upstream/master'.
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git branch rename master main
usage: git branch [<options>] [-r | -a] [--merged] [--no-merged]
   or: git branch [<options>] [-f] [--recurse-submodules] <branch-name> [<start-point>]
   or: git branch [<options>] [-l] [<pattern>...]
   or: git branch [<options>] [-r] (-d | -D) <branch-name>...
   or: git branch [<options>] (-m | -M) [<old-branch>] <new-branch>
   or: git branch [<options>] (-c | -C) [<old-branch>] <new-branch>
   or: git branch [<options>] [-r | -a] [--points-at]
   or: git branch [<options>] [-r | -a] [--format]

Generic options
    -v, --[no-]verbose    show hash and subject, give twice for upstream branch
    -q, --[no-]quiet      suppress informational messages
    -t, --[no-]track[=(direct|inherit)]
                          set branch tracking configuration
    -u, --[no-]set-upstream-to <upstream>
                          change the upstream info
    --[no-]unset-upstream unset the upstream info
    --[no-]color[=<when>] use colored output
    -r, --remotes         act on remote-tracking branches
    --contains <commit>   print only branches that contain the commit
    --no-contains <commit>
                          print only branches that don't contain the commit
    --[no-]abbrev[=<n>]   use <n> digits to display object names

Specific git-branch actions:
    -a, --all             list both remote-tracking and local branches
    -d, --[no-]delete     delete fully merged branch
    -D                    delete branch (even if not merged)
    -m, --[no-]move       move/rename a branch and its reflog
    -M                    move/rename a branch, even if target exists
    --[no-]omit-empty     do not output a newline after empty formatted refs
    -c, --[no-]copy       copy a branch and its reflog
    -C                    copy a branch, even if target exists
    -l, --[no-]list       list branch names
    --[no-]show-current   show current branch name
    --[no-]create-reflog  create the branch's reflog
    --[no-]edit-description
                          edit the description for the branch
    -f, --[no-]force      force creation, move/rename, deletion
    --merged <commit>     print only branches that are merged
    --no-merged <commit>  print only branches that are not merged
    --[no-]column[=<style>]
                          list branches in columns
    --[no-]sort <key>     field name to sort on
    --[no-]points-at <object>
                          print only branches of the object
    -i, --[no-]ignore-case
                          sorting and filtering are case insensitive
    --[no-]recurse-submodules
                          recurse through submodules
    --[no-]format <format>
                          format to use for the output

root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git branch --move master main
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git pull origin main
From https://github.com/hobson/GameShell-Browser
 * branch            main       -> FETCH_HEAD
Updating 4a3794d..fb262bf
Fast-forward
 deploy/gsh-serve.sh                 | 0
 {doc => docs}/README.md             | 0
 {doc => docs}/browser-deployment.md | 0
 {doc => docs}/deps.md               | 0
 {doc => docs}/dev_manual.md         | 0
 {doc => docs}/faq.md                | 0
 {doc => docs}/gameshell.md          | 0
 {doc => docs}/i18n.md               | 0
 {doc => docs}/misc.md               | 0
 {doc => docs}/mission.md            | 0
 {doc => docs}/mission_ideas.md      | 0
 {doc => docs}/user_manual.md        | 0
 12 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 deploy/gsh-serve.sh
 rename {doc => docs}/README.md (100%)
 rename {doc => docs}/browser-deployment.md (100%)
 rename {doc => docs}/deps.md (100%)
 rename {doc => docs}/dev_manual.md (100%)
 rename {doc => docs}/faq.md (100%)
 rename {doc => docs}/gameshell.md (100%)
 rename {doc => docs}/i18n.md (100%)
 rename {doc => docs}/misc.md (100%)
 rename {doc => docs}/mission.md (100%)
 rename {doc => docs}/mission_ideas.md (100%)
 rename {doc => docs}/user_manual.md (100%)
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git status
On branch main
Your branch is ahead of 'upstream/master' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git log --stat
commit fb262bf5dfa63de1100ab45c463f58ad63588f85 (HEAD -> main, origin/main)
Author: hobs <git@totalgood.com>
Date:   Fri Aug 7 18:23:07 2026 -0700

    +x gsh-serve.sh and mv doc/ docs/

 deploy/gsh-serve.sh                 | 0
 {doc => docs}/README.md             | 0
 {doc => docs}/browser-deployment.md | 0
 {doc => docs}/deps.md               | 0
 {doc => docs}/dev_manual.md         | 0
 {doc => docs}/faq.md                | 0
 {doc => docs}/gameshell.md          | 0
 {doc => docs}/i18n.md               | 0
 {doc => docs}/misc.md               | 0
 {doc => docs}/mission.md            | 0
 {doc => docs}/mission_ideas.md      | 0
 {doc => docs}/user_manual.md        | 0
 12 files changed, 0 insertions(+), 0 deletions(-)

commit 4a3794dfdb3c79d8aa84748af526fc0e83d47ed1 (upstream/master, upstream/HEAD)
Author: Bou <144206699+aboudia9@users.noreply.github.com>
Date:   Fri Aug 7 11:43:07 2026 -0700

    detailed instructions for web deployment

 README-Browser.md         |  22 +++++++++++-
 doc/browser-deployment.md | 377 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/browser_deployment.md |   0
 3 files changed, 398 insertions(+), 1 deletion(-)

commit c70875f66fb560d4bd6da3b63b5f2af37c0a46c1
Author: bou <144206699+aboudia9@users.noreply.github.com>
Date:   Fri Aug 7 10:46:40 2026 -0700

    Added a browser-version README and related browser-deployment doc for deploying on a cloud platform or VM

 README-Browser.md         | 172 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/browser_deployment.md |   0
 2 files changed, 172 insertions(+)

commit 4b67b27687c0a772a8de785ffef21d44304a45cc
Author: Bou <144206699+aboudia9@users.noreply.github.com>
Date:   Wed Jul 29 18:19:02 2026 -0700

    Add Caddy reverse proxy config for gameshell.proai.org

 deploy/Caddyfile | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

commit 506bda89e51f53573430017fcb0098ecb24c4b15
Author: Bou <144206699+aboudia9@users.noreply.github.com>
Date:   Wed Jul 29 12:50:11 2026 -0700

    Add systemd units and ttyd launcher with high-contrast theme
    
    ttyd now binds loopback only; Caddy will be the public listener.

 deploy/gsh-serve.sh                      | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 deploy/systemd/gameshell-janitor.service | 15 +++++++++++++++
 deploy/systemd/gameshell-ttyd.service    | 16 ++++++++++++++++
 3 files changed, 90 insertions(+)

commit d70b32fa596574757ad5c049fc0da9a6eaab2556
Author: Bou <144206699+aboudia9@users.noreply.github.com>
Date:   Tue Jul 28 20:29:50 2026 -0700

    Add browser-session deployment scripts
    
    deploy/gsh-session.sh launches one throwaway container per ttyd connection, with memory/CPU/PID limits and no network access.
    
    deploy/gsh-janitor.sh is an external reaper for abandoned containers -- cleanup can't live inside the session script because ttyd SIGKILLs its process group on disconnect.
    
    Requires: ttyd -W -s 9 deploy/gsh-session.sh

 .gitignore            |  3 +++
 deploy/gsh-janitor.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 deploy/gsh-session.sh | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

commit 53f470d70550c213f70b231eef102cef50d758ee
Author: Rodolphe Lepigre <lepigre@mpi-sws.org>
Date:   Tue May 5 20:59:49 2026 +0200

    Fix #183 (type in mission [misc/02_nano_journal]).

 missions/misc/02_nano_journal/goal/en.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

commit fa175bb26470ce79f9e4c2124e6afa6def52feb7
Author: PH <PH>
Date:   Tue Mar 3 10:49:44 2026 +0100

    bug in missionname function for some dummy missions
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# more README-Browser.md 
GameShell: a "game" to teach the Unix shell
===========================================

![Illustration inspired by the game](Images/illustration-small.png)

Teaching first-year university students or high schoolers to use a Unix shell
is not always the easiest or most entertaining of tasks. GameShell was devised
as a tool to help students at the
[Université Savoie Mont Blanc](https://univ-smb.fr) to engage with a *real*
shell, in a way that encourages learning while also having fun. 

The original idea, due to Rodolphe Lepigre, was to run a standard bash session
with an appropriate configuration file that defined "missions" which would be
"checked" in order to progress through the game.

Here is the result...

![GameShell's first mission](Images/gameshell_first_mission_small.gif)


GameShell is available in English, French and Italian.


Feel free to send us your remarks, questions or suggestions by opening
[issues](https://github.com/phyver/GameShell/issues) or submitting
[pull requests](https://github.com/phyver/GameShell/pulls).
We are particularly interested in any new missions you might create!


Getting started
---------------

GameShell should work on any standard Linux system, and also on macOS and BSD
(but we have run fewer tests on the latter systems). On Debian or Ubuntu, the
only dependencies (besides `bash`) are the `gettext-base` and `awk` packages
(the latter is generally installed by default). Some missions have additional
dependencies: these missions will be skipped if the dependencies are not met.
On Debian or Ubuntu, run the following command to install all game and mission
dependencies.
```sh
$ sudo apt install gettext man-db procps psmisc nano tree ncal x11-apps wget
```
Check the [user manual](doc/user_manual.md) to see how to install the game
dependencies on other systems (macOS, BSD, ...).

Assuming all the dependencies are installed, you can try the latest version of
the game by running the following two commands in a terminal.
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# diff README-Browser.md docs/README-Browser.md 
diff: docs/README-Browser.md: No such file or directory
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# diff README-Browser.md docs/
browser-deployment.md  dev_manual.md          gameshell.md           misc.md                mission.md             user_manual.md         
deps.md                faq.md                 i18n.md                mission_ideas.md       README.md              
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# diff README-Browser.md docs/browser-deployment.md 
1,2c1
< GameShell: a "game" to teach the Unix shell
< ===========================================
---
> # Browser deployment guide
4c3,4
< ![Illustration inspired by the game](Images/illustration-small.png)
---
> How to run GameShell in a web browser, so players need nothing installed but a
> browser and a URL. This is what the `deploy/` directory in this fork is for.
6,10c6,7
< Teaching first-year university students or high schoolers to use a Unix shell
< is not always the easiest or most entertaining of tasks. GameShell was devised
< as a tool to help students at the
< [Université Savoie Mont Blanc](https://univ-smb.fr) to engage with a *real*
< shell, in a way that encourages learning while also having fun. 
---
> Written for someone reproducing the deployment on their own VM. Assumes Ubuntu
> 22.04/24.04 with Docker already installed, and a domain you control.
12,14c9
< The original idea, due to Rodolphe Lepigre, was to run a standard bash session
< with an appropriate configuration file that defined "missions" which would be
< "checked" in order to progress through the game.
---
> ---
16c11
< Here is the result...
---
> ## How it works
18c13,59
< ![GameShell's first mission](Images/gameshell_first_mission_small.gif)
---
> ```
> Player's browser
>       │  https://  (nothing to install)
>       ▼
>    [ Caddy ]          reverse proxy, automatic HTTPS, the only public listener
>       │  127.0.0.1:7682
>       ▼
>    [ ttyd ]           bridges a pseudo-terminal to a WebSocket
>       │  one process per connection
>       ▼
>    [ Docker container ]   fresh, isolated, throwaway GameShell
>       └── dies when the player leaves
> 
>    [ janitor ]        separate service; removes containers nobody is attached to
> ```
> 
> GameShell needs a *real* bash shell, so each player gets a real container. `ttyd`
> streams that container's terminal to the browser, and Caddy puts TLS in front.
> 
> Three things run on the VM, and **all three are required**:
> 
> | Component | What it is |
> |---|---|
> | `gameshell-ttyd.service` | The web terminal (bash shell). Launches one container per connection. |
> | `gameshell-janitor.service` | Cleans up abandoned containers. Not optional — see [Why the janitor exists](#why-the-janitor-exists). |
> | `caddy.service` | HTTPS + reverse proxy. Installed from Caddy's own apt repo. |
> 
> Sessions are intentionally **throwaways**: no progress is saved, and every
> connection starts a fresh game. If a player's terminal resets, they start
> over (or if they type in process-ending commands lol).
> 
> ---
> 
> ## Prerequisites
> 
> - A Linux VM with a public IP. 1 GB RAM is enough to build the image and serve
>   roughly 10-15 concurrent players; see [Capacity](#capacity).
> - Docker installed and running, and your user in the `docker` group.
>   Note that **the `docker` group is effectively root** — anyone in it can mount
>   the host filesystem into a container. Don't hand it out casually.
> - A domain (or subdomain) whose `A` record points at the VM. Required —
>   Let's Encrypt will not issue certificates for a bare IP address.
> - Ports 80 and 443 reachable from the internet.
> 
> ---
> 
> ## 1. Clone and build
19a61,70
> ```sh
> git clone https://github.com/aboudia9/GameShell-Browser.git
> cd GameShell-Browser
> docker build -t gameshell .
> chmod +x deploy/*.sh
> ```
> 
> The image **must** be tagged `gameshell` — `deploy/gsh-session.sh` looks for
> that name. (Can be changed with the `GSH_IMAGE` environment variable if you need a
> different one.)
21c72,73
< GameShell is available in English, French and Italian.
---
> The build prints a `LegacyKeyValueFormat` warning about the `ENV` line in the
> Dockerfile. It is harmless.
22a75
> Verify:
24,27c77,79
< Feel free to send us your remarks, questions or suggestions by opening
< [issues](https://github.com/phyver/GameShell/issues) or submitting
< [pull requests](https://github.com/phyver/GameShell/pulls).
< We are particularly interested in any new missions you might create!
---
> ```sh
> docker images | grep gameshell     # ~356 MB
> ```
28a81
> ---
30,31c83
< Getting started
< ---------------
---
> ## 2. Install ttyd
33,39d84
< GameShell should work on any standard Linux system, and also on macOS and BSD
< (but we have run fewer tests on the latter systems). On Debian or Ubuntu, the
< only dependencies (besides `bash`) are the `gettext-base` and `awk` packages
< (the latter is generally installed by default). Some missions have additional
< dependencies: these missions will be skipped if the dependencies are not met.
< On Debian or Ubuntu, run the following command to install all game and mission
< dependencies.
41c86,106
< $ sudo apt install gettext man-db procps psmisc nano tree ncal x11-apps wget
---
> sudo apt install -y ttyd
> ttyd --version
> ```
> 
> **Must be 1.7.0 or newer.** Older versions lack the `-W` flag, and without it
> the terminal renders correctly but silently ignores everything the player
> types — a fun (confusing) failure to debug.
> 
> ---
> 
> ## 3. Edit the systemd units
> 
> The units in `deploy/systemd/` are checked in with the original author's
> username and paths hardcoded. **Edit both files before installing them.**
> 
> In `deploy/systemd/gameshell-ttyd.service` and
> `deploy/systemd/gameshell-janitor.service`, change:
> 
> ```ini
> User=bou
> ExecStart=/home/bou/GameShell-Browser/deploy/gsh-serve.sh
43,44d107
< Check the [user manual](doc/user_manual.md) to see how to install the game
< dependencies on other systems (macOS, BSD, ...).
46,47c109,115
< Assuming all the dependencies are installed, you can try the latest version of
< the game by running the following two commands in a terminal.
---
> to your username and the path where you cloned the repo. The `User=` must be an
> account in the `docker` group. Do NOT run these as root.
> 
> ---
> 
> ## 4. Install and start the services
> 
49,50c117,119
< $ wget https://github.com/phyver/GameShell/releases/download/latest/gameshell.sh
< $ bash gameshell.sh
---
> sudo cp deploy/systemd/*.service /etc/systemd/system/
> sudo systemctl daemon-reload
> sudo systemctl enable --now gameshell-janitor.service gameshell-ttyd.service
52,55d120
< The first command will download the latest version of the game in the form of
< a self-extracting archive, and the second command will initialise and run the
< game from the downloaded archive. Instructions on how to play are provided in
< the game directly.
57,59c122,124
< Note that when you quit the game (with `control-d` or the command `gsh exit`)
< your progression will be saved in a new archive (called `gameshell-save.sh`).
< Run this archive to resume the game where you left it.
---
> `daemon-reload` is required — systemd caches unit files and will not notice new
> or edited ones without it. This is the most common reason a unit change appears
> to do nothing.
60a126,129
> `enable --now` both starts the service immediately and registers it to start at
> boot.
> 
> Check:
62,63d130
< If you prefer not running foreign shell scripts on your computer, you can
< generate a Docker image with the following:
65,68c132
< $ mkdir GameShell; cd GameShell
< $ wget --quiet https://github.com/phyver/GameShell/releases/download/latest/Dockerfile
< $ docker build -t gsh .
< $ docker run -it gsh
---
> systemctl status gameshell-ttyd.service gameshell-janitor.service --no-pager
70,73d133
< The game will NOT be saved when you exit, and additional flags are required if
< you want to run X programs from inside GameShell. Refer to [this
< section](./doc/deps.md#running-GameShell-from-a-docker-container) of the user
< manual.
74a135
> Both should report `active (running)`, and ttyd's line should say `enabled`.
76,77c137
< Playing in a browser
< --------------------
---
> ---
79,84c139
< **This fork adds browser-based deployment.** Alongside the original game, it
< includes tooling to serve GameShell over the web, so players need nothing
< installed — just a browser and a URL. Each connection gets its own throwaway
< Docker container running a real bash shell, streamed to the browser by
< [ttyd](https://github.com/tsl0922/ttyd), with [Caddy](https://caddyserver.com)
< providing automatic HTTPS.
---
> ## 5. Install Caddy
86,87c141,142
< This was built to give first-year CS students a zero-setup way to reach a real
< shell, since installation is often the first thing that stops them.
---
> Caddy is not in Ubuntu's default repositories. From
> [Caddy's official instructions](https://caddyserver.com/docs/install#debian-ubuntu-raspbian):
89,90c144,152
< See **[browser-deployment.md](browser-deployment.md)** for the full deployment
< guide, and `deploy/` for the scripts, systemd units, and Caddy config.
---
> ```sh
> sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
> curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' \
>   | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
> curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' \
>   | sudo tee /etc/apt/sources.list.d/caddy-stable.list
> sudo apt update
> sudo apt install -y caddy
> ```
92,93c154
< Everything else in this repository is unchanged from
< [upstream](https://github.com/phyver/GameShell).
---
> ---
94a156
> ## 6. Configure Caddy
96,97c158
< Github Codespaces (or VSCode)
< -----------------------------
---
> Edit `deploy/Caddyfile` and replace the hostname with your own:
99c160,164
< [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/phyver/GameShell)
---
> ```
> your.domain.here {
>   reverse_proxy 127.0.0.1:7682
> }
> ```
101,103c166
< This repository is configured to work with the Visual Studio Code
< [Dev Container](https://containers.dev/) extension, which enables GameShell to
< be run from a [Github Codespace](https://github.com/features/codespaces).
---
> Then install and reload:
105,106d167
< Once the Codespace is launched (via the above badge), you can run GameShell in
< the terminal with the following command.
108c169,170
< bash start.sh
---
> sudo cp deploy/Caddyfile /etc/caddy/Caddyfile
> sudo systemctl reload caddy
110,111c172,183
< An alternative language can be selected using the `-L` option. For example,
< the following command will start the game in Italian.
---
> 
> Use `reload`, not `restart` — it applies config gracefully without dropping live
> sessions, and it refuses to apply a config that fails to parse rather than
> taking the site down.
> 
> Caddy obtains and renews the TLS certificate automatically, redirects HTTP to
> HTTPS, and handles ttyd's WebSocket upgrade. None of that needs configuring.
> 
> ---
> 
> ## 7. Firewall
> 
113c185,188
< bash start.sh -L it
---
> sudo ufw allow OpenSSH
> sudo ufw allow 80/tcp
> sudo ufw allow 443/tcp
> sudo ufw enable
116,117c191
< To get the same experience on your local machine without the limitations/cost
< of Codespaces see the [Dev Container docs](https://containers.dev/supporting#tools).
---
> Always allow SSH **before** enabling `ufw`, or you will lock yourself out.
119,120c193,195
< Documentation
< -------------
---
> **Do not open port 7682.** ttyd binds to loopback only (`-i lo`), so Caddy is
> the sole public entrance. Exposing 7682 would publish an unauthenticated
> terminal directly to the internet.
122,129c197
< To find out more about GameShell, refer to the following documents:
< - The [user manual](doc/user_manual.md) provides information on how to run the
<   game on all supported platforms (Linux, macOS, BSD), explains how to run the
<   game from the sources, tells you how to generate custom game archives (which
<   is useful if you want to use GameShell for teaching a class), and more.
< - The [developer manual](doc/dev_manual.md) provides information on how to
<   create new missions, how to translate missions, and how to participate
<   in the development of the game.
---
> ---
130a199
> ## Verifying it works
132,133c201,203
< Who is developing GameShell?
< ----------------------------
---
> 1. Browse to `https://your.domain.here` — GameShell should load, with a padlock.
> 2. Open a second tab. Confirm two independent games.
> 3. Close one tab, wait ~10 seconds, then on the VM:
135c205,207
< ### Developers
---
>    ```sh
>    docker ps --filter "name=^gsh-"
>    ```
137,140c209,210
< The game is currently being developed by:
< * [Pierre Hyvernat](http://www.lama.univ-smb.fr/~hyvernat) (main developer,
<   [pierre.hyvernat@univ-smb.fr](mailto:pierre.hyvernat@univ-smb.fr)),
< * [Rodolphe Lepigre](https://lepigre.fr).
---
>    The closed session's container should be gone. If it is still listed, the
>    janitor is not running.
142c212
< ### Mission contributors
---
> 4. Reboot the VM. Everything should come back with no manual intervention.
144,150c214
< * Pierre Hyvernat
< * Rodolphe Lepigre
< * Christophe Raffalli
< * Xavier Provencal
< * Clovis Eberhart
< * Sébastien Tavenas
< * Tiemen Duvillard
---
> Optional stress check — from inside a game session, run a fork bomb:
152c216,218
< ### Translation
---
> ```sh
> :(){ :|:& };:
> ```
154c220,221
< #### Italian Version
---
> It should fizzle with `Resource temporarily unavailable` rather than affecting
> the host. That is `--pids-limit` doing its job.
156,167c223
< * Daniele Scasciafratte (@mte90)
< * Paolo Mauri (@maupao)
< * Marco Ciampa (@ciampix)
< * Antonio Vivace (@avivace)
< * Lorenzo Millucci (@lmillucci)
< * Sirio Negri (@ziriuz84)
< * Domenico Mammola (@domenicomammola)
< * Leonardo Canello (@anulo2)
< * @michirod
< * @serhack
< * WhiteShield (@wshield05)
< * @gioisco
---
> ---
169c225
< ### Special thanks
---
> ## Configuration
171,173c227
< * All the students who found *many* bugs in the early versions.
< * Joan Stark (a.k.a, jgs), who designed hundreds of ASCII-art pieces in the
<   late 90s. Most of the ASCII-art encountered in GameShell are due to her.
---
> `deploy/gsh-session.sh` — per-player container:
174a229,235
> | Flag | Purpose |
> |---|---|
> | `--rm` | Throwaway. No saved progress by design. |
> | `--memory 256m` | Ceiling, not a reservation. Real usage is ~30 MB. |
> | `--cpus 0.5` | One player cannot starve the others. |
> | `--network none` | No network inside the game. Verified: no mission needs it. |
> | `--pids-limit 128` | Fork-bomb protection. Generous for legitimate play. |
176,177c237,240
< Licence
< -------
---
> `deploy/gsh-serve.sh` — the ttyd invocation. Environment variables `GSH_PORT`
> (default 7682) and `GSH_IFACE` (default `lo`). Also contains the high-contrast
> terminal theme and font size, kept here rather than in the systemd unit so the
> JSON is version-controlled and safe from systemd's quoting rules.
179c242,243
< GameShell is released under the [GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html).
---
> `deploy/gsh-janitor.sh` — the reaper. `GSH_JANITOR_INTERVAL` (default 5 seconds)
> controls poll frequency. It only ever touches containers named `gsh-*`.
181c245
< Please link to this repository if you use GameShell.
---
> ---
183,184c247
< GameShell is open source and free to use. One way you can acknowledge the work
< it required is by sending an actual postcard to
---
> ## Operations
185a249,265
> ```sh
> # Logs
> sudo journalctl -u gameshell-ttyd -n 50 --no-pager
> sudo journalctl -u gameshell-janitor -f      # follow reaping live
> sudo journalctl -u caddy -n 50 --no-pager    # certificate problems show here
> 
> # Restart after changing a script
> sudo systemctl restart gameshell-ttyd
> 
> # Restart after editing a unit file
> sudo systemctl daemon-reload && sudo systemctl restart gameshell-ttyd
> 
> # Update to a newer version of the game
> cd ~/GameShell-Browser
> git pull
> docker build -t gameshell .
> sudo systemctl restart gameshell-ttyd
187,191c267,278
<   Pierre Hyvernat
<   Laboratoire de Mathématiques, CNRS UMR 5127
<   Université de Savoie
<   73376 Le Bourget du Lac
<   FRANCE
---
> 
> Rebuilding the image does not disturb players already connected — running
> containers keep using the old image layers until they exit.
> 
> ### Testing without exposing anything
> 
> To reach ttyd directly while Caddy is not yet configured, tunnel over SSH
> rather than opening the port:
> 
> ```sh
> ssh -L 7682:127.0.0.1:7682 user@your-vm
> # then browse to http://localhost:7682
192a280,377
> 
> ---
> 
> ## Capacity
> 
> Ubuntu plus Docker use roughly 450 MB. Each real session uses ~30 MB, not the
> 256 MB ceiling. On a 1 GB VM that works out to somewhere around 15–18
> concurrent players before swapping starts.
> 
> There is currently **no cap on concurrent sessions** — see
> [Known limitations](#known-limitations).
> 
> If you need more capacity, resizing RAM and CPU is straightforward on most
> cloud providers. Note that on DigitalOcean specifically, growing a disk is
> permanent — disks cannot be shrunk — so prefer the "CPU and RAM only" resize.
> 
> ---
> 
> ## Why the janitor exists
> 
> Worth understanding before assuming it is redundant, because three intuitive
> approaches all fail:
> 
> 1. **Killing the `docker run` client does not stop the container.** The client
>    is only a remote control. When a player closes their tab, ttyd kills the
>    client and the container keeps running indefinitely.
> 
> 2. **ttyd's default kill signal is SIGHUP, which the Docker CLI ignores.**
>    Without `-s 9` (SIGKILL) in `gsh-serve.sh`, sessions never terminate at all.
> 
> 3. **Cleanup cannot live inside the session script.** Two separate reasons:
>    trapping `HUP` makes bash *survive* the signal, which keeps the session alive
>    and defeats the purpose; and ttyd SIGKILLs its entire process group, so any
>    watchdog the script spawns dies with it. `nohup` does not help (it blocks
>    SIGHUP, not SIGKILL).
> 
> Hence an external service. The janitor lists `gsh-*` containers and removes any
> with no live `docker run` client, from outside ttyd's process group where
> nothing can kill it.
> 
> Also relevant: `docker run --rm` is not fully reliable when a container's main
> process dies messily. The janitor covers that gap too.
> 
> ---
> 
> ## Troubleshooting
> 
> **Terminal loads but typing does nothing.**
> ttyd is missing `-W`, or is older than 1.7.
> 
> **Browser reconnects in a loop; logs show the process exiting within
> milliseconds.**
> ttyd cannot execute the script. Almost always a wrong path or a missing
> executable bit. Check `ExecStart=` in the unit and run `chmod +x deploy/*.sh`.
> 
> **`lws_socket_bind: ERROR on binding fd ... to port 7682 (-1 98)`.**
> Error 98 is "address already in use" — something else holds that port. Check
> with `pgrep -a ttyd` before killing anything. On DigitalOcean droplets, the
> `droplet-agent` runs its own ttyd on `127.0.0.1:7681` to power the dashboard's
> web console; **do not kill it**, that console is out-of-band recovery access if
> SSH ever breaks. This is why the default port here is 7682.
> 
> **Containers accumulate and are never removed.**
> The janitor is not running, or its `User=` is not in the `docker` group.
> Check `systemctl status gameshell-janitor`.
> 
> **Caddy cannot obtain a certificate.**
> Check `journalctl -u caddy`. Usual causes: the domain's `A` record does not
> point at this VM, port 80 is not reachable, or the DNS is behind a proxy. If
> DNS is on Cloudflare, the record must be **DNS only (grey cloud)** — proxying
> terminates TLS at Cloudflare and breaks the ACME challenge.
> 
> **DNS edits appear to work but nothing resolves.**
> The zone you edited may not be authoritative. Verify with
> `dig +short NS your-domain @1.1.1.1` and confirm the nameservers belong to the
> provider whose panel you edited. A correct answer from
> `dig +short your.domain @1.1.1.1` is proof the record is live.
> 
> **`channel N: open failed: connect failed` spam in an SSH session.**
> Harmless. An SSH port-forward's target is down — usually a stale browser tab
> retrying against a tunnel.
> 
> ---
> 
> ## Known limitations
> 
> - **No cap on concurrent sessions.** Nothing prevents more players than the VM
>   can handle from connecting. Planned.
> - **No maximum session lifetime.** A player who leaves a tab open indefinitely
>   holds a container indefinitely — the janitor only reaps sessions whose client
>   has disconnected. Planned.
> - **No authentication.** Anyone with the URL can start a session. This is a
>   deliberate choice for a classroom tool, and it rests on the container
>   sandboxing: non-root, no network, memory- and PID-capped, throwaway. Add
>   Caddy's `basic_auth` directive if your situation differs.
> - **The `intermediate/04_bg_xeyes` mission cannot work.** It runs `xeyes`, an
>   X11 graphical program, which has no display in a headless container.
> - **No saved progress.** By design, but worth telling players explicitly.
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# more README-Browser.md 
GameShell: a "game" to teach the Unix shell
===========================================

![Illustration inspired by the game](Images/illustration-small.png)

Teaching first-year university students or high schoolers to use a Unix shell
is not always the easiest or most entertaining of tasks. GameShell was devised
as a tool to help students at the
[Université Savoie Mont Blanc](https://univ-smb.fr) to engage with a *real*
shell, in a way that encourages learning while also having fun. 

The original idea, due to Rodolphe Lepigre, was to run a standard bash session
with an appropriate configuration file that defined "missions" which would be
"checked" in order to progress through the game.

Here is the result...

![GameShell's first mission](Images/gameshell_first_mission_small.gif)


GameShell is available in English, French and Italian.


Feel free to send us your remarks, questions or suggestions by opening
[issues](https://github.com/phyver/GameShell/issues) or submitting
[pull requests](https://github.com/phyver/GameShell/pulls).
We are particularly interested in any new missions you might create!


Getting started
---------------

GameShell should work on any standard Linux system, and also on macOS and BSD
(but we have run fewer tests on the latter systems). On Debian or Ubuntu, the
only dependencies (besides `bash`) are the `gettext-base` and `awk` packages
(the latter is generally installed by default). Some missions have additional
dependencies: these missions will be skipped if the dependencies are not met.
On Debian or Ubuntu, run the following command to install all game and mission
dependencies.
```sh
$ sudo apt install gettext man-db procps psmisc nano tree ncal x11-apps wget
```
Check the [user manual](doc/user_manual.md) to see how to install the game
dependencies on other systems (macOS, BSD, ...).

Assuming all the dependencies are installed, you can try the latest version of
the game by running the following two commands in a terminal.
```sh
$ wget https://github.com/phyver/GameShell/releases/download/latest/gameshell.sh
$ bash gameshell.sh
```
The first command will download the latest version of the game in the form of
a self-extracting archive, and the second command will initialise and run the
game from the downloaded archive. Instructions on how to play are provided in
the game directly.

Note that when you quit the game (with `control-d` or the command `gsh exit`)
your progression will be saved in a new archive (called `gameshell-save.sh`).
Run this archive to resume the game where you left it.


If you prefer not running foreign shell scripts on your computer, you can
generate a Docker image with the following:
```sh
$ mkdir GameShell; cd GameShell
$ wget --quiet https://github.com/phyver/GameShell/releases/download/latest/Dockerfile
$ docker build -t gsh .
$ docker run -it gsh
```
The game will NOT be saved when you exit, and additional flags are required if
you want to run X programs from inside GameShell. Refer to [this
section](./doc/deps.md#running-GameShell-from-a-docker-container) of the user
manual.


Playing in a browser
--------------------

**This fork adds browser-based deployment.** Alongside the original game, it
includes tooling to serve GameShell over the web, so players need nothing
installed — just a browser and a URL. Each connection gets its own throwaway
Docker container running a real bash shell, streamed to the browser by
[ttyd](https://github.com/tsl0922/ttyd), with [Caddy](https://caddyserver.com)
providing automatic HTTPS.

This was built to give first-year CS students a zero-setup way to reach a real
shell, since installation is often the first thing that stops them.

See **[browser-deployment.md](browser-deployment.md)** for the full deployment
guide, and `deploy/` for the scripts, systemd units, and Caddy config.

Everything else in this repository is unchanged from
[upstream](https://github.com/phyver/GameShell).

root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# diff docs/browser-deployment.md 
diff: missing operand after 'docs/browser-deployment.md'
diff: Try 'diff --help' for more information.
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# more docs/browser-deployment.md 
# Browser deployment guide

How to run GameShell in a web browser, so players need nothing installed but a
browser and a URL. This is what the `deploy/` directory in this fork is for.

Written for someone reproducing the deployment on their own VM. Assumes Ubuntu
22.04/24.04 with Docker already installed, and a domain you control.

---

## How it works

```
Player's browser
      │  https://  (nothing to install)
      ▼
   [ Caddy ]          reverse proxy, automatic HTTPS, the only public listener
      │  127.0.0.1:7682
      ▼
   [ ttyd ]           bridges a pseudo-terminal to a WebSocket
      │  one process per connection
      ▼
   [ Docker container ]   fresh, isolated, throwaway GameShell
      └── dies when the player leaves

   [ janitor ]        separate service; removes containers nobody is attached to
```

GameShell needs a *real* bash shell, so each player gets a real container. `ttyd`
streams that container's terminal to the browser, and Caddy puts TLS in front.

Three things run on the VM, and **all three are required**:

| Component | What it is |
|---|---|
| `gameshell-ttyd.service` | The web terminal (bash shell). Launches one container per connection. |
| `gameshell-janitor.service` | Cleans up abandoned containers. Not optional — see [Why the janitor exists](#why-the-janitor-exists). |
| `caddy.service` | HTTPS + reverse proxy. Installed from Caddy's own apt repo. |

Sessions are intentionally **throwaways**: no progress is saved, and every
connection starts a fresh game. If a player's terminal resets, they start
over (or if they type in process-ending commands lol).

---

## Prerequisites

root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# more docs/browser-deployment.md 
# Browser deployment guide

How to run GameShell in a web browser, so players need nothing installed but a
browser and a URL. This is what the `deploy/` directory in this fork is for.

Written for someone reproducing the deployment on their own VM. Assumes Ubuntu
22.04/24.04 with Docker already installed, and a domain you control.

---

## How it works

```
Player's browser
      │  https://  (nothing to install)
      ▼
   [ Caddy ]          reverse proxy, automatic HTTPS, the only public listener
      │  127.0.0.1:7682
      ▼
   [ ttyd ]           bridges a pseudo-terminal to a WebSocket
      │  one process per connection
      ▼
   [ Docker container ]   fresh, isolated, throwaway GameShell
      └── dies when the player leaves

   [ janitor ]        separate service; removes containers nobody is attached to
```

GameShell needs a *real* bash shell, so each player gets a real container. `ttyd`
streams that container's terminal to the browser, and Caddy puts TLS in front.

Three things run on the VM, and **all three are required**:

| Component | What it is |
|---|---|
| `gameshell-ttyd.service` | The web terminal (bash shell). Launches one container per connection. |
| `gameshell-janitor.service` | Cleans up abandoned containers. Not optional — see [Why the janitor exists](#why-the-janitor-exists). |
| `caddy.service` | HTTPS + reverse proxy. Installed from Caddy's own apt repo. |

Sessions are intentionally **throwaways**: no progress is saved, and every
connection starts a fresh game. If a player's terminal resets, they start
over (or if they type in process-ending commands lol).

---

## Prerequisites

- A Linux VM with a public IP. 1 GB RAM is enough to build the image and serve
  roughly 10-15 concurrent players; see [Capacity](#capacity).
- Docker installed and running, and your user in the `docker` group.
  Note that **the `docker` group is effectively root** — anyone in it can mount
  the host filesystem into a container. Don't hand it out casually.
- A domain (or subdomain) whose `A` record points at the VM. Required —
  Let's Encrypt will not issue certificates for a bare IP address.
- Ports 80 and 443 reachable from the internet.

---

## 1. Clone and build

```sh
git clone https://github.com/aboudia9/GameShell-Browser.git
cd GameShell-Browser
docker build -t gameshell .
chmod +x deploy/*.sh
```

The image **must** be tagged `gameshell` — `deploy/gsh-session.sh` looks for
that name. (Can be changed with the `GSH_IMAGE` environment variable if you need a
different one.)

The build prints a `LegacyKeyValueFormat` warning about the `ENV` line in the
Dockerfile. It is harmless.

Verify:

```sh
docker images | grep gameshell     # ~356 MB
```

---

## 2. Install ttyd

```sh
sudo apt install -y ttyd
ttyd --version
```

**Must be 1.7.0 or newer.** Older versions lack the `-W` flag, and without it
the terminal renders correctly but silently ignores everything the player
types — a fun (confusing) failure to debug.

---
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# docker build -t gameshell .
# chmod +x deploy/*.sh
[+] Building 1.2s (19/19) FINISHED                                                                                                                                                                                 docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                                                         0.0s
 => => transferring dockerfile: 1.32kB                                                                                                                                                                                       0.0s
 => [internal] load metadata for docker.io/library/debian:stable                                                                                                                                                             0.7s
 => [internal] load .dockerignore                                                                                                                                                                                            0.0s
 => => transferring context: 2B                                                                                                                                                                                              0.0s
 => [ 1/14] FROM docker.io/library/debian:stable@sha256:a317324860a60f88f98be05d1cab92f2262ef03884d1a6d7894894732ac9eb42                                                                                                     0.0s
 => [14/14] ADD --chown=gsh-user:gsh-user https://github.com/phyver/GameShell/releases/download/latest/gameshell.sh gameshell.sh                                                                                             0.4s
 => CACHED [ 2/14] RUN apt update                                                                                                                                                                                            0.0s
 => CACHED [ 3/14] RUN apt install --no-install-recommends --assume-yes     locales     gettext     man-db     psmisc     procps     nano     tree     ncal     x11-apps                                                     0.0s
 => CACHED [ 4/14] RUN apt clean                                                                                                                                                                                             0.0s
 => CACHED [ 5/14] RUN rm -rf /var/lib/apt/lists/*                                                                                                                                                                           0.0s
 => CACHED [ 6/14] RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen                                                                                                                                                    0.0s
 => CACHED [ 7/14] RUN sed -i 's/^# *\(fr_FR.UTF-8\)/\1/' /etc/locale.gen                                                                                                                                                    0.0s
 => CACHED [ 8/14] RUN sed -i 's/^# *\(it_IT.UTF-8\)/\1/' /etc/locale.gen                                                                                                                                                    0.0s
 => CACHED [ 9/14] RUN locale-gen                                                                                                                                                                                            0.0s
 => CACHED [10/14] RUN update-locale LANG=en_US.UTF-8                                                                                                                                                                        0.0s
 => CACHED [11/14] RUN groupadd -g 1000 gsh-user                                                                                                                                                                             0.0s
 => CACHED [12/14] RUN useradd -u 1000 -g gsh-user -s /bin/sh -m gsh-user # <--- the '-m' create a user home directory                                                                                                       0.0s
 => CACHED [13/14] WORKDIR /home/gsh-user                                                                                                                                                                                    0.0s
 => CACHED [14/14] ADD --chown=gsh-user:gsh-user https://github.com/phyver/GameShell/releases/download/latest/gameshell.sh gameshell.sh                                                                                      0.0s
 => exporting to image                                                                                                                                                                                                       0.0s
 => => exporting layers                                                                                                                                                                                                      0.0s
 => => writing image sha256:ef1c257ac0608bdfc6a846ff2411fe4fd28f9698c7f9dd7a4a911fb58d63aee1                                                                                                                                 0.0s
 => => naming to docker.io/library/gameshell                                                                                                                                                                                 0.0s

 1 warning found (use docker --debug to expand):
 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 26)
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# ls -hal deploy/*.sh
-rwxr-xr-x 1 root root 1.6K Aug  6 21:03 deploy/gsh-janitor.sh
-rwxr-xr-x 1 root root 1.9K Aug  9 22:12 deploy/gsh-serve.sh
-rwxr-xr-x 1 root root 1.2K Aug  6 21:03 deploy/gsh-session.sh
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# more docs/browser-deployment.md 
# Browser deployment guide

How to run GameShell in a web browser, so players need nothing installed but a
browser and a URL. This is what the `deploy/` directory in this fork is for.

Written for someone reproducing the deployment on their own VM. Assumes Ubuntu
22.04/24.04 with Docker already installed, and a domain you control.

---

## How it works

```
Player's browser
      │  https://  (nothing to install)
      ▼
   [ Caddy ]          reverse proxy, automatic HTTPS, the only public listener
      │  127.0.0.1:7682
      ▼
   [ ttyd ]           bridges a pseudo-terminal to a WebSocket
      │  one process per connection
      ▼
   [ Docker container ]   fresh, isolated, throwaway GameShell
      └── dies when the player leaves

   [ janitor ]        separate service; removes containers nobody is attached to
```

GameShell needs a *real* bash shell, so each player gets a real container. `ttyd`
streams that container's terminal to the browser, and Caddy puts TLS in front.

Three things run on the VM, and **all three are required**:

| Component | What it is |
|---|---|
| `gameshell-ttyd.service` | The web terminal (bash shell). Launches one container per connection. |
| `gameshell-janitor.service` | Cleans up abandoned containers. Not optional — see [Why the janitor exists](#why-the-janitor-exists). |
| `caddy.service` | HTTPS + reverse proxy. Installed from Caddy's own apt repo. |

Sessions are intentionally **throwaways**: no progress is saved, and every
connection starts a fresh game. If a player's terminal resets, they start
over (or if they type in process-ending commands lol).

---

## Prerequisites

- A Linux VM with a public IP. 1 GB RAM is enough to build the image and serve
  roughly 10-15 concurrent players; see [Capacity](#capacity).
- Docker installed and running, and your user in the `docker` group.
  Note that **the `docker` group is effectively root** — anyone in it can mount
  the host filesystem into a container. Don't hand it out casually.
- A domain (or subdomain) whose `A` record points at the VM. Required —
  Let's Encrypt will not issue certificates for a bare IP address.
- Ports 80 and 443 reachable from the internet.

---

## 1. Clone and build

```sh
git clone https://github.com/aboudia9/GameShell-Browser.git
cd GameShell-Browser
docker build -t gameshell .
chmod +x deploy/*.sh
```

The image **must** be tagged `gameshell` — `deploy/gsh-session.sh` looks for
that name. (Can be changed with the `GSH_IMAGE` environment variable if you need a
different one.)

The build prints a `LegacyKeyValueFormat` warning about the `ENV` line in the
Dockerfile. It is harmless.

Verify:

```sh
docker images | grep gameshell     # ~356 MB
```

---

## 2. Install ttyd

```sh
sudo apt install -y ttyd
ttyd --version
```

**Must be 1.7.0 or newer.** Older versions lack the `-W` flag, and without it
the terminal renders correctly but silently ignores everything the player
types — a fun (confusing) failure to debug.

---
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# docker images | grep gameshell
gameshell    latest    ef1c257ac060   3 days ago   211MB
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# sudo apt install -y ttyd
ttyd --version
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libwebsockets-evlib-uv libwebsockets19t64
Suggested packages:
  apache2
The following NEW packages will be installed:
  libwebsockets-evlib-uv libwebsockets19t64 ttyd
0 upgraded, 3 newly installed, 0 to remove and 94 not upgraded.
Need to get 644 kB of archives.
After this operation, 1,296 kB of additional disk space will be used.
Get:1 https://mirror.hetzner.com/ubuntu/packages noble/universe amd64 libwebsockets19t64 amd64 4.3.3-1.1build3 [229 kB]
Get:2 https://mirror.hetzner.com/ubuntu/packages noble/universe amd64 libwebsockets-evlib-uv amd64 4.3.3-1.1build3 [12.4 kB]
Get:3 https://mirror.hetzner.com/ubuntu/packages noble/universe amd64 ttyd amd64 1.7.4-1build2 [403 kB]
Fetched 644 kB in 0s (2,284 kB/s)
Selecting previously unselected package libwebsockets19t64:amd64.
(Reading database ... 39881 files and directories currently installed.)
Preparing to unpack .../libwebsockets19t64_4.3.3-1.1build3_amd64.deb ...
Unpacking libwebsockets19t64:amd64 (4.3.3-1.1build3) ...
Selecting previously unselected package libwebsockets-evlib-uv:amd64.
Preparing to unpack .../libwebsockets-evlib-uv_4.3.3-1.1build3_amd64.deb ...
Unpacking libwebsockets-evlib-uv:amd64 (4.3.3-1.1build3) ...
Selecting previously unselected package ttyd.
Preparing to unpack .../ttyd_1.7.4-1build2_amd64.deb ...
Unpacking ttyd (1.7.4-1build2) ...
Setting up libwebsockets19t64:amd64 (4.3.3-1.1build3) ...
Setting up libwebsockets-evlib-uv:amd64 (4.3.3-1.1build3) ...
Setting up ttyd (1.7.4-1build2) ...
Created symlink /etc/systemd/system/multi-user.target.wants/ttyd.service → /usr/lib/systemd/system/ttyd.service.
Processing triggers for man-db (2.12.0-4build2) ...
Processing triggers for libc-bin (2.39-0ubuntu8.8) ...
Scanning processes...                                                                                                                                                                                                             
Scanning candidates...                                                                                                                                                                                                            
Scanning linux images...                                                                                                                                                                                                          

Pending kernel upgrade!
Running kernel version:
  6.8.0-52-generic
Diagnostics:
  The currently running kernel version is not the expected kernel version 6.8.0-137-generic.

Restarting the system to load the new kernel will not be handled automatically, so you should consider rebooting.

Restarting services...

Service restarts being deferred:
 /etc/needrestart/restart.d/dbus.service
 systemctl restart docker.service
 systemctl restart getty@tty1.service
 systemctl restart serial-getty@ttyS0.service
 systemctl restart systemd-logind.service
 systemctl restart unattended-upgrades.service

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
ttyd version 1.7.4
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# more docs/browser-deployment.md 
# Browser deployment guide

How to run GameShell in a web browser, so players need nothing installed but a
browser and a URL. This is what the `deploy/` directory in this fork is for.

Written for someone reproducing the deployment on their own VM. Assumes Ubuntu
22.04/24.04 with Docker already installed, and a domain you control.

---

## How it works

```
Player's browser
      │  https://  (nothing to install)
      ▼
   [ Caddy ]          reverse proxy, automatic HTTPS, the only public listener
      │  127.0.0.1:7682
      ▼
   [ ttyd ]           bridges a pseudo-terminal to a WebSocket
      │  one process per connection
      ▼
   [ Docker container ]   fresh, isolated, throwaway GameShell
      └── dies when the player leaves

   [ janitor ]        separate service; removes containers nobody is attached to
```

GameShell needs a *real* bash shell, so each player gets a real container. `ttyd`
streams that container's terminal to the browser, and Caddy puts TLS in front.

Three things run on the VM, and **all three are required**:

| Component | What it is |
|---|---|
| `gameshell-ttyd.service` | The web terminal (bash shell). Launches one container per connection. |
| `gameshell-janitor.service` | Cleans up abandoned containers. Not optional — see [Why the janitor exists](#why-the-janitor-exists). |
| `caddy.service` | HTTPS + reverse proxy. Installed from Caddy's own apt repo. |

Sessions are intentionally **throwaways**: no progress is saved, and every
connection starts a fresh game. If a player's terminal resets, they start
over (or if they type in process-ending commands lol).

---

## Prerequisites

- A Linux VM with a public IP. 1 GB RAM is enough to build the image and serve
  roughly 10-15 concurrent players; see [Capacity](#capacity).
- Docker installed and running, and your user in the `docker` group.
  Note that **the `docker` group is effectively root** — anyone in it can mount
  the host filesystem into a container. Don't hand it out casually.
- A domain (or subdomain) whose `A` record points at the VM. Required —
  Let's Encrypt will not issue certificates for a bare IP address.
- Ports 80 and 443 reachable from the internet.

---

## 1. Clone and build

```sh
git clone https://github.com/aboudia9/GameShell-Browser.git
cd GameShell-Browser
docker build -t gameshell .
chmod +x deploy/*.sh
```

The image **must** be tagged `gameshell` — `deploy/gsh-session.sh` looks for
that name. (Can be changed with the `GSH_IMAGE` environment variable if you need a
different one.)

The build prints a `LegacyKeyValueFormat` warning about the `ENV` line in the
Dockerfile. It is harmless.

Verify:

```sh
docker images | grep gameshell     # ~356 MB
```

---

## 2. Install ttyd

```sh
sudo apt install -y ttyd
ttyd --version
```

**Must be 1.7.0 or newer.** Older versions lack the `-W` flag, and without it
the terminal renders correctly but silently ignores everything the player
types — a fun (confusing) failure to debug.

---

## 3. Edit the systemd units

The units in `deploy/systemd/` are checked in with the original author's
username and paths hardcoded. **Edit both files before installing them.**

In `deploy/systemd/gameshell-ttyd.service` and
`deploy/systemd/gameshell-janitor.service`, change:

```ini
User=bou
ExecStart=/home/bou/GameShell-Browser/deploy/gsh-serve.sh
```

to your username and the path where you cloned the repo. The `User=` must be an
account in the `docker` group. Do NOT run these as root.

---

## 4. Install and start the services

```sh
sudo cp deploy/systemd/*.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now gameshell-janitor.service gameshell-ttyd.service
```

`daemon-reload` is required — systemd caches unit files and will not notice new
or edited ones without it. This is the most common reason a unit change appears
to do nothing.

`enable --now` both starts the service immediately and registers it to start at
boot.

Check:

```sh
systemctl status gameshell-ttyd.service gameshell-janitor.service --no-pager
```

Both should report `active (running)`, and ttyd's line should say `enabled`.

---

## 5. Install Caddy

Caddy is not in Ubuntu's default repositories. From
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# nano deploy/systemd/*.service
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# sed -i s/User=bou/User=$USER/g deploy/systemd/*.service
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# more deploy/systemd/*.service
::::::::::::::
deploy/systemd/gameshell-janitor.service
::::::::::::::
[Unit]
Description=GameShell session container reaper
Documentation=https://github.com/aboudia9/GameShell-Browser
Requires=docker.service
After=docker.service

[Service]
Type=simple
User=root
ExecStart=/home/bou/GameShell-Browser/deploy/gsh-janitor.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# sed -i s/\/bou\//\/$USER\//g deploy/systemd/*.service
sed: -e expression #1, char 8: unknown option to `s'
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# sed -i s/'\/bou\/'/'\/$USER\/'/g deploy/systemd/*.service
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# more deploy/systemd/*.service
::::::::::::::
deploy/systemd/gameshell-janitor.service
::::::::::::::
[Unit]
Description=GameShell session container reaper
Documentation=https://github.com/aboudia9/GameShell-Browser
Requires=docker.service
After=docker.service

[Service]
Type=simple
User=root
ExecStart=/home/$USER/GameShell-Browser/deploy/gsh-janitor.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
...back 1 page
::::::::::::::
deploy/systemd/gameshell-ttyd.service
::::::::::::::
[Unit]
Description=GameShell web terminal (ttyd)
Documentation=https://github.com/aboudia9/GameShell-Browser
Requires=docker.service
After=docker.service network-online.target
Wants=network-online.target gameshell-janitor.service

[Service]
Type=simple
User=root
ExecStart=/home/$USER/GameShell-Browser/deploy/gsh-serve.sh
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# echo $USER
root
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# sed -i s/'\/\$USER\/'/"\/$USER\/"/g deploy/systemd/*.service
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# more deploy/systemd/*.service
::::::::::::::
deploy/systemd/gameshell-janitor.service
::::::::::::::
[Unit]
Description=GameShell session container reaper
Documentation=https://github.com/aboudia9/GameShell-Browser
Requires=docker.service
After=docker.service

[Service]
Type=simple
User=root
ExecStart=/home/root/GameShell-Browser/deploy/gsh-janitor.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git status
On branch main
Your branch is ahead of 'upstream/master' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    modified:   deploy/systemd/gameshell-janitor.service
    modified:   deploy/systemd/gameshell-ttyd.service

no changes added to commit (use "git add" and/or "git commit -a")
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# more docs/
browser-deployment.md  dev_manual.md          gameshell.md           misc.md                mission.md             user_manual.md         
deps.md                faq.md                 i18n.md                mission_ideas.md       README.md              
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# more docs/browser-deployment.md 
# Browser deployment guide

How to run GameShell in a web browser, so players need nothing installed but a
browser and a URL. This is what the `deploy/` directory in this fork is for.

Written for someone reproducing the deployment on their own VM. Assumes Ubuntu
22.04/24.04 with Docker already installed, and a domain you control.

---

## How it works

```
Player's browser
      │  https://  (nothing to install)
      ▼
   [ Caddy ]          reverse proxy, automatic HTTPS, the only public listener
      │  127.0.0.1:7682
      ▼
   [ ttyd ]           bridges a pseudo-terminal to a WebSocket
      │  one process per connection
      ▼
   [ Docker container ]   fresh, isolated, throwaway GameShell
      └── dies when the player leaves

   [ janitor ]        separate service; removes containers nobody is attached to
```

GameShell needs a *real* bash shell, so each player gets a real container. `ttyd`
streams that container's terminal to the browser, and Caddy puts TLS in front.

Three things run on the VM, and **all three are required**:

| Component | What it is |
|---|---|
| `gameshell-ttyd.service` | The web terminal (bash shell). Launches one container per connection. |
| `gameshell-janitor.service` | Cleans up abandoned containers. Not optional — see [Why the janitor exists](#why-the-janitor-exists). |
| `caddy.service` | HTTPS + reverse proxy. Installed from Caddy's own apt repo. |

Sessions are intentionally **throwaways**: no progress is saved, and every
connection starts a fresh game. If a player's terminal resets, they start
over (or if they type in process-ending commands lol).

---

## Prerequisites

root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# cat docs/browser-deployment.md 
# Browser deployment guide

How to run GameShell in a web browser, so players need nothing installed but a
browser and a URL. This is what the `deploy/` directory in this fork is for.

Written for someone reproducing the deployment on their own VM. Assumes Ubuntu
22.04/24.04 with Docker already installed, and a domain you control.

---

## How it works

```
Player's browser
      │  https://  (nothing to install)
      ▼
   [ Caddy ]          reverse proxy, automatic HTTPS, the only public listener
      │  127.0.0.1:7682
      ▼
   [ ttyd ]           bridges a pseudo-terminal to a WebSocket
      │  one process per connection
      ▼
   [ Docker container ]   fresh, isolated, throwaway GameShell
      └── dies when the player leaves

   [ janitor ]        separate service; removes containers nobody is attached to
```

GameShell needs a *real* bash shell, so each player gets a real container. `ttyd`
streams that container's terminal to the browser, and Caddy puts TLS in front.

Three things run on the VM, and **all three are required**:

| Component | What it is |
|---|---|
| `gameshell-ttyd.service` | The web terminal (bash shell). Launches one container per connection. |
| `gameshell-janitor.service` | Cleans up abandoned containers. Not optional — see [Why the janitor exists](#why-the-janitor-exists). |
| `caddy.service` | HTTPS + reverse proxy. Installed from Caddy's own apt repo. |

Sessions are intentionally **throwaways**: no progress is saved, and every
connection starts a fresh game. If a player's terminal resets, they start
over (or if they type in process-ending commands lol).

---

## Prerequisites

- A Linux VM with a public IP. 1 GB RAM is enough to build the image and serve
  roughly 10-15 concurrent players; see [Capacity](#capacity).
- Docker installed and running, and your user in the `docker` group.
  Note that **the `docker` group is effectively root** — anyone in it can mount
  the host filesystem into a container. Don't hand it out casually.
- A domain (or subdomain) whose `A` record points at the VM. Required —
  Let's Encrypt will not issue certificates for a bare IP address.
- Ports 80 and 443 reachable from the internet.

---

## 1. Clone and build

```sh
git clone https://github.com/aboudia9/GameShell-Browser.git
cd GameShell-Browser
docker build -t gameshell .
chmod +x deploy/*.sh
```

The image **must** be tagged `gameshell` — `deploy/gsh-session.sh` looks for
that name. (Can be changed with the `GSH_IMAGE` environment variable if you need a
different one.)

The build prints a `LegacyKeyValueFormat` warning about the `ENV` line in the
Dockerfile. It is harmless.

Verify:

```sh
docker images | grep gameshell     # ~356 MB
```

---

## 2. Install ttyd

```sh
sudo apt install -y ttyd
ttyd --version
```

**Must be 1.7.0 or newer.** Older versions lack the `-W` flag, and without it
the terminal renders correctly but silently ignores everything the player
types — a fun (confusing) failure to debug.

---

## 3. Edit the systemd units

The units in `deploy/systemd/` are checked in with the original author's
username and paths hardcoded. **Edit both files before installing them.**

In `deploy/systemd/gameshell-ttyd.service` and
`deploy/systemd/gameshell-janitor.service`, change:

```ini
User=bou
ExecStart=/home/bou/GameShell-Browser/deploy/gsh-serve.sh
```

to your username and the path where you cloned the repo. The `User=` must be an
account in the `docker` group. Do NOT run these as root.

---

## 4. Install and start the services

```sh
sudo cp deploy/systemd/*.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now gameshell-janitor.service gameshell-ttyd.service
```

`daemon-reload` is required — systemd caches unit files and will not notice new
or edited ones without it. This is the most common reason a unit change appears
to do nothing.

`enable --now` both starts the service immediately and registers it to start at
boot.

Check:

```sh
systemctl status gameshell-ttyd.service gameshell-janitor.service --no-pager
```

Both should report `active (running)`, and ttyd's line should say `enabled`.

---

## 5. Install Caddy

Caddy is not in Ubuntu's default repositories. From
[Caddy's official instructions](https://caddyserver.com/docs/install#debian-ubuntu-raspbian):

```sh
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' \
  | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' \
  | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install -y caddy
```

---

## 6. Configure Caddy

Edit `deploy/Caddyfile` and replace the hostname with your own:

```
your.domain.here {
    reverse_proxy 127.0.0.1:7682
}
```

Then install and reload:

```sh
sudo cp deploy/Caddyfile /etc/caddy/Caddyfile
sudo systemctl reload caddy
```

Use `reload`, not `restart` — it applies config gracefully without dropping live
sessions, and it refuses to apply a config that fails to parse rather than
taking the site down.

Caddy obtains and renews the TLS certificate automatically, redirects HTTP to
HTTPS, and handles ttyd's WebSocket upgrade. None of that needs configuring.

---

## 7. Firewall

```sh
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
```

Always allow SSH **before** enabling `ufw`, or you will lock yourself out.

**Do not open port 7682.** ttyd binds to loopback only (`-i lo`), so Caddy is
the sole public entrance. Exposing 7682 would publish an unauthenticated
terminal directly to the internet.

---

## Verifying it works

1. Browse to `https://your.domain.here` — GameShell should load, with a padlock.
2. Open a second tab. Confirm two independent games.
3. Close one tab, wait ~10 seconds, then on the VM:

   ```sh
   docker ps --filter "name=^gsh-"
   ```

   The closed session's container should be gone. If it is still listed, the
   janitor is not running.

4. Reboot the VM. Everything should come back with no manual intervention.

Optional stress check — from inside a game session, run a fork bomb:

```sh
:(){ :|:& };:
```

It should fizzle with `Resource temporarily unavailable` rather than affecting
the host. That is `--pids-limit` doing its job.

---

## Configuration

`deploy/gsh-session.sh` — per-player container:

| Flag | Purpose |
|---|---|
| `--rm` | Throwaway. No saved progress by design. |
| `--memory 256m` | Ceiling, not a reservation. Real usage is ~30 MB. |
| `--cpus 0.5` | One player cannot starve the others. |
| `--network none` | No network inside the game. Verified: no mission needs it. |
| `--pids-limit 128` | Fork-bomb protection. Generous for legitimate play. |

`deploy/gsh-serve.sh` — the ttyd invocation. Environment variables `GSH_PORT`
(default 7682) and `GSH_IFACE` (default `lo`). Also contains the high-contrast
terminal theme and font size, kept here rather than in the systemd unit so the
JSON is version-controlled and safe from systemd's quoting rules.

`deploy/gsh-janitor.sh` — the reaper. `GSH_JANITOR_INTERVAL` (default 5 seconds)
controls poll frequency. It only ever touches containers named `gsh-*`.

---

## Operations

```sh
# Logs
sudo journalctl -u gameshell-ttyd -n 50 --no-pager
sudo journalctl -u gameshell-janitor -f      # follow reaping live
sudo journalctl -u caddy -n 50 --no-pager    # certificate problems show here

# Restart after changing a script
sudo systemctl restart gameshell-ttyd

# Restart after editing a unit file
sudo systemctl daemon-reload && sudo systemctl restart gameshell-ttyd

# Update to a newer version of the game
cd ~/GameShell-Browser
git pull
docker build -t gameshell .
sudo systemctl restart gameshell-ttyd
```

Rebuilding the image does not disturb players already connected — running
containers keep using the old image layers until they exit.

### Testing without exposing anything

To reach ttyd directly while Caddy is not yet configured, tunnel over SSH
rather than opening the port:

```sh
ssh -L 7682:127.0.0.1:7682 user@your-vm
# then browse to http://localhost:7682
```

---

## Capacity

Ubuntu plus Docker use roughly 450 MB. Each real session uses ~30 MB, not the
256 MB ceiling. On a 1 GB VM that works out to somewhere around 15–18
concurrent players before swapping starts.

There is currently **no cap on concurrent sessions** — see
[Known limitations](#known-limitations).

If you need more capacity, resizing RAM and CPU is straightforward on most
cloud providers. Note that on DigitalOcean specifically, growing a disk is
permanent — disks cannot be shrunk — so prefer the "CPU and RAM only" resize.

---

## Why the janitor exists

Worth understanding before assuming it is redundant, because three intuitive
approaches all fail:

1. **Killing the `docker run` client does not stop the container.** The client
   is only a remote control. When a player closes their tab, ttyd kills the
   client and the container keeps running indefinitely.

2. **ttyd's default kill signal is SIGHUP, which the Docker CLI ignores.**
   Without `-s 9` (SIGKILL) in `gsh-serve.sh`, sessions never terminate at all.

3. **Cleanup cannot live inside the session script.** Two separate reasons:
   trapping `HUP` makes bash *survive* the signal, which keeps the session alive
   and defeats the purpose; and ttyd SIGKILLs its entire process group, so any
   watchdog the script spawns dies with it. `nohup` does not help (it blocks
   SIGHUP, not SIGKILL).

Hence an external service. The janitor lists `gsh-*` containers and removes any
with no live `docker run` client, from outside ttyd's process group where
nothing can kill it.

Also relevant: `docker run --rm` is not fully reliable when a container's main
process dies messily. The janitor covers that gap too.

---

## Troubleshooting

**Terminal loads but typing does nothing.**
ttyd is missing `-W`, or is older than 1.7.

**Browser reconnects in a loop; logs show the process exiting within
milliseconds.**
ttyd cannot execute the script. Almost always a wrong path or a missing
executable bit. Check `ExecStart=` in the unit and run `chmod +x deploy/*.sh`.

**`lws_socket_bind: ERROR on binding fd ... to port 7682 (-1 98)`.**
Error 98 is "address already in use" — something else holds that port. Check
with `pgrep -a ttyd` before killing anything. On DigitalOcean droplets, the
`droplet-agent` runs its own ttyd on `127.0.0.1:7681` to power the dashboard's
web console; **do not kill it**, that console is out-of-band recovery access if
SSH ever breaks. This is why the default port here is 7682.

**Containers accumulate and are never removed.**
The janitor is not running, or its `User=` is not in the `docker` group.
Check `systemctl status gameshell-janitor`.

**Caddy cannot obtain a certificate.**
Check `journalctl -u caddy`. Usual causes: the domain's `A` record does not
point at this VM, port 80 is not reachable, or the DNS is behind a proxy. If
DNS is on Cloudflare, the record must be **DNS only (grey cloud)** — proxying
terminates TLS at Cloudflare and breaks the ACME challenge.

**DNS edits appear to work but nothing resolves.**
The zone you edited may not be authoritative. Verify with
`dig +short NS your-domain @1.1.1.1` and confirm the nameservers belong to the
provider whose panel you edited. A correct answer from
`dig +short your.domain @1.1.1.1` is proof the record is live.

**`channel N: open failed: connect failed` spam in an SSH session.**
Harmless. An SSH port-forward's target is down — usually a stale browser tab
retrying against a tunnel.

---

## Known limitations

- **No cap on concurrent sessions.** Nothing prevents more players than the VM
  can handle from connecting. Planned.
- **No maximum session lifetime.** A player who leaves a tab open indefinitely
  holds a container indefinitely — the janitor only reaps sessions whose client
  has disconnected. Planned.
- **No authentication.** Anyone with the URL can start a session. This is a
  deliberate choice for a classroom tool, and it rests on the container
  sandboxing: non-root, no network, memory- and PID-capped, throwaway. Add
  Caddy's `basic_auth` directive if your situation differs.
- **The `intermediate/04_bg_xeyes` mission cannot work.** It runs `xeyes`, an
  X11 graphical program, which has no display in a headless container.
- **No saved progress.** By design, but worth telling players explicitly.
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# more docs/browser-deployment.md 
# Browser deployment guide

How to run GameShell in a web browser, so players need nothing installed but a
browser and a URL. This is what the `deploy/` directory in this fork is for.

Written for someone reproducing the deployment on their own VM. Assumes Ubuntu
22.04/24.04 with Docker already installed, and a domain you control.

---

## How it works

```
Player's browser
      │  https://  (nothing to install)
      ▼
   [ Caddy ]          reverse proxy, automatic HTTPS, the only public listener
      │  127.0.0.1:7682
      ▼
   [ ttyd ]           bridges a pseudo-terminal to a WebSocket
      │  one process per connection
      ▼
   [ Docker container ]   fresh, isolated, throwaway GameShell
      └── dies when the player leaves

   [ janitor ]        separate service; removes containers nobody is attached to
```

GameShell needs a *real* bash shell, so each player gets a real container. `ttyd`
streams that container's terminal to the browser, and Caddy puts TLS in front.

Three things run on the VM, and **all three are required**:

| Component | What it is |
|---|---|
| `gameshell-ttyd.service` | The web terminal (bash shell). Launches one container per connection. |
| `gameshell-janitor.service` | Cleans up abandoned containers. Not optional — see [Why the janitor exists](#why-the-janitor-exists). |
| `caddy.service` | HTTPS + reverse proxy. Installed from Caddy's own apt repo. |

Sessions are intentionally **throwaways**: no progress is saved, and every
connection starts a fresh game. If a player's terminal resets, they start
over (or if they type in process-ending commands lol).

---

## Prerequisites

- A Linux VM with a public IP. 1 GB RAM is enough to build the image and serve
  roughly 10-15 concurrent players; see [Capacity](#capacity).
- Docker installed and running, and your user in the `docker` group.
  Note that **the `docker` group is effectively root** — anyone in it can mount
  the host filesystem into a container. Don't hand it out casually.
- A domain (or subdomain) whose `A` record points at the VM. Required —
  Let's Encrypt will not issue certificates for a bare IP address.
- Ports 80 and 443 reachable from the internet.

---

## 1. Clone and build

```sh
git clone https://github.com/aboudia9/GameShell-Browser.git
cd GameShell-Browser
docker build -t gameshell .
chmod +x deploy/*.sh
```

The image **must** be tagged `gameshell` — `deploy/gsh-session.sh` looks for
that name. (Can be changed with the `GSH_IMAGE` environment variable if you need a
different one.)

The build prints a `LegacyKeyValueFormat` warning about the `ENV` line in the
Dockerfile. It is harmless.

Verify:

```sh
docker images | grep gameshell     # ~356 MB
```

---

## 2. Install ttyd

```sh
sudo apt install -y ttyd
ttyd --version
```

**Must be 1.7.0 or newer.** Older versions lack the `-W` flag, and without it
the terminal renders correctly but silently ignores everything the player
types — a fun (confusing) failure to debug.

---

## 3. Edit the systemd units

The units in `deploy/systemd/` are checked in with the original author's
username and paths hardcoded. **Edit both files before installing them.**

In `deploy/systemd/gameshell-ttyd.service` and
`deploy/systemd/gameshell-janitor.service`, change:

```ini
User=bou
ExecStart=/home/bou/GameShell-Browser/deploy/gsh-serve.sh
```

to your username and the path where you cloned the repo. The `User=` must be an
account in the `docker` group. Do NOT run these as root.

---

## 4. Install and start the services

```sh
sudo cp deploy/systemd/*.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now gameshell-janitor.service gameshell-ttyd.service
```

`daemon-reload` is required — systemd caches unit files and will not notice new
or edited ones without it. This is the most common reason a unit change appears
to do nothing.

`enable --now` both starts the service immediately and registers it to start at
boot.

Check:

```sh
systemctl status gameshell-ttyd.service gameshell-janitor.service --no-pager
```

Both should report `active (running)`, and ttyd's line should say `enabled`.

---

## 5. Install Caddy

Caddy is not in Ubuntu's default repositories. From
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# sudo cp deploy/systemd/*.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now gameshell-janitor.service gameshell-ttyd.service
Created symlink /etc/systemd/system/multi-user.target.wants/gameshell-janitor.service → /etc/systemd/system/gameshell-janitor.service.
Created symlink /etc/systemd/system/multi-user.target.wants/gameshell-ttyd.service → /etc/systemd/system/gameshell-ttyd.service.
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# ifconfig
docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:3d:49:fa:ff  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 204.168.165.176  netmask 255.255.255.255  broadcast 0.0.0.0
        inet6 2a01:4f9:c013:f317::1  prefixlen 64  scopeid 0x0<global>
        inet6 fe80::9000:9ff:fe85:b49e  prefixlen 64  scopeid 0x20<link>
        ether 92:00:09:85:b4:9e  txqueuelen 1000  (Ethernet)
        RX packets 448536  bytes 277282703 (277.2 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 410143  bytes 63313590 (63.3 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 1690  bytes 147517 (147.5 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1690  bytes 147517 (147.5 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# git status
On branch main
Your branch is ahead of 'upstream/master' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    modified:   deploy/systemd/gameshell-janitor.service
    modified:   deploy/systemd/gameshell-ttyd.service

no changes added to commit (use "git add" and/or "git commit -a")
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# systemctl status gameshell-janitor.service 
● gameshell-janitor.service - GameShell session container reaper
     Loaded: loaded (/etc/systemd/system/gameshell-janitor.service; enabled; preset: enabled)
     Active: activating (auto-restart) (Result: exit-code) since Sun 2026-08-09 22:35:29 UTC; 3s ago
       Docs: https://github.com/aboudia9/GameShell-Browser
    Process: 83744 ExecStart=/home/root/GameShell-Browser/deploy/gsh-janitor.sh (code=exited, status=203/EXEC)
   Main PID: 83744 (code=exited, status=203/EXEC)
        CPU: 969us
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# systemctl start gameshell-janitor.service 
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# systemctl start gameshell-ttyd.service 
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# systemctl status gameshell-janitor.service 
● gameshell-janitor.service - GameShell session container reaper
     Loaded: loaded (/etc/systemd/system/gameshell-janitor.service; enabled; preset: enabled)
     Active: activating (auto-restart) (Result: exit-code) since Sun 2026-08-09 22:36:06 UTC; 764ms ago
       Docs: https://github.com/aboudia9/GameShell-Browser
    Process: 83867 ExecStart=/home/root/GameShell-Browser/deploy/gsh-janitor.sh (code=exited, status=203/EXEC)
   Main PID: 83867 (code=exited, status=203/EXEC)
        CPU: 809us
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# ^C
root@docker-ce-ubuntu-8gb-hel1-1:~/GameShell-Browser# 
