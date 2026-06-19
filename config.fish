source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    # smth smth
end

set -Ux EDITOR nvim
set -Ux TZ PST8PDT

alias g="git"
alias v="nvim"
alias ga="git add ."
alias k="kubectl"
alias gst="git status"
alias gc="git commit -m "
alias gd="git diff"
alias kk="k9s"
alias ts="tailscale"
alias f="yazi"
