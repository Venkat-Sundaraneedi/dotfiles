ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
# zinit light jeffreytse/zsh-vi-mode # Vim bindings
# ZVM_VI_EDITOR=nvim
# zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
# zinit light marlonrichert/zsh-autocomplete


# Automatically start Zellij if not already inside Zellij
if [ -z "$ZELLIJ" ]; then
    zellij
fi

export PATH="$PATH:/mnt/d/wsl/tools/"

for file in ~/scripts/*.sh; do
  [ -r "$file" ] && source "$file"
done

# Add this to your .zshrc
export FZF_DEFAULT_COMMAND="fdfind  --follow --hidden --color=always --exclude .git"
export FZF_CTRL_T_OPTS="
  --bind 'tab:down,btab:up'  # Use Tab to move down, Shift+Tab to move up
  --bind 'enter:accept'      # Press Enter to select the highlighted item
  --no-multi                 # Disable multi-selection
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

export FZF_DEFAULT_OPTS=" 
--preview 'bat -n --color=always fzf-preview.sh {}' 
--ansi
--bind 'focus:transform-header:file 
--brief {}'
"
eval "$(fzf --zsh )"
eval "$(zoxide init --cmd cd zsh )"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# Load completions
# fpath=(~/zcompdump $fpath)
autoload -Uz compinit && compinit 
# autoload -Uz compinit && compinit -d $ZCOMPUMP
# zinit cdreplay -q

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt auto_cd
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# zstyle ':completion:*' completer _expand _complete _correct _approximate _correct _history
zstyle ':completion:*' completer _expand _complete  
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=2
# zstyle ':completion:*' menu no
zstyle ':completion:*' group-name ''
# zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' format ' %F{blue}-- %d --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
#
# # zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# # zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
#
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


eval "$(gh copilot alias -- zsh)"

# rust
export RUST_HOME="$HOME/.cargo/env"
case ":$PATH:" in
  *":$RUST_HOME:"*) ;;
  *) export PATH="$RUST_HOME:$PATH" ;;
esac
# rust end

# Add Starkli environment
if [ -f "/home/greed/.config/.starkli/env" ]; then
    . "/home/greed/.config/.starkli/env"
fi
export STARKNET_ACCOUNT=$(pwd)/account.json
export STARKNET_KEYSTORE=$(pwd)/keystore.json
# Add Starkli bin to PATH
export PATH="/home/greed/.config/.starkli/bin:$PATH"

# solana
export SOLANA_HOME="$HOME/.local/share/solana/install/active_release/bin"
case ":$PATH:" in
  *":$SOLANA_HOME:"*) ;;
  *) export PATH="$SOLANA_HOME:$PATH" ;;
esac
# solana end

. "/home/greed/.config/.starkli/env"

# pnpm
export PNPM_HOME="/home/greed/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
