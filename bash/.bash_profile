[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
