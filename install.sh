sudo apt-get install lilyterm vim git i3-wm i3status dmenu xinit
mkdir -p ~/Documents
mkdir -p ~/.config/lilyterm
mkdir -p ~/.i3

git clone https://github.com/david-westreicher/config ~/Documents/config
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo ". ~/Documents/config/bashrc" >> ~/.bashrc
source ~/.bashrc

ln -sf ~/Documents/config/lilyterm.conf ~/.config/lilyterm/default.conf
ln -sf ~/Documents/config/vimrc ~/.vimrc
ln -sf ~/Documents/config/i3config ~/.i3/config
