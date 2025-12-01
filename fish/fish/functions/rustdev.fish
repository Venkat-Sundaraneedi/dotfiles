function rustdev
    # Check if required commands are available
    if not command -q jj
        echo "Error: 'jj' (Jujutsu) is not installed"
        return 1
    end
    if not command -q jjui
        echo "Error: 'jjui' is not installed"
        return 1
    end
    # Check if a directory name was provided
    if test (count $argv) -eq 0
        echo "Usage: rustdev <directory_name>"
        return 1
    end
    set dir_name $argv[1]
    # Create directory and check if successful
    if not mkdir -p $dir_name
        echo "Error: Failed to create directory '$dir_name'"
        return 1
    end
    # Change to the directory
    cd $dir_name; or return 1
    echo "Created and entered directory: $dir_name"
    # Initialize nix flake
    echo "Initializing Nix flake with Rust template..."
    nix flake init -t templates#rust; or return 1
    touch mise.toml; or return 1
    
    # Create .envrc for direnv
    echo "Creating .envrc for direnv..."
    echo 'export _nix_direnv_nix="$(which nom)"' > .envrc
    echo 'use flake' >> .envrc
    
    # Allow direnv first so we get access to cargo and other tools
    echo "Allowing direnv for this directory..."
    direnv allow; or return 1
    
    # Load the direnv environment
    eval (direnv export fish)
    
    # Initialize cargo (now that direnv has loaded the environment)
    echo "Initializing Cargo..."
    cargo init --vcs none; or return 1

    echo '/target/' >> .gitignore
    echo "# For nix-os workflow" >> .gitignore
    echo '.direnv/' >> .gitignore
    echo '.envrc' >> .gitignore
    
    # Initialize jujutsu
    echo "Initializing Jujutsu repository..."
    jj git init; or return 1
    jj describe -m 'initial commit'; or return 1
    
    # Clear screen and launch jjui
    clear
    jjui
end
