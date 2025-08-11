# ~/.config/fish/functions/smake.fish

function smake
    if test (count $argv) -lt 1
        echo "Usage: smake <make_target>"
        echo "Example: smake deploy-sepolia-interact"
        echo "Example: smake fund-interact"
        return 1
    end

    set -l make_target $argv[1]
    set -l vars_to_prompt # This array will hold variable names specific to the target

    switch $make_target
        case "deploy-sepolia-interact"
            set vars_to_prompt PRIVATE_KEY_SEPOLIA_DEPLOYER ETHERSCAN_API_KEY SEPOLIA_RPC_URL
            set -l actual_make_target "deploy-sepolia-headless"
        case "fund-interact"
            set vars_to_prompt PRIVATE_KEY_SEPOLIA_FUNDER SENDER_ADDRESS SEPOLIA_RPC_URL
            set -l actual_make_target "fund"
        case "withdraw-interact"
            set vars_to_prompt PRIVATE_KEY_SEPOLIA_FUNDER SENDER_ADDRESS SEPOLIA_RPC_URL
            set -l actual_make_target "withdraw"
        case "*"
            # For any other make target, just load .env and execute directly.
            # No specific interactive variables by default.
            set vars_to_prompt # No specific interactive prompts for generic targets
            set -l actual_make_target $make_target
    end

    # b. If no .env is detected, ask the user whether they want to create a .env template
    set -l project_env_path "./.env"
    if test -f $project_env_path
        echo "Loading variables from $project_env_path..."
        set -l env_lines (awk '!/^#|^$$/{print}' $project_env_path)
        for line in $env_lines
            set -l parts (string split '=' $line)
            set -l var_name $parts[1]
            set -l var_value (string join '=' $parts[2..-1] | string replace -r '^"|"$|^'\''|'\''$' '')
            set -gx "$var_name" "$var_value" # Set as global environment variable
        end
        echo "Variables loaded."
    else
        read -P "No ./.env file detected. Would you like to create a boilerplate .env template? (y/N): " -l create_env_confirm
        if test "$create_env_confirm" = "y" -o "$create_env_confirm" = "Y"
            echo "# Example .env (add to .gitignore!)" > $project_env_path
            echo "SEPOLIA_RPC_URL=\"\"" >> $project_env_path
            echo "PRIVATE_KEY_SEPOLIA_DEPLOYER=\"\"" >> $project_env_path
            echo "PRIVATE_KEY_SEPOLIA_FUNDER=\"\"" >> $project_env_path
            echo "ETHERSCAN_API_KEY=\"\"" >> $project_env_path
            echo "" >> $project_env_path
            echo "A boilerplate .env file has been created at $project_env_path."
            echo "Please fill in your values in .env, then re-run 'smake $make_target'."
            return 1 # Exit the function, user needs to fill .env and re-run
        else
            echo "Proceeding without .env file. You might be prompted for more variables."
        end
    end

    # a. Iterate through the automatically determined variables for interactive/secure input
    for var_name in $vars_to_prompt
        # Determine if input should be silent or visible
        set -l prompt_flags "-P" # Default visible prompt
        if string match -q "PRIVATE_KEY_*" "$var_name"
            set prompt_flags "-sP" # Silent prompt for private keys
        end

        set -l current_value (eval echo $$var_name)

        # Skip prompting if the variable is already set AND it's not a private key
        # AND the user explicitly said "y" to "Use from environment?"
        # For private keys, we still always ask to ensure the user acknowledges its use or provides new.
        if test -n "$current_value"
            set -l display_value "(value present)"
            if not string match -q "*PRIVATE_KEY*" "$var_name"
                set display_value "$current_value" # Only display non-private key values
            end

            read $prompt_flags "Use $var_name from environment? (Y/n) [Current: $display_value]: " -l confirm
            if test "$confirm" = "n" -o "$confirm" = "N"
                read $prompt_flags "Enter new value for $var_name (will not be displayed for sensitive vars): " -l new_value
                if test -n "$new_value"
                    set -gx "$var_name" "$new_value"
                    echo "$var_name updated securely."
                else
                    echo "No new value entered for $var_name. Using previous value if any."
                end
            else
                echo "Using $var_name from environment."
            end
        else
            # If not set, always prompt for it securely
            read $prompt_flags "Enter value for $var_name (will not be displayed for sensitive vars): " -l new_value
            if test -n "$new_value"
                set -gx "$var_name" "$new_value"
                echo "$var_name set securely."
            else
                echo "Warning: No value provided for $var_name."
            end
        end
    end

    echo "Executing: make $actual_make_target"
    command make $actual_make_target
end
