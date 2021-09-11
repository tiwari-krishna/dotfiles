#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#function _update_ps1() {
#    PS1=$(powerline-shell $?)
#}
#
#if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

#eval "$(starship init bash)"

alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias ..='cd ..'
alias update='sudo pacman -Syu'
alias upall='paru'
alias uprepo='sudo reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist'
alias you-m4a="youtube-dl --extract-audio --audio-format m4a "
alias you-mp3="youtube-dl --extract-audio --audio-format mp3 "
