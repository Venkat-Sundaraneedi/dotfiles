# Environment variables and paths

# Add paths
$env.PATH ++= [
    $"($env.HOME)/.local/share/solana/install/active_release/bin"
    $"($env.HOME)/.local/share/nvim/mason/bin"
    $"($env.HOME)/.bun/bin"
    $"($env.HOME)/.cargo/bin"
    $"($env.HOME)/.local/bin"
]

# Environment variables
$env.FOUNDRY_DISABLE_NIGHTLY_WARNING = 1
$env.NH_OS_FLAKE = "/home/greed/git/dotfiles/mysystem/"
$env.NH_HOME_FLAKE = "/home/greed/git/dotfiles/mysystem/nixos/home-manager/"
$env.ATAC_KEY_BINDINGS = $"($env.HOME)/.config/atac/vim_key_bindings.toml"
$env.GPG_TTY = (^tty)

# Tool integrations
source ~/.zoxide.nu
source ~/.mise.nu

# Direnv hook
$env.config.hooks.pre_prompt ++= [{
    if (which direnv | is-empty) { return }
    direnv export json | from json | default {} | load-env
    if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
        $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
    }
}]

# SSH agent
do --env {
    let ssh_agent_file = (
        $nu.temp-path | path join $"ssh-agent-(whoami).nuon"
    )

    if ($ssh_agent_file | path exists) {
        let ssh_agent_env = open ($ssh_agent_file)
        if ($"/proc/($ssh_agent_env.SSH_AGENT_PID)" | path exists) {
            load-env $ssh_agent_env
            return
        } else {
            rm $ssh_agent_file
        }
    }

    let ssh_agent_env = ^ssh-agent -c
        | lines
        | first 2
        | parse "setenv {name} {value};"
        | transpose --header-row
        | into record
    load-env $ssh_agent_env
    $ssh_agent_env | save --force $ssh_agent_file
}

# Aliases
alias ll = ls -l  
alias l = ls   
alias rmf = rm -rf
alias srmf = sudo rm -rf
alias cdd = cd ..
alias lg = lazygit
alias ld = lazydocker
alias lj = jjui
alias c = clear
alias e = exit
alias z = zellij
alias n = nvim
alias wifi = impala
alias blue = bluetui
alias p = poetry
alias dev = nom develop --command nu

# Functions
def neoup [] {
    mise uninstall asdf:neovim@nightly
    mise use -g asdf:neovim@nightly
}

def gitp [] {
    git config --local user.name "Venkat-Sundaraneedi"
    git config --local user.email "venkat.subrahmanyam.34@gmail.com"
    echo "Git user set to personal"
}

def gitc [] {
    git config --local user.name "wdcs-venkatsundaraneedi"
    git config --local user.email "venkat.sundaraneedi@codezeros.com"
    echo "Git user set to work"
}

# Disable banner
$env.config.show_banner = false

# Editor mode and keybindings
$env.config.edit_mode = 'vi'

$env.config.cursor_shape = {
    vi_normal: block
    vi_insert: line
}

$env.config.keybindings ++= [
    {
        name: toggle_to_insert
        modifier: alt
        keycode: char_e
        mode: vi_normal
        event: { send: ViChangeMode mode: 'insert' }
    }
    {
        name: toggle_to_normal
        modifier: alt
        keycode: char_e
        mode: vi_insert
        event: { send: ViChangeMode mode: 'normal' }
    }
    {
        name: open_in_editor
        modifier: alt
        keycode: char_o
        mode: [vi_insert, vi_normal]
        event: { send: OpenEditor }
    }
]

