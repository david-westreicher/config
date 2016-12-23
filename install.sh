sudo apt-get install lilyterm vim git i3-wm xinit curl x11-xserver-utils
mkdir -p ~/Documents
mkdir -p ~/.config/lilyterm
mkdir -p ~/.i3

git clone https://github.com/david-westreicher/config ~/Documents/config
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall 2&> /dev/null
echo ". ~/Documents/config/bashrc" >> ~/.bashrc

ln -sf ~/Documents/config/lilyterm.conf ~/.config/lilyterm/default.conf
ln -sf ~/Documents/config/vimrc ~/.vimrc
ln -sf ~/Documents/config/i3config ~/.i3/config
