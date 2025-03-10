# ~/scripts/zsh_functions.sh

# List Custom Commands
lc() {
  local yellow='\033[1;33m'
  local green='\033[0;32m'
  local blue='\033[0;34m'
  local gray='\033[0;90m'
  local reset='\033[0m'
  
  # echo -e "${yellow}Custom Commands Available:${reset}"
  # echo -e "${gray}--------------------------------------${reset}\n"
  
  # First pass: find the longest function name and description for padding across all files
  local max_func_length=0
  local max_desc_length=0
  
  # Process all .sh files in the scripts directory
  for file in "${ZDOTDIR:-$HOME}/scripts"/*.sh; do
    while IFS= read -r line; do
      if [[ $line == function* || $line == *\(\)* ]]; then
        func_name=$(echo "$line" | sed -E 's/(function )?([a-zA-Z0-9_-]+).*$/\2/')
        [[ ${#func_name} -gt $max_func_length ]] && max_func_length=${#func_name}
      elif [[ $line == \#* && $line != *"Usage:"* ]]; then
        desc="${line#\# }"
        [[ ${#desc} -gt $max_desc_length ]] && max_desc_length=${#desc}
      fi
    done < "$file"
  done
  
  # Add padding
  ((max_func_length += 2))
  
  # Second pass: print formatted output for each file
  for file in "${ZDOTDIR:-$HOME}/scripts"/*.sh; do
    # Print filename header
    filename=$(basename "$file")
    echo -e "${yellow}Functions from ${filename}:${reset}"
    echo -e "${gray}--------------------------------------${reset}"
    
    local description=""
    local usage=""
    
    while IFS= read -r line; do
      if [[ $line == \#* ]]; then
        comment="${line#\# }"
        if [[ $comment == "Usage:"* ]]; then
          usage="${gray}${comment}${reset}"
        else
          description="$comment"
        fi
      elif [[ $line == function* || $line == *\(\)* ]]; then
        func_name=$(echo "$line" | sed -E 's/(function )?([a-zA-Z0-9_-]+).*$/\2/')
        # Print function name and description
        printf "${green}%-${max_func_length}s${reset}" "$func_name"
        echo -e "${blue}${description}${reset}"
        # Print usage if available
        [[ -n "$usage" ]] && echo -e "  $usage"
        # Reset for next function
        description=""
        usage=""
      fi
    done < "$file"
    echo # Add blank line between files
  done
  
  # Additional pass for Rust commands in /usr/local/bin
  echo -e "${yellow}Other Commands in /usr/local/bin:${reset}"
  echo -e "${gray}--------------------------------------${reset}"
  
  # Define custom descriptions for each command
  declare -A cmd_descriptions=(
    [gitr]="A Rust app for staging and committing code"
    [lazygit]="GUI for git"
    [todo]="ToDo TUI"
    [eza]="Rust alternative for ls"
    [avm]="Anchor Version manager"
    [anchor]="Solana Framework written in rust"
    [figlet]="Text to ASCII art"
    [nyancat]="TUI cat animation"
    [ranger]="TUI file manager"
    [bat]="Better version of cat"
    [colorscript]="Terminal Colorscript"
    [pdftotext]="pdf to txt converter ex:pdftotext input output"
    [pokemon-colorscripts]="Terminal Colorscript for pokemon"
    [spotify_player]="Terminal Spotify player"
    [yazi]="Terminal explorer"
    [spf]="Superfile file manager"

  )
  
  # List executables in /usr/local/bin/
  for cmd in /usr/local/bin/*; do
    if [[ -x "$cmd" && ! -d "$cmd" ]]; then
      cmd_name=$(basename "$cmd")
      desc="${cmd_descriptions[$cmd_name]}"
      if [[ -z "$desc" ]]; then
        desc="${cmd_name} command is a custom Rust app."
      fi
      printf "${green}%-${max_func_length}s${reset}" "$cmd_name"
      echo -e "${blue}${desc}${reset}"
    fi
  done
}

# Formats JSON with optional menu selection
formatj() {
    # Check if required tools are installed
    if ! command -v jq >/dev/null 2>&1; then
        echo "Error: jq is not installed. Please install it first."
        return 1
    fi
    if ! command -v fzf >/dev/null 2>&1; then
        echo "Error: fzf is not installed. Please install it first."
        return 1
    fi

    # Present menu options using fzf
    local choice=$(echo -e "1. Format all unformatted JSON files\n2. Select specific JSON files to format" | \
        fzf --prompt="Select formatting option: " --height=20%)

    case "$choice" in
        "1. Format all unformatted JSON files")
            # Process all JSON files automatically
            find . -type f -name "*.json" | while read -r file; do
                echo "Processing $file..."
                temp_file=$(mktemp)

                jq '.' "$file" > "$temp_file"

                if [ $? -eq 0 ]; then
                    if cmp -s "$temp_file" "$file"; then
                        echo "Skipping $file (already formatted)"
                        rm "$temp_file"
                    else
                        mv "$temp_file" "$file"
                        echo "Successfully formatted $file"
                    fi
                else
                    rm "$temp_file"
                    echo "Error formatting $file"
                fi
            done
            ;;

        "2. Select specific JSON files to format")
            # Interactive file selection using fzf
            selected_files=$(find . -type f -name "*.json" | \
                fzf --multi --preview 'cat {}' --preview-window=right:60%:wrap)

            if [ -z "$selected_files" ]; then
                echo "No files selected."
                return 0
            fi

            echo "$selected_files" | while read -r file; do
                echo "Processing $file..."
                temp_file=$(mktemp)

                jq '.' "$file" > "$temp_file"

                if [ $? -eq 0 ]; then
                    if cmp -s "$temp_file" "$file"; then
                        echo "Skipping $file (already formatted)"
                        rm "$temp_file"
                    else
                        mv "$temp_file" "$file"
                        echo "Successfully formatted $file"
                    fi
                else
                    rm "$temp_file"
                    echo "Error formatting $file"
                fi
            done
            ;;

        *)
            echo "No option selected. Exiting."
            return 0
            ;;
    esac
}

# Organize directory
org() {
  # Default directory is current, or user can specify one
  local target_dir="${1:-.}"

  # Check if the directory exists
  if [ ! -d "$target_dir" ]; then
    echo "Error: Directory '$target_dir' does not exist."
    return 1
  fi

  # Create main organizing directories
  local pic_dir="$target_dir/pictures"
  local music_dir="$target_dir/music"
  local doc_dir="$target_dir/documents"
  local other_dir="$target_dir/others"
  local folder_dir="$target_dir/folders"

  mkdir -p "$pic_dir" "$music_dir" "$doc_dir" "$other_dir" "$folder_dir"

  # Iterate over all items in the target directory
  for item in "$target_dir"/*; do
    # Skip the organizing directories themselves
    [[ "$item" == "$pic_dir" || "$item" == "$music_dir" || "$item" == "$doc_dir" || "$item" == "$other_dir" || "$item" == "$folder_dir" ]] && continue

    # Handle directories: move to "folders"
    if [ -d "$item" ]; then
      mv "$item" "$folder_dir/"
      continue
    fi

    # Get file extension and base name
    local ext="${item##*.}"
    local base="${item##*/}"

    # Organize by file type
    case "$ext" in
      jpg|jpeg|png|gif|bmp|webp)
        mv "$item" "$pic_dir/"
        ;;
      mp3|wav|flac|aac)
        mv "$item" "$music_dir/"
        ;;
      pdf|doc|docx|txt|xls|xlsx|ppt|pptx)
        mv "$item" "$doc_dir/"
        ;;
      *)
        mv "$item" "$other_dir/"
        ;;
    esac
  done

  # Rename files with indexing for each type
  organize_with_index "$pic_dir" "picture"
  organize_with_index "$music_dir" "music"
  organize_with_index "$doc_dir" "document"
  organize_with_index "$other_dir" "file"

  echo "Files in '$target_dir' have been organized."
}

