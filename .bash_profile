export BROWSER=brave
export EDITOR=vim
export TERMINAL=st

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XINITRC=${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx $XINITRC
