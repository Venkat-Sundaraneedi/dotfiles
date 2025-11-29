function rebuild
    # Save current directory and change to config location
    set -l prev_dir (pwd)
    cd ~/mysystem
    
    # Edit configuration
    nvim nixos/configuration.nix
    
    # Format all nix files
    nixfmt nixos/*.nix 2>/dev/null
    
    # Show what changed
    git diff -U0 nixos/*.nix
    
    # Rebuild NixOS
    echo "NixOS Rebuilding..."
    if nh os switch 2>&1 | tee /tmp/nixos-switch.log
        # Get current generation info using nh
        set -l gen_info (nh os info 2>/dev/null | head -n 1 | string trim)
        set -l gen_date (date '+%Y-%m-%d %H:%M:%S')
        
        # Create commit message
        if test -n "$gen_info"
            set -l commit_msg "NixOS: $gen_info"
        else
            set -l commit_msg "NixOS rebuild on $gen_date"
        end
        
        # Commit changes
        git add -A
        
        # Prompt user before committing (in case SSH passphrase is needed)
        echo ""
        echo "Commit message: $commit_msg"
        read -P "Commit changes? (y/n): " -n 1 commit_choice
        
        if test "$commit_choice" = "y"
            git commit -m "$commit_msg"
            echo "✓ Changes committed!"
        else
            echo "Skipping commit"
        end
        
        echo "✓ Rebuild successful!"
    else
        # Show errors if rebuild failed
        grep --color error /tmp/nixos-switch.log
        cd $prev_dir
        return 1
    end
    
    # Return to previous directory
    cd $prev_dir
end
