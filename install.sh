sudo apt-get install lilyterm vim git i3-wm i3status dmenu xinit
mkdir -p ~/Documents
git clone https://github.com/david-westreicher/config ~/Documents/config
echo ". ~/Documents/config/bashrc" >> ~/.bashrc

ln -s ~/.config/lilyterm/default.conf ~/Documents/config/lilyterm.conf
ln -s ~/.vimrc ~/Documents/config/vimrc
ln -s ~/.i3/config ~/Documents/config/i3config