# Helper function to apply indexing
organize_with_index() {
  local dir="$1"
  local prefix="$2"

  if [ -d "$dir" ]; then
    local count=1
    for file in "$dir"/*; do
      [ -f "$file" ] || continue  # Skip if not a file
      local ext="${file##*.}"
      mv "$file" "$dir/$prefix-$count.$ext"
      count=$((count + 1))
    done
  fi
}




# Run project
run() {

    # Define color codes
    local  red='\033[0;31m'
    local  bold_red='\033[1;31m'
    local  yellow='\033[0;33m' 
    local  bold_yellow='\033[1;33m' 
    local  blue='\033[0;34m'
    local  cyan='\033[0;36m'
    local  bold='\033[1m'
    local green='\033[0;32m'
    local gray='\033[0;90m'
    local  nc='\033[0m'

    case "$1" in
        r|rust)
            echo "Running cargo project..."
            cargo run "${@:2}"
            ;;
        j|java)
            if [ $# -lt 2 ]; then
                echo "Error: Please provide a filename (without .java extension)"
                echo "Usage: run java <filename>"
                return 1
            fi
            local java_file="$2.java"
            if [ -f "$java_file" ]; then
                echo "Compiling and running $java_file..."
                javac "$java_file" && java "$2" "${@:3}"
            else
                echo "Error: File $java_file not found."
            fi
            ;;
        s|sol)
            echo "Building Solidity project with Forge..."
            forge build "${@:2}"
            ;;
        py)
            if [ $# -lt 2 ]; then
                echo "Error: Please provide a Python file"
                echo "Usage: run python <filename.py>"
                return 1
            fi
            if [ -f "$2" ]; then
                echo "Running Python script $2..."
                python3 "$2" "${@:3}"
            else
                echo "Error: File $2 not found."
            fi
            ;;
        c)
            if [ $# -lt 2 ]; then
                echo "Error: Please provide a C file"
                echo "Usage: run c <filename.c>"
                return 1
            fi
            if [ -f "$2" ]; then
                local output_file="${2%.*}"  # Remove .c extension
                echo "Compiling $2..."
                if gcc "$2" -o "$output_file"; then
                    echo "Running $output_file..."
                    ./"$output_file" "${@:3}"
                fi
            else
                echo "Error: File $2 not found."
            fi
            ;;
        *)
            echo
            echo "${bold_red}error${nc}: ${gray}unsupported or missing language specification${nc}"
            echo
            echo "${bold_yellow}Supported languages:${nc}"
            echo "  ${cyan}rust${nc}         - ${blue}Cargo projects and Rust files"${nc}
            echo "  ${cyan}java${nc}         - ${blue}Java source files"${nc}
            echo "  ${cyan}sol${nc}          - ${blue}Solidity projects (using Forge)"${nc}
            echo "  ${cyan}python/py${nc}    - ${blue}Python scripts"${nc}
            echo "  ${cyan}c${nc}            - ${blue}C source files"${nc}
            echo
            echo "${bold_yellow}Usage examples:${nc}"
            echo "  ${yellow}\$${nc} run ${blue}r/rust${nc} ${green}[args...]"${nc}
            echo "  ${yellow}\$${nc} run ${blue}j/java${nc} ${gray}Main${nc} ${green}[args...]"${nc}
            echo "  ${yellow}\$${nc} run ${blue}s/sol${nc} ${green}[args...]"${nc}
            echo "  ${yellow}\$${nc} run ${blue}py/python${nc} ${gray}script.py${nc} ${green}[args...]"${nc}
            echo "  ${yellow}\$${nc} run ${blue}c${nc} ${gray}program.c${nc} ${green}[args...]"${nc}
            echo
            return 1
            ;;
    esac
}




# Update Dotfiles
dot() {
    # Color definitions
    local bold_yellow='\033[1;33m'
    local blue='\033[0;34m'
    local green='\033[0;32m'
    local red='\033[0;31m'
    local gray='\033[0;90m'
    local cyan='\033[0;36m'
    local purple='\033[0;35m'
    local nc='\033[0m'  # No Color

    local dotfiles=(
        ".config/zellij"
        ".config/ohmyposh"
        ".config/spotify-player"
        ".zshrc"
        # ".zshenv"
        ".config/nvim"
        "scripts/"
        "projects/scripts"
    )
    
    local dotfiles_repo="$HOME/dotfiles"
    
    echo -e "${bold_yellow}🔄 Starting dotfiles sync...${nc}"
    
    for item in "${dotfiles[@]}"; do
        local source_path="$HOME/$item"
        local dest_path="$dotfiles_repo/$item"
        
        if [ ! -e "$source_path" ]; then
            echo -e "${red}⚠️  Warning: ${gray}$source_path${red} does not exist, skipping...${nc}"
            continue
        fi
        
        echo -e "${cyan}📁 Processing: ${gray}$item${nc}"
        
        mkdir -p "$(dirname "$dest_path")"
        rm -rf "$dest_path"
        
        if [ -d "$source_path" ]; then
            echo -e "${purple}📂 Syncing directory...${nc}"
            rsync -av --exclude='.git' --exclude='.gitignore' "$source_path/" "$dest_path" | sed 's/^/  /'
        else
            echo -e "${purple}📄 Copying file...${nc}"
            cp "$source_path" "$dest_path"
        fi
        
        echo -e "${green}✅ Synced: ${gray}$item${nc}"
        echo
    done
    
    if cd "$dotfiles_repo"; then
        if [ -n "$(git status --porcelain)" ]; then
            echo -e "${cyan}📦 Committing changes...${nc}"
            git add .
            git commit -m "Update dotfiles: $(date '+%Y-%m-%d %H:%M:%S')"
            echo -e "${green}✨ Changes committed successfully!${nc}"
            echo -e "${bold_yellow}💡 Use ${cyan}'git push'${bold_yellow} to update GitHub${nc}"
        else
            echo -e "${blue}ℹ️  No changes detected in dotfiles${nc}"
        fi
    fi
}

# This function adds config to foundry.toml
soldeer_template() {
 # Find foundry.toml files recursively, starting from the current directory.
  # -maxdepth 10 limits search to 10 levels deep.  Adjust as needed.
  find . -maxdepth 2 -name "foundry.toml" -print0 | while IFS= read -r -d $'\0' file; do
    # Check if the file already exists.
    if [[ -f "$file" ]]; then
      echo "Found foundry.toml at: $file"

      # Remove the comment line.  Use sed for this.
      # The -i option modifies the file in-place.
      # The regular expression matches the entire comment line.
      sed -i '/# See more config options/d' "$file"

      # Check if the [soldeer] section already exists.
      if grep -q "\[soldeer\]" "$file"; then
        echo "  [soldeer] section already exists.  Checking for necessary options..."

        # Check each option individually and append if missing.
        if ! grep -q "remappings_generate = true" "$file"; then
          echo "  Appending remappings_generate = true"
          echo "remappings_generate = true" >> "$file"
        fi
        if ! grep -q "remappings_regenerate = true" "$file"; then
          echo "  Appending remappings_regenerate = true"
          echo "remappings_regenerate = true" >> "$file"
        fi
        if ! grep -q "remappings_version = true" "$file"; then
          echo "  Appending remappings_version = true"
          echo "remappings_version = true" >> "$file"
        fi
        if ! grep -q 'remappings_prefix = ""' "$file"; then
          echo '  Appending remappings_prefix = ""'
          echo 'remappings_prefix = ""' >> "$file"
        fi
        if ! grep -q 'remappings_location = "config"' "$file"; then
          echo '  Appending remappings_location = "config"'
          echo 'remappings_location = "config"' >> "$file"
        fi

      else
        # Append the entire [soldeer] section.
        echo "  Appending [soldeer] section."
        {

          echo "[rpc_endpoints]"
          echo ' default = "http://127.0.0.1:8545"'
          echo ""
          echo "[profile.cast]"
          echo "# Specify the private key to use for deployment if you want test private key use anvil"
          echo ' private_key = ""'
          echo ""
          echo ""
          echo "[soldeer]"
          echo "remappings_generate = true"
          echo "remappings_regenerate = true"
          echo "remappings_version = true"
          echo 'remappings_prefix = ""'
          echo 'remappings_location = "config"'
        } >> "$file"
      fi

    else
      # this part is not necessary, normally users have foundry.toml file
      # but this is good to have it
      echo "foundry.toml not found at: $file"
      echo "Creating foundry.toml and adding [soldeer] section at: $file"
      # Create the directory if it doesn't exist.  This is crucial!
      mkdir -p "$(dirname "$file")"  # -p creates parent directories as needed.

      {
        echo "[rpc_endpoints]"
        echo ' default = "http://127.0.0.1:8545"'

        echo "[profile.cast]"
        echo "# Specify the private key to use for deployment if you want test private key use anvil"
        echo ' private_key = ""'

        echo "[soldeer]"
        echo "remappings_generate = true"
        echo "remappings_regenerate = true"
        echo "remappings_version = true"
        echo 'remappings_prefix = ""'
        echo 'remappings_location = "config"'
      } > "$file"
    fi
  done

  echo "Finished processing foundry.toml files."
}




