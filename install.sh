sudo apt-get install lilyterm vim git i3-wm xinit curl x11-xserver-utils
mkdir -p ~/Documents
mkdir -p ~/.config/lilyterm
mkdir -p ~/.i3

git clone https://github.com/david-westreicher/config ~/Documents/config
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo ". ~/Documents/config/bash/bashrc" >> ~/.bashrc

ln -sf ~/Documents/config/lilyterm/lilyterm.conf ~/.config/lilyterm/default.conf
ln -sf ~/Documents/config/vim/vimrc ~/.vimrc
ln -sf ~/Documents/config/i3/i3.conf ~/.i3/config
ln -sf ~/Documents/config/i3/status.conf ~/.i3/i3status.conf
ln -sf ~/Documents/config/i3/py3status ~/.i3/py3status

sudo apt-get install python3-pip fonts-font-awesome
sudo pip3 install py3status i3ipc

vim +PluginInstall +qall
