function md
    set -l dir_name
    if test -n "$argv[1]"
        set dir_name "$argv[1]"
    else
        set dir_name "new_directory_(date '+%Y-%m-%d_%H-%M-%S')"
    end

    # Validate directory name
    if not string match --regex '^[a-zA-Z0-9_.-]+$' "$dir_name"
        echo "Error: Invalid directory name '$dir_name'" >&2
        return 1
    end

    # Create the directory
    if not mkdir -p "$dir_name"
        echo "Error: Failed to create directory '$dir_name'" >&2
        return 1
    end

    # Navigate into the directory
    if not cd "$dir_name"
        echo "Error: Failed to navigate to directory '$dir_name'" >&2
        return 1
    end

    # Provide feedback
    echo "Created and switched to directory: $dir_name"
end

