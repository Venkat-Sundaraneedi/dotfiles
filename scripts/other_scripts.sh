# Creates directory and navigates into it
md() {
    # Use the argument as the directory name, or a human-readable default if none is provided
    local dir_name="${1:-new_directory_$(date '+%Y-%m-%d_%H-%M-%S')}"

    # Create the directory and navigate into it
    mkdir -p "$dir_name" && cd "$dir_name" || {
        echo "Error: Failed to create or navigate to '$dir_name'"
        return 1
    }

    # Provide feedback
    echo "Created and switched to directory: $dir_name"
}


# Extracts common archive formats
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.Z)       uncompress "$1" ;;
            *)         echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}



# List All Aliases
lista() {
    local yellow='\033[1;33m' # Bold Yellow
    local blue='\033[0;34m'   # Blue
    local green='\033[0;32m'
    local gray='\033[0;90m'
    local  nc='\033[0m'

    echo -e "${yellow}User-Defined Aliases:${nc}"
    echo -e "${gray}--------------------------------------${nc}"

    # Process aliases from .zshrc and format correctly
    grep '^alias ' ~/.zshrc | while IFS= read -r line; do
        # Extract alias name and value
        local name=$(echo "$line" | sed -E 's/^alias ([^=]+)=.*/\1/')
        local value=$(echo "$line" | sed -E "s/^alias [^=]+='(.+)'/\1/")

        # Print the alias in a clean, formatted way
        printf "  ${green}%-20s${nc} ${blue}%s${nc}\n" "$name" "$value"
    done

    echo -e "${gray}--------------------------------------${nc}"
}
