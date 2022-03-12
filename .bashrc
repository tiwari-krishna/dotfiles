#Vi mode
set -o vi

#Archiver thanks arcolinux
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
alias la='ls -lah --color=always --group-directories-first'
alias ls='ls --color=always'
alias srbs='source .bashrc '
alias grep='grep --color=auto'
alias ..='cd ..'
alias you-m4a="youtube-dl --extract-audio --audio-format m4a "
alias you-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias you-best="youtube-dl -f bestvideo+bestaudio "
alias you-best-aud="youtube-dl --extract-audio --audio-format best "
alias lynx="lynx -vikeys"
alias mkins="sudo make clean install"
alias v="nvim "
alias vim='nvim '
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
alias mkexec='chmod +x '
alias uchown='sudo chown --recursive $USER '
alias cdwm='cd $HOME/.config/dwm && lf'
alias findr='sudo find / -iname '
alias findh='find $HOME/ -iname '
alias svim='sudo nvim '
alias clr='clear'

# Starship Prompt
eval "$(starship init bash)"
