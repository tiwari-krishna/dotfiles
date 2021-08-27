function fish_greeting
end

starship init fish | source

alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first' # tree listing

set TERM "xterm-256color"

#function fish_prompt
#    powerline-shell --shell bare $status
#end

alias update='sudo pacman -Syu'
alias upall='paru'
alias uprepo='sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist'
