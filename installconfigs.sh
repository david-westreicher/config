#!/bin/bash

echo "Trying to install Vundle..."
if hash git 2>/dev/null; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    if hash vim 2>/dev/null; then
        # Fix bashrc
        cat addtobashrc >> ~/.bashrc
        source ~/.bashrc

        DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
        ln -s "$DIR/vimrc" ~/.vimrc
        vim +PluginInstall
    else
        echo "You need to install VIM!"
    fi
else
    echo "You need to install GIT!"
fi
