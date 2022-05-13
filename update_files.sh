#!/bin/bash

set -euo pipefail

cp ~/.gdbinit .
rm -rf .docker_build
cp -r ~/.docker_build .
rm -rf .config
cp ~/.apvlvrc .
cp ~/.bashrc .
cp ~/.gitconfig .
cp ~/.gitcryptmergetool.sh .
cp ~/.tmux.conf .
cp ~/.vimrc .
rm -rf .vim
mkdir -p .vim
cp ~/.vim/coc-settings.json .vim
mkdir .config
cp -r ~/.config/mobac .config/mobac
rm -rf .config/mobac/settings.xml
rm -rf bin
cp -r /data/backup/bin/ bin
rm -rf firefox_extensions
cp -r /home/user/.mozilla/firefox/9rs7lmoo.default/extensions firefox_extensions
rm -rf thunderbird_extensions
cp -r /home/user/.thunderbird/qi7dkguj.default/extensions thunderbird_extensions
mkdir -p .mplayer
cp ~/.mplayer/config .mplayer
cp ~/.mplayer/input.conf .mplayer
mkdir -p .config/cmus
cp ~/.config/cmus/rc .config/cmus
mkdir -p .config/awesome
cp -r ~/.config/awesome .config
mkdir -p .config/parcellite
cp -r ~/.config/parcellite .config
mkdir -p .config/aria2
cp -r ~/.config/aria2 .config
mkdir -p etc/dhcp
cp /etc/dhcp/dhclient.conf etc/dhcp/dhclient.conf
mkdir -p etc
mkdir -p etc/sudoers.d
cp /etc/sudoers.d/user etc/sudoers.d/user
mkdir -p .config/xfce4/terminal/
cp ~/.config/xfce4/terminal/terminalrc .config/xfce4/terminal
mkdir -p etc/default
cp /etc/default/grub etc/default/
cp /etc/default/cpufrequtils etc/default/
mkdir -p etc/ssh/
cp /etc/ssh/sshd_config etc/ssh/
rm -rf .screenlayout/
cp -r ~/.screenlayout .
rm -rf etc/pulse
mkdir etc/pulse
cp -r /etc/pulse/default.pa  etc/pulse
rm -rf etc/samba
mkdir -p etc/samba
cp -r /etc/samba/smb.conf etc/samba
mkdir -p .config/zathura/
cp -r ~/.config/zathura/zathurarc .config/zathura/
cp -r ~/.config/redshift.conf .config/
cp -f ~/.config/starship.toml .config/
sudo apt-clone clone packages
git add .
