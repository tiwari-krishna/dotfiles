export BROWSER=librewolf
export AUR=paru
export EDITOR=vim
export TERMINAL=st
export HISTFILE=$HOME/.config/bash/bash_history
export HISTSIZE="10000"
export HISTCONTROL=ignoredups:erasedups
export TERM="xterm-256color"
export BASHRC=$HOME/.config/bash/bashrc
[[ $- != *i* ]] && return

export PATH=$HOME/.local/bin/:$HOME/.local/Apps:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XINITRC=${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc
export XRESOURCES=${XDG_CONFIG_HOME:-$HOME/.config}/x11/xresources

[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"
