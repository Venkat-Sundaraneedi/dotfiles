skip_global_compinit=1

# other xdg paths
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

. "$HOME/.asdf/asdf.sh"

export OPENSSL_DIR=/usr
export OPENSSL_LIB_DIR=/usr/lib/x86_64-linux-gnu
export OPENSSL_INCLUDE_DIR=/usr/include
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig
export ZCOMPUMP="$HOME/zcompdump/.zcompdump"
export BROWSER="/mnt/c/Program\ Files/BraveSoftware/Brave-Browser/Application/brave.exe"

export ZELLIJ_SOCKET_DIR=/tmp/zellij zellij
export CARGO_HOME="$HOME/.config/.cargo"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$HOME/.bun/install/cache/:$PATH"
# export PATH="$HOME/.asdf/installs/rust/1.79.0/bin:$PATH"
export PATH="$HOME/.asdf/installs/rust/1.85.0/bin:$PATH"
# export PATH="$HOME/.asdf/installs/rust/1.84.1/bin:$PATH"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
# export PATH="$PATH:/mnt/c/Program\ Files/Neovim/bin/"
export PATH="$HOME/.fuelup/bin:$PATH"
export PATH="$PATH:/home/greed/.foundry/bin"
export PATH="$PATH:/home/greed/.fuelup/bin"
export PATH="$PATH:/home/greed/.local/bin"
export PATH="$PATH:/home/greed/.config/.cargo/bin"
export PATH="$PATH:/home/greed/.asdf/installs/golang/1.24.0/packages/bin"
export PATH="/home/greed/.cache/.bun/bin:$PATH"

. "/home/greed/.config/.starkli/env"
export PATH="$PATH:/home/greed/.local/bin"
export PATH="$PATH:/home/greed/.config/.foundry/bin"
export GEMINI_API_KEY="AIzaSyABvX9m9zF98yZxgiVhIGMxC_nqkR2PJXQ"
