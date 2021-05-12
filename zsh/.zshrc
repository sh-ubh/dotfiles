# history
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory hist_ignore_all_dups hist_ignore_space

#exports
export VISUAL=nvim
export EDITOR="$VISUAL"
export BROWSER=/usr/bin/brave
export PATH=$PATH:$HOME/.bin
export TERM=rxvt-unicode-256color
export XDG_CURRENT_DESKTOP=bspwm
export MANPAGER="nvim -c 'set ft=man' - "

#aliases
alias ..='cd ..'
alias l='ls --color=auto'
alias ls='ls --color=auto'
alias ll='ls --color=auto -al'
alias key="vim $HOME/.config/spectrwm/keybindings.conf"
alias wm="vim ~/.config/spectrwm/spectrwm.conf"
alias f="ranger"
alias weather="curl wttr.in"
alias py="/usr/bin/python"
alias pg="ping google.com"
alias k="pkill "
alias m="cmus"
alias vimrc="vim $HOME/.config/nvim/init.vim"
alias v="nvim"
alias vim="nvim"
alias sudo="sudo "
alias mp3dl="youtube-dl -x --audio-format mp3"
alias o="xdg-open"

up() {
    curl -F "file=@$*" https://0x0.st | xclip -selection clipboard
}

dict() {
    curl dict://dict.org/d:$* | less
}

sip() {
    curl https://ipinfo.io/$*
}

rmdata() {
    exiftool -overwrite_original -all= $*
}

generate() {
    rm ~/src/site/dst/.files
    ssg5 ~/src/site/src ~/src/site/dst "pryr's website" "https://pryr.xyz"
    # rssg ~/src/site/dst/index.html "pryr\'s feed" > ~/src/site/dst/rss.xml
}

deploy() {
    rsync --rsync-path "sudo -u www-data rsync" -avP --delete ~/src/site/dst/ rem:site/
}

bind() {
    ssh -L localhost\:$1\:localhost\:$1 $2
}

# Enable colors and change prompt:
autoload -U colors && colors
fpath+=$HOME/.cache/zsh/pure
autoload -U promptinit; promptinit
prompt pure
PURE_PROMPT_SYMBOL=$
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
#_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
# export KEYTIMEOUT=1

# reverse search
bindkey '^R' history-incremental-search-backward

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Load plugins
source ~/.cache/zsh/plugins/sudo.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
