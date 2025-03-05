alias n='nvim'
alias s='zsh'
alias a='asdf'
alias e='exit'
alias c='clear'
alias l='eza -l'
alias m='zellij'
alias f='fzf'
alias y='yazi'
alias fsi='forge soldeer init  && rm -rf remappings.txt  && soldeer_template && forge soldeer install && mkdir src test script && clear && nvim'
alias sp='spotify_player'
alias la='eza -la'
alias ls='ls --color'
alias fb='forge build'
alias fd='fdfind'
alias cn='clear && nvim'
alias lg='lazygit'
alias pn='pnpm'
alias al='asdf list'
alias cdd='cd ..'
alias gst='git status'
alias ght='~/projects/scripts/gh-tui.sh'
alias sla='sudo ls -la'
alias rmf='rm -rf'
alias sos='source ~/.zshrc'
alias srmf='sudo rm -rf'
alias pye='python -m venv venv && source venv/bin/activate'
alias pya='source venv/bin/activate'
alias pyd='deactivate'
alias confn='nvim ~/.config/nvim/'
alias confs='n ~/.zshrc'

alias brave="/mnt/c/Program\ Files/BraveSoftware/Brave-Browser/Application/brave.exe"
alias firefox="/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe"
alias code="/mnt/c/Program\ Files/VSCodium/VSCodium.exe"
alias kanata="/mnt/c/Users/Venkat/AppData/Roaming/kanata/kanata.exe -c /home/greed/.config/kanata/config.kbd"

cdf() {
    cd "$(fdfind --type dir --follow --hidden --color=always --exclude .git  | fzf --preview 'bat -n --color=always {}')" || exit
}
nf() {
    nvim "$(fdfind --type file --follow --hidden --color=always --exclude .git  | fzf --preview 'bat -n --color=always {}')"
}


