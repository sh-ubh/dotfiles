# history
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory hist_ignore_all_dups hist_ignore_space

#exports
export VISUAL=nvim
export EDITOR="$VISUAL"
export BROWSER=firefox
export PATH=$PATH:$HOME/.local/bin:$HOME/bin
export XDG_CURRENT_DESKTOP=spectrwm

setopt autocd extendedglob nomatch globdots correctall
unsetopt beep
bindkey -v

# completions
zstyle :compinstall filename '/home/x/.zshrc'
autoload -U colors && colors
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
#zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
#zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# sources
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# prompt
PROMPT=$'\n'"%B%F{240}%m "$'\n'"%(?.%F{248}▲.%F{red}?%?)%f "
git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
setopt PROMPT_SUBST
RPROMPT='%9c%{%F{green}%}$(git_branch)%{%F{none}%} $ '

# aliases
alias ls='ls --color=auto'
alias ll='ls --color=auto -al'
alias key="vim $HOME/.config/spectrwm/keybindings.conf"
alias wm="vim ~/.config/spectrwm/spectrwm.conf"
alias f="ranger"
alias weather="curl wttr.in"
alias py="/usr/bin/python"
alias pg="ping google.com"
alias pubip="curl ipinfo.io/ip"
alias k="pkill "
alias m="cmus"
alias vimrc="vim $HOME/.config/nvim/init.vim"
alias v="nvim"
alias vim="nvim"
alias sudo="sudo "
alias parrot="VBoxManage startvm Parrot"

up() {
    curl -F "file=@$*" https://0x0.st | xclip -selection clipboard
}

dict() {
    curl dict://dict.org/d:$*
}

