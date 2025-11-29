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

    # Enter nix development environment and initialize cargo
    echo "Entering Nix development environment and initializing Cargo..."
    nom develop --command fish -c "cargo init --vcs none; and jj git init; and jj describe -m 'initial commit'; and clear; and jjui; and exec fish"; or return 1
end
