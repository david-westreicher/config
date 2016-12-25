sudo apt-get install lilyterm vim git i3-wm xinit curl x11-xserver-utils
mkdir -p ~/Documents
mkdir -p ~/.config/lilyterm
mkdir -p ~/.i3

git clone https://github.com/david-westreicher/config ~/Documents/config
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo ". ~/Documents/config/bashrc" >> ~/.bashrc

ln -sf ~/Documents/config/lilyterm.conf ~/.config/lilyterm/default.conf
ln -sf ~/Documents/config/vimrc ~/.vimrc
ln -sf ~/Documents/config/i3config ~/.i3/config
ln -sf ~/Documents/config/i3status.conf ~/.i3/i3status.conf

sudo apt-get install python3-pip lm-sensors acpi fonts-font-awesome
sudo pip3 install py3status i3-py pytz tzlocal

vim +PluginInstall +qall
