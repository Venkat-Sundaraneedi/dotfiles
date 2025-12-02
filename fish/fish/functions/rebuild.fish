function rebuild
    # Save current directory and change to config location
    set -l prev_dir (pwd)
    cd ~/git/dotfiles/mysystem/
    nix flake update
    
    # Edit configuration
    nvim nixos/configuration.nix
    
    # Format all nix files
    alejandra nixos/*.nix 2>/dev/null
    
    # Show what changed
    git diff nixos/*.nix
    
    # Rebuild NixOS
    echo "NixOS Rebuilding..."
    if nh os switch 2>&1 | tee /tmp/nixos-switch.log
        # Get current generation info using nh
        set -l gen_info (nh os info 2>/dev/null | head -n 1 | string trim)
        set -l gen_date (date '+%Y-%m-%d %H:%M:%S')
        
        # Create commit message
        set -l commit_msg "NixOS rebuild on $gen_date"
        if test -n "$gen_info"
            set commit_msg "$commit_msg - $gen_info"
        end
        
        # Ask user if proceed with commit and push
        read -P "Proceed with commit and push? (Y/n): " choice
        if test "$choice" != "n" -a "$choice" != "N"
            # Commit changes
            git add -A
            if git commit -m "$commit_msg"
                echo "✓ Changes committed!"
                if git push
                    echo "✓ Changes pushed!"
                else
                    echo "Failed to push"
                end
            else
                echo "Commit failed"
            end
        else
            echo "Skipping commit and push"
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
