# DONTDO: more README-Browser.md 
# more docs/browser-deployment.md
cd $HOME
git clone https://github.com/aboutalib1953/GameShell-Browser || echo "GameShell-Browser repo already cloned?"
cd GameShell-Browser/
# sudo apt update && sudo apt upgrade
sudo apt install --upgrade -y ttyd
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

# TODO
# configure Caddy/ufw/Docker to expose appropriate ports and allow http:/ to IP address?