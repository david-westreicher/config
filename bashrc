# This configs were added by https://github.com/david-westreicher/config/installconfigs.sh
# use 256 colors, disable ctrl+s
export TERM=xterm-256color
export EDITOR=vim

bind -r '\C-s'
stty -ixon -ixoff
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\[\033[01;32m\]>\[\033[00m\] '

alias multiscreen='python ~/Documents/config/multiscreen.py'
alias haskell='ghci'
alias wetter='curl wttr.in/Innsbruck'
alias search='grep -rnwi . -e'
alias music='cmus'
alias vps='ssh-add ~/.ssh/ramnode && ssh root@81.4.121.94'
alias largest='du -a $1 | sort -n -r | head -n 10'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -l -a -h --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
