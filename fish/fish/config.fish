function fish_greeting
    echo "Happy coding! May your commits be clean and your builds fast."
    # echo (set_color cyan)"
    #   _______
    #  < fish! >
    #   -------
    #          \\
    #           \\
    #            /\\_/\\
    #           ( o.o )
    #            > ^ <
    # "(set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Automatically start Zellij if not already inside Zellij
# if not set -q ZELLIJ
#     zellij
# end

fish_add_path "$HOME/.local/share/solana/install/active_release/bin"
fish_add_path "$HOME/.local/share/nvim/mason/bin"
fish_add_path "$HOME/.bun/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.local/bin"

set -x FOUNDRY_DISABLE_NIGHTLY_WARNING 1
set -gx EDITOR nvim
set -gx VISUAL nvim
# set -Ux NH_FLAKE "/home/greed/git/dotfiles/mysystem/"
set -Ux NH_OS_FLAKE "/home/greed/git/dotfiles/mysystem/"
set -Ux NH_HOME_FLAKE "/home/greed/git/dotfiles/mysystem/nixos/home-manager/"


set -gx GPG_TTY (tty)

# Zoxide
set -gx _ZO_CD zi
zoxide init --cmd cd fish | source
mise activate fish | source
direnv hook fish | source

# Foundry
# set -gx fish_user_paths "$HOME/.foundry/bin" $fish_user_paths

alias l="eza -l --group-directories-first --icons"
alias la="eza -lah --group-directories-first --icons"
alias ls="eza -lah --group-directories-first --icons --tree --level=2 --git-ignore"
alias rmf="rm -rf"
alias srmf="sudo rm -rf"
alias cn="clear && nvim"
alias cdd="cd .."
alias lg="lazygit"
alias ld="lazydocker"
alias lj="jjui"
alias c="clear"
alias e="exit"
alias z="zellij"
alias n="nvim"
alias wifi="impala"
alias blue="bluetui"
alias p="poetry"
alias pya="source .venv/bin/activate.fish"
alias pyd="deactivate"
alias dev="nom develop --command fish"

alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"
alias gl="git log"
alias gp="git push"
alias gu="git pull"
alias gi="git init"
alias gcl="git clone"
alias gs="git status --short"

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function neoup
  mise uninstall asdf:neovim@nightly
  mise use -g asdf:neovim@nightly
end

function gitp
    git config --local user.name Venkat-Sundaraneedi
    git config --local user.email "venkat.subrahmanyam.34@gmail.com"
    echo "Git user.name set to: Venkat-Sundaraneedi"
    echo "Git user.email set to: venkat.subrahmanyam.34@gmail.com"
end

function gitc
    git config --local user.name wdcs-venkatsundaraneedi
    git config --local user.email "venkat.sundaraneedi@codezeros.com"
    echo "Git user.name set to: wdcs-venkatsundaraneedi"
    echo "Git user.email set to: venkat.sundaraneedi@codezeros.com"
end

fish_vi_key_bindings

bind --mode default ctrl-k history-search-backward
bind --mode default ctrl-j history-search-forward

# This binds the sequence j,k to switch to normal mode in vi mode.
# If you kept it like that, every time you press "j",
# fish would wait for a "k" or other key to disambiguate
bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
bind -M insert alt-l forward-char

# After setting this, fish only waits 200ms for the "k",
# or decides to treat the "j" as a separate sequence, inserting it.
set -g fish_sequence_key_delay_ms 200

fish_ssh_agent

