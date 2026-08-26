# SUPERSEDED -- kept for reference only.
#
# This was distilled by hand from a real deployment session (see hist_logs/) and
# was never fully idempotent. Known problems, all fixed in the playbook:
#   - sed's deploy/systemd/*.service and deploy/Caddyfile IN PLACE, dirtying the
#     working tree, so a second run substitutes into already-substituted files
#   - re-exports FQDN unconditionally at line ~40, silently overriding whatever
#     the operator set at the top
#   - `apt install caddy` without first adding the Caddy apt repo, so it only
#     works if that was done by hand beforehand
#   - `ln` (hard link) rather than cp into /etc/caddy/Caddyfile
#   - adds ufw rules but never runs `ufw enable`, so the firewall stays inactive
#   - no SSH hardening, no fail2ban, no VM provisioning
#
# Use deploy/ansible/ instead:  ansible-playbook playbooks/site.yml
# See deploy/ansible/README.md and docs/browser-deployment.md.

# DONTDO: more README-Browser.md 
# more docs/browser-deployment.md
sudo echo Warning: using sudo to configure this server -- $HOSTNAME || echo "This script requires sudo. Run 'sudo echo hello sudo' to log into sudoer user before running this script".
if [[ -z "$FQDN" ]] ; then
    export FQDN='gsh.proai.org, bash.proai.org, sh.proai.org' 
    echo "WARNING! You did not set the FQDN environment variable!! Defaulting to '$FQDN' !!!"
fi
if [[ -z "$SSH_PORT" ]] ; then
    export SSH_PORT=22
    echo "WARNING! You did not set the SSH_PORT environment variable!! Defaulting to $SSH_PORT !!!"
    echo "Check to be 100% certain that $SSH_PORT is the correct port for your VM !!!"
    echo "!!!!! If not, hit [ctrl]-c to cancel within 3 seconds !!!!!"
    sleep 1
    echo "!!!!! If not, hit [ctrl]-c to cancel within 2 seconds !!!!!"
    sleep 1
    echo "!!!!! If not, hit [ctrl]-c to cancel within 1 seconds !!!!!"
    sleep 1
fi

sudo apt install --upgrade -y ttyd caddy
cd $HOME
git clone https://github.com/aboutalib1953/GameShell-Browser || echo "GameShell-Browser repo already cloned?"
cd GameShell-Browser/
# sudo apt update && sudo apt upgrade
docker build -t gameshell .
# chmod +x deploy/*.sh  # DONTDO: PR corrects this
# docker images | grep gameshell
# ttyd --version
sed -i s%'$HOME'%"$HOME"%g deploy/systemd/*.service
# use sep char unlikely to appear within $USER path (slash obviously a bad idea)
sed -i s/'User=$USER'/"User=$USER"/g deploy/systemd/*.service
sudo cp -f deploy/systemd/*.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now gameshell-janitor.service gameshell-ttyd.service

systemctl --no-pager status gameshell-janitor.service 
systemctl --no-pager status gameshell-ttyd.service 

# Before running this script, or on the same line within sudo env:
export FQDN='gsh.proai.org, bash.proai.org, sh.proai.org' 
if [[ -n "$FQDN" ]] ; then
   sed -i s%'0.0.0.0'%"$FQDN"%g deploy/Caddyfile
fi
sudo ln deploy/Caddyfile /etc/caddy/Caddyfile
sudo systemctl enable --now caddy
# sudo systemctl reload caddy

sudo ufw allow $SSH_PORT/tcp  # double and tripple-check SSH_PORT!
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# TODO
# configure Caddy/ufw/Docker to expose appropriate ports and allow http:/ to IP address?
