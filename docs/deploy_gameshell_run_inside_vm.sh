# DONTDO: more README-Browser.md 
# more docs/browser-deployment.md
sudo echo Warning: using sudo to configure this server -- $HOSTNAME || echo "This script requires sudo. Run 'sudo echo hello sudo' to log into sudoer user before running this script".
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

if [[ -n "$FQDN" ]] ; then
   sed -i s%'0.0.0.0'%"$FQDN"%g deploy/Caddyfile
fi
sudo cp deploy/Caddyfile /etc/caddy/Caddyfile
sudo systemctl reload caddy

# TODO
# configure Caddy/ufw/Docker to expose appropriate ports and allow http:/ to IP address?
