function fish_greeting
    echo "Happy coding! May your commits be clean and your builds fast."
end

if status is-interactive
end

mise activate fish | source
pitchfork activate fish | source
atuin init fish | source

if status is-interactive; and not set -q ZELLIJ
  zellij
end

fish_add_path "/opt/android-sdk/platform-tools"
fish_add_path "$HOME/.local/share/nvim/mason/bin"
fish_add_path "$HOME/.local/share/mise/shims"
fish_add_path "$HOME/.cyfrin/bin"
fish_add_path "$HOME/.bun/bin"
fish_add_path "$HOME/.config/cargo/bin"
fish_add_path "$HOME/.local/share/solana/install/active_release/bin/"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.foundry/bin"


set -gx CORE_RETROARCH /home/greed/.local/share/Steam/steamapps/common/RetroArch/cores/
set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx RUSTUP_HOME "$HOME/.config/rustup"
set -gx CARGO_HOME "$HOME/.config/cargo"

# Zoxide
set -gx _ZO_CD zi
zoxide init --cmd cd fish | source

alias l='eza -l --icons --group-directories-first '
alias la='eza -la --icons --group-directories-first '
alias ls='eza --icons --group-directories-first --tree --level=2'
alias rmf="rm -rf"
alias cn="clear && nvim"
alias cdd="cd .."
alias lg="lazygit"
alias lj="jjui"
alias ld="lazydocker"
alias c="clear"
alias e="exit"
alias wifi="impala"
alias blue="bluetui"
alias battery="acpi -b"
alias n="nvim"
alias p="poetry"
alias pya="source .venv/bin/activate.fish"
alias pyd="deactivate"

 function stdrs
   set -l original_dir (pwd)
   cd (rustc --print sysroot)/lib/rustlib/src/rust/library/core/src
   nvim
   cd $original_dir
 end

 function cdp
   set -l dir (fd . / --type d 2>/dev/null | fzf --preview 'eza -la --color=always {}' --preview-window=right:50%)
   if test -n "$dir"
     echo "$dir"
   end
 end

 function cdf
   set -l dir (fd . / --type d | fzf --preview 'eza -la --color=always {}' --preview-window=right:50%)
   if test -n "$dir"
     cd "$dir"
     clear
   end
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

bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"   
bind -M insert alt-l forward-char
set -g fish_sequence_key_delay_ms 200

fish_ssh_agent
