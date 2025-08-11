# ~/.config/fish/functions/foundry-makefile.fish

function fmake
    set -l template_path ~/.config/fish/templates/foundry-makefile-template
    set -l target_file ./Makefile

    if test -f $target_file
        read -P "Makefile already exists. Overwrite? (y/N): " -l confirm
        if test "$confirm" != "y" -a "$confirm" != "Y"
            echo "Operation cancelled."
            return 1
        end
    end

    if test -f $template_path
        cp $template_path $target_file
        echo "Makefile copied to $target_file"
        echo "Remember to create a .env file for sensitive variables (e.g., SEPOLIA_RPC_URL, PRIVATE_KEY_SEPOLIA_DEPLOYER, ETHERSCAN_API_KEY) and add it to .gitignore!"
        # Optionally, create a boilerplate .env if it doesn't exist
        if ! test -f ./.env
            echo "# Example .env (add to .gitignore!)" > ./.env
            echo "SEPOLIA_RPC_URL=\"\"" >> ./.env
            echo "PRIVATE_KEY_SEPOLIA_DEPLOYER=\"\"" >> ./.env
            echo "PRIVATE_KEY_SEPOLIA_FUNDER=\"\"" >> ./.env
            echo "ETHERSCAN_API_KEY=\"\"" >> ./.env
            echo "" >> ./.env
            echo "Created a boilerplate .env file. Please fill in your values."
        end
    else
        echo "Error: Makefile template not found at $template_path"
        echo "Please create it first: $template_path"
        return 1
    end
end
