# .bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# exports
export VISUAL=nvim
export EDITOR="$VISUAL"
export BROWSER=firefox-bin
export PATH=$PATH:$HOME/.local/bin:$HOME/bin
export XDG_CURRENT_DESKTOP=spectrwm

# history
shopt -s histappend
export HISTCONTROL=ignoreboth:erasedups
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s expand_aliases dotglob gnu_errfmt histreedit nocasematch autocd globstar checkwinsize cdspell dirspell  

bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set colored-stats on'

# aliases
alias ls='ls --color=auto'
alias ll='ls --color=auto -al'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias key="vim $HOME/.config/spectrwm/keybindings.conf"
alias wm="vim ~/.config/spectrwm/spectrwm.conf"
alias f="ranger"
alias weather="curl wttr.in"
alias py="/usr/bin/python"
alias pg="ping google.com"
alias m="cmus"
alias vimrc="vim $HOME/.config/nvim/init.vim"
alias v="nvim"
alias vim="nvim"
alias sudo="sudo "

up() {
    curl -F "file=@$*" https://0x0.st | xclip -selection clipboard
}

dict() {
    curl dict://dict.org/d:$* | less
}

sip() {
    curl https://ipinfo.io/$*
}

# prompt
red="\e[31m"
green="\e[32m"
yellow="\e[33m"
cyan="\e[36m"
blue="\e[34m"
magenta="\e[35m"
white="\e[37m"
gray="\e[38;5;241m"
gray1="\e[38;5;239m"
gray2="\e[38;5;237m"
reset="\e[0m"

# stolen from https://github.com/icyphox/dotfiles/blob/master/bash/.bashrc.d/99-prompt.bash
git_branch() {
    [[ -d "$PWD/.git" ]] && {
        local git_status="$(git status 2> /dev/null)"
        local on_branch="On branch ([^${IFS}]*)"
        local on_commit="HEAD detached at ([^${IFS}]*)"
        status="$(git status --porcelain 2> /dev/null)"
        local exit="$?"
        color=""
        if [[ "$exit" -eq 0 ]]; then
            if [[ "${#status}" -eq 0 ]]; then
                color="${green}"  
            else
                color="${red}"
            fi
        else
            printf ''
        fi
        if [[ $git_status =~ $on_branch ]]; then
            local branch=${BASH_REMATCH[1]}
            printf '%b'  "$color$branch$reset"
        elif [[ $git_status =~ $on_commit ]]; then
            local commit=${BASH_REMATCH[1]}
            printf '%b' "$color$commit$reset"
        fi
    }
}

function prompt_right() {
    echo -e "$(git_branch)"
}

function prompt_left() {
  echo -e "${gray}\h${reset} ${white}(${reset}${red}\w${reset}${white})${reset}"
}

function prompt() {
    compensate=9
    PS1=$(printf "%*s\r%s\n\$ " "$(($(tput cols)+${compensate}))" "$(prompt_right)" "$(prompt_left)")
}
PROMPT_COMMAND=prompt
