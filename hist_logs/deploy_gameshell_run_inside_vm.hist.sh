cd GameShell-Browser/
ls deploy
ls deploy/systemd
sudo systemctl enable  deploy/systemd/gameshell-shell-ttyd.service
sudo systemct --help deploy/systemd/gameshell-shell-ttyd.service
systemctl --help deploy/systemd/gameshell-shell-ttyd.service
systemctl enable ./deploy/systemd/gameshell-shell-ttyd.service
systemctl enable $PWD/deploy/systemd/gameshell-shell-ttyd.service
find /etc/ -name '*.service'
ln ./deploy/systemd/*.service /etc/systemd/system/multi-user.target.wants/
systemctl reload
systemctl reload --help
sudo shutdown -r
exit
sudo systemctl status gameshell-ttyd
sudo systemctl list
sudo systemctl list-jobs
sudo systemctl list-jobs '*'
sudo systemctl list-jobs *
ls -hal /etc/systemd/system/multi-user.target.wants/
chmod ugoa+rwx /etc/systemd/system/multi-user.target.wants/game*.service
ls -hal /etc/systemd/system/multi-user.target.wants/
sudo systemctl status gameshell-ttyd.service
sudo systemctl daemon-reload 
rm /etc/systemd/system/multi-user.target.wants/game*.service
ls GameShell-Browser/
cd GameShell-Browser/
git pull
git remote add fork git@github.com:GameShell-Browser
git pull fork main
git remote add gitlab git@gitlab.com:GameShell-Browser
ls ~/.ssh
git remote remove gitlab
git remote remove fork
git remote rename origin upstream
git remote rename fork origin
git remote -v
git remote add origin https://github.com/hobson/GameShell-Browser
git pull -u origin main
git pull origin main
git status
git checkout -b hobs
git diff
git commit -am 'chmod +x *.service and fontSize=14 (was 16)'
git config --global user.email git@totalgood.com
git config --global user.name gitter
git commit -am 'chmod +x *.service and fontSize=14 (was 16)'
git checkout master
git branch rename master main
git branch --move master main
git pull origin main
git status
git log --stat
more README-Browser.md 
diff README-Browser.md docs/README-Browser.md 
diff README-Browser.md docs/browser-deployment.md 
more README-Browser.md 
diff docs/browser-deployment.md 
more docs/browser-deployment.md 
docker build -t gameshell .
# chmod +x deploy/*.sh
ls -hal deploy/*.sh
more docs/browser-deployment.md 
docker images | grep gameshell
sudo apt install -y ttyd
ttyd --version
more docs/browser-deployment.md 
nano deploy/systemd/*.service
sed -i s/User=bou/User=$USER/g deploy/systemd/*.service
more deploy/systemd/*.service
sed -i s/\/bou\//\/$USER\//g deploy/systemd/*.service
sed -i s/'\/bou\/'/'\/$USER\/'/g deploy/systemd/*.service
more deploy/systemd/*.service
echo $USER
sed -i s/'\/\$USER\/'/"\/$USER\/"/g deploy/systemd/*.service
more deploy/systemd/*.service
git status
more docs/browser-deployment.md 
cat docs/browser-deployment.md 
more docs/browser-deployment.md 
sudo cp deploy/systemd/*.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now gameshell-janitor.service gameshell-ttyd.service
ifconfig
git status
systemctl status gameshell-janitor.service 
systemctl start gameshell-janitor.service 
systemctl start gameshell-ttyd.service 
systemctl status gameshell-janitor.service 
hist > deploy_gameshell_hetzner_vm.inside_vm.hist.sh
history > deploy_gameshell_hetzner_vm.inside_vm.hist.sh
more deploy_gameshell_hetzner_vm.inside_vm.hist.sh 
cat deploy_gameshell_hetzner_vm.inside_vm.hist.sh 
history | cut -c8- > deploy_gameshell_hetzner_vm.inside_vm.hist.sh
