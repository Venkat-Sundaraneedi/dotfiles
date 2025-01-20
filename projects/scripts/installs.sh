#!/bin/bash

BOLD_YELLOW='\033[1;33m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
GRAY='\033[0;90m'
NC='\033[0m'  # No Color


# List of applications to install
apps=(
    "curl"
    "git"
    "build-essential"
)

# Function to check if an app is installed
is_installed() {
    dpkg -l "$1" &> /dev/null
}

# Function to install an app if not installed
install_app() {


    app=$1
    if is_installed "$app"; then
        echo -e "$app ${GREEN}✅ is already installed.${NC}"
    else
        echo -e "${BLUE}📂 Installing${NC} $app..."
        sudo apt update && sudo apt install -y "$app"
    fi
}

# Main loop to install all apps
for app in "${apps[@]}"; do
    install_app "$app"
done

echo -e "${BLUE}✨ All applications installed or already up-to-date!${NC}"

