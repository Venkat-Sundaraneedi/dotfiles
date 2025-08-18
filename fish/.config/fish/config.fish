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
    atuin init fish | source
end

# Automatically start Zellij if not already inside Zellij
if not set -q ZELLIJ
    zellij
end

# ~/.config/fish/functions/fish_add_path.fish
function fish_add_path --description "Add a path to fish_user_paths if it's not already there"
    for p in $argv
        if not contains $p $fish_user_paths
            set -U fish_user_paths $fish_user_paths $p
        end
    end
end


# # ASDF Paths
# set -gx fish_user_paths (string replace "$HOME" "~" "$ASDF_DATA_DIR")"/shims" $fish_user_paths
# set -gx fish_user_paths "$HOME/.asdf/downloads" $fish_user_paths

fish_add_path "$HOME/.asdf/shims"
fish_add_path "$HOME/.asdf/downloads"
fish_add_path "$HOME/.local/share/nvim/mason/bin"
fish_add_path "$HOME/.cyfrin/bin"
fish_add_path "$HOME/.bun/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.atuin/bin"
fish_add_path "$HOME/.avm/bin"
fish_add_path "$HOME/.local/share/solana/install/active_release/bin/"


set -gx fish_user_paths "$HOME/.local/bin" $fish_user_paths

# Zoxide
set -gx _ZO_CD 'zi'
zoxide init --cmd cd fish | source

# Foundry
set -gx fish_user_paths "$HOME/.foundry/bin" $fish_user_paths

alias l="eza -l"
alias ls="eza -lah --group-directories-first"
alias rmf="rm -rf"
alias cn="clear && nvim"
alias cdd="cd .."
alias lg="lazygit"
alias c="clear"
alias n="nvim"
alias e="exit"

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



  function neoup
    asdf uninstall neovim nightly
    asdf install neovim nightly
    end


  function gitp
        git config --local user.name "wdcs-venkatsundaraneedi"
        git config --local user.email "venkat.sundaraneedi4@codezeros.com"
        echo "Git user.name set to: wdcs-venkatsundaraneedi"
        echo "Git user.email set to: venkat.sundaraneedi4@codezeros.com"
    end

fish_vi_key_bindings

bind --mode default \ck 'history-search-backward'
bind --mode default \cj 'history-search-forward'

# This binds the sequence j,k to switch to normal mode in vi mode.
# If you kept it like that, every time you press "j",
# fish would wait for a "k" or other key to disambiguate
bind -M insert -m default j,k cancel repaint-mode

# After setting this, fish only waits 200ms for the "k",
# or decides to treat the "j" as a separate sequence, inserting it.
set -g fish_sequence_key_delay_ms 200

fish_ssh_agent
