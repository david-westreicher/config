#!/bin/bash

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cat addtobashrc >> ~/.bashrc
source ~/.bashrc

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ -f ~/.vimrc ];
then
    echo "deleting"
    rm ~/.vimrc
fi
ln -s $DIR/vimrc ~/.vimrc

if [ -f ~/.i3/config ];
then
    rm ~/.i3/config
fi
mkdir ~/.i3 -p
ln -s $DIR/i3config ~/.i3/config

if [ -f ~/.config/lilyterm/default.conf ];
then
    rm ~/.config/lilyterm/default.conf 
fi
mkdir ~/.config/lilyterm -p
ln -s $DIR/lilyterm.conf ~/.config/lilyterm/default.conf

vim +PluginInstall
