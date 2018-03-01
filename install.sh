sudo apt-get install vim git i3 rofi xinit curl x11-xserver-utils feh ranger lxterminal ack
mkdir -p ~/Documents
mkdir -p ~/.local/share/applications
mkdir -p ~/.config/lxterminal
mkdir -p ~/.config/ranger
mkdir -p ~/.i3

git clone https://github.com/david-westreicher/config ~/Documents/config
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo ". ~/Documents/config/bash/bashrc" >> ~/.bashrc

ln -fs ~/Documents/config/xdg/mimeapps.list ~/.local/share/applications/mimeapps.list
ln -fs ~/Documents/config/ls/dircolors.ansi-dark ~/.dircolors
ln -fs ~/Documents/config/X/resources ~/.Xresources
ln -sf ~/Documents/config/lxterminal/lxterminal.conf ~/.config/lxterminal/lxterminal.conf
ln -sf ~/Documents/config/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sf ~/Documents/config/vim/vimrc ~/.vimrc
ln -sf ~/Documents/config/i3/i3.conf ~/.i3/config
ln -sf ~/Documents/config/i3/status.conf ~/.i3/i3status.conf
ln -sf ~/Documents/config/i3/py3status ~/.i3/py3status
ln -sf ~/Documents/config/python/flake8 ~/.config/flake8

sudo apt-get install python3-pip fonts-font-awesome
sudo pip3 install py3status i3ipc

vim +PluginInstall +qall

# update-alternatives --config editor -> nvim/vim
# update-alternatives --config x-terminal-emulator -> lxterminal
# update-alternatives --config x-www-browser -> chromium
