# ~/.config/fish/functions/create_aptos_project.fish

function create_aptos_project
    echo "Enter the name for your new Aptos Move project:"
    read -P "Project Name: " PROJECT_NAME

    if test -z "$PROJECT_NAME"
        echo "Project name cannot be empty. Aborting."
        return 1
    end

    # Check if directory already exists in the current path
    if test -d "$PROJECT_NAME"
        echo "Error: Directory '$PROJECT_NAME' already exists in the current location. Aborting."
        return 1
    end

    echo "Creating directory: $PROJECT_NAME"
    mkdir "$PROJECT_NAME"
    if not test -d "$PROJECT_NAME"
        echo "Failed to create directory '$PROJECT_NAME'. Aborting."
        return 1
    end

    # Change into the new directory
    cd "$PROJECT_NAME"
    git init

    echo "Initializing Aptos Move project: $PROJECT_NAME"
    # Ensure aptos move init runs successfully
    aptos move init --name "$PROJECT_NAME"
    if test $status -ne 0
        echo "Aptos Move project initialization failed. Cleaning up and aborting."
        # Clean up the created directory on failure
        cd ..
        rm -r "$PROJECT_NAME"
        return 1
    end

    echo "Adding movefmt.toml configuration..."
    # Using printf for robustness in fish functions
    printf "%s\n" \
"max_width = 90" \
"indent_size = 2" \
"hard_tabs = false" \
"tab_spaces = 2" \
"emit_mode = \"Overwrite\"" \
"verbose = \"Normal\"" \
"prefer_one_line_for_short_branch_blk = true" \
"prefer_one_line_for_short_call_para_list = true" \
"prefer_one_line_for_short_fn_header_para_list = true" \
"prefer_one_line_for_short_lambda_para_list = true" \
"skip_formatting_dirs = \"\"" \
"auto_apply_package = false" \
> movefmt.toml

    echo "Project '$PROJECT_NAME' initialized successfully with movefmt.toml!"

    echo "Current project structure:"
    # Using 'tree' for a nice visual, with a fallback to 'ls -F'
    if command -v tree > /dev/null
        tree --gitignore -L 5
    else
        echo "  (Consider installing 'tree' for a visual directory structure: sudo apt install tree)"
        ls -F
    end

    echo "You are now in the '$PROJECT_NAME' directory."
    # Optional: You might want to run move fmt here to apply rules immediately
    echo "Running aptos move fmt..."
    movefmt
    if test $status -ne 0
        echo "Warning: aptos move fmt encountered issues."
    end
end
