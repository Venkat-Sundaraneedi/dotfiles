ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

bindkey -v 
bindkey '^b' history-search-backward
bindkey '^f' history-search-forward


# Automatically start Zellij if not already inside Zellij
if [ -z "$ZELLIJ" ]; then
    zellij
fi


for file in ~/scripts/*.sh; do
  [ -r "$file" ] && source "$file"
done

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

alias n='nvim'
alias s='zsh'
alias a='asdf'
alias e='exit'
alias c='clear'
alias p='pwd'
alias l='eza -l'
alias m='zellij'
alias f='fzf'
alias y='ranger'
alias nf="nvim \$(fzf --preview='cat {}')"
alias f="fzf --preview='cat {}'"
alias la='eza -la'
alias ls='ls --color'
alias fb='forge build'
# alias fb='forge build'
alias cn='clear && nvim'
alias lg='lazygit'
alias al='asdf list'
alias cdd='cd ..'
alias gst='git status'
alias sla='sudo ls -la'
alias rmf='rm -rf'
alias sos='source ~/.zshrc'
alias srmf='sudo rm -rf'
alias confn='nvim ~/.config/nvim/'
alias confs='n ~/.zshrc'
. "/home/greed/.starkli/env"



# Load completions
fpath=(~/zcompdump $fpath)
autoload -Uz compinit && compinit -d $ZCOMPUMP
zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


export PATH="$HOME/.fuelup/bin:$PATH"
