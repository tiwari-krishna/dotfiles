#Vi mode
set -o vi

#Archiver
ex ()
{
  if [ -f "$1" ] ; then
      case $1 in
         *.tar.bz2)   tar xjf $1   ;;
         *.tar.gz)    tar xzf $1   ;;
         *.bz2)       bunzip2 $1   ;;
         *.rar)       unrar x $1   ;;
         *.gz)        gunzip $1    ;;
         *.tar)       tar xf $1    ;;
         *.tbz2)      tar xjf $1   ;;
         *.tgz)       tar xzf $1   ;;
         *.zip)       unzip $1     ;;
         *.Z)         uncompress $1;;
         *.7z)        7z x $1      ;;
         *.deb)       ar x $1      ;;
         *.tar.xz)    tar xf $1    ;;
         *.tar.zst)   unzstd $1    ;;
         *)           echo "'$1' cannot be extracted via ex()" ;;
      esac
        else
      echo "'$1' is not a valid file"
   fi
}


#Aliases
alias ls='ls --color=always --group-directories-first'
alias grep='grep --color=auto'
alias ..='cd ..'
alias you-m4a="youtube-dl --extract-audio --audio-format m4a "
alias you-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias you-best="youtube-dl -f bestvideo+bestaudio "
alias you-best-aud="youtube-dl --extract-audio --audio-format best "
alias lynx="lynx -vikeys"
alias dwmc="vim ~/.config/dwm/config.h"
alias dwms="vim ~/.config/dwm/dwm.c"
alias mkins="sudo make clean install"
alias v="nvim "
alias vim="nvim "
alias ka='killall '
alias aurup='paru'
alias pacup='sudo pacman -Syu'
alias pacupd='sudo pacman -Syy'
alias pacupg='sudo pacman -Suu'
alias pacins='paru -S '
alias pacrm='paru -Rsuc'
alias aptup='sudo apt update && sudo apt upgrade'
alias aptupd='sudo apt update'
alias aptupg='sudo apt upgrade'
alias aptins='sudo apt install '
alias aptrm='sudo apt remove '
alias rm='rm -i'
alias install='sudo xbps-install'
alias remove='sudo xbps-remove'
alias update='sudo xbps-install -Su'

# Starship Prompt
eval "$(starship init bash)"
