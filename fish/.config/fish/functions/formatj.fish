function formatj
    # Check if required tools are installed
    if not command -v jq >/dev/null 2>&1
        echo "Error: jq is not installed. Please install it first." >&2
        return 1
    end
    if not command -v fzf >/dev/null 2>&1
        echo "Error: fzf is not installed. Please install it first." >&2
        return 1
    end

    # Present menu options using fzf
    set -l choice
    set choice (echo -e "1. Format all unformatted JSON files\n2. Select specific JSON files to format" | \
                fzf --prompt="Select formatting option: " --height=20%)

    switch "$choice"
        case "1. Format all unformatted JSON files"
            # Process all JSON files automatically
            find . -type f -name "*.json" | while read -l file
                echo "Processing $file..."
                set -l temp_file (mktemp)

                if jq '.' "$file" > "$temp_file"
                    if cmp -s "$temp_file" "$file"
                        echo "Skipping $file (already formatted)"
                        rm "$temp_file"
                    else
                        mv "$temp_file" "$file"
                        echo "Successfully formatted $file"
                    end
                else
                    rm "$temp_file"
                    echo "Error formatting $file" >&2
                end
            end

        case "2. Select specific JSON files to format"
            # Interactive file selection using fzf
            set -l selected_files (find . -type f -name "*.json" | \
                                   fzf --multi --preview 'cat {}' --preview-window=right:60%:wrap)

            if test -z "$selected_files"
                echo "No files selected."
                return 0
            end

            echo "$selected_files" | while read -l file
                echo "Processing $file..."
                set -l temp_file (mktemp)

                if jq '.' "$file" > "$temp_file"
                    if cmp -s "$temp_file" "$file"
                        echo "Skipping $file (already formatted)"
                        rm "$temp_file"
                    else
                        mv "$temp_file" "$file"
                        echo "Successfully formatted $file"
                    end
                else
                    rm "$temp_file"
                    echo "Error formatting $file" >&2
                end
            end

        case "*"
            echo "No option selected. Exiting."
            return 0
    end
end

