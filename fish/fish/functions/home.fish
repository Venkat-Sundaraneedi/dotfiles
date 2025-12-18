function home
    # Save current directory and change to config location
    set -l prev_dir (pwd)
    cd ~/git/dotfiles/mysystem/nixos/home-manager/
    nix flake update
    
    # Edit configuration
    nvim ./home.nix
    
    # Format all nix files
    alejandra ./*.nix 2>/dev/null
    
    # Show what changed
    git diff ./*.nix
    
    # Rebuild Home-Manager
    echo "Home-Manager Rebuilding..."
    if nh home switch 2>&1 | tee /tmp/home-switch.log
        # Get current generation info using home-manager generations
        set -l gen_info (home-manager generations | grep "(current)" | awk '{print $1 " " $2 " id " $4}' | string trim)
        set -l gen_date (date '+%Y-%m-%d %H:%M:%S')
        
        # Create commit message
        set -l commit_msg "Home-Manager rebuild on $gen_date"
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
        grep --color error /tmp/home-switch.log
        cd $prev_dir
        return 1
    end
    
    # Return to previous directory
    cd $prev_dir
end
