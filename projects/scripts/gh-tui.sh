#!/usr/bin/env bash

# Check dependencies
check_deps() {
    local missing_deps=()
    for dep in gh fzf; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo "Missing required dependencies: ${missing_deps[*]}"
        echo "Please install them first:"
        echo "gh: 'sudo apt install gh'"
        echo "fzf: 'sudo apt install fzf'"
        exit 1
    fi
}

# Color definitions
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Main menu options
show_menu() {
    local options=(
        "🏠 Repositories"
        "📝 Issues"
        "🔄 Pull Requests"
        "🌟 Starred"
        "📦 Releases"
        "👥 Collaborators"
        "🔍 Search"
        "⚡ Actions"
        "❌ Exit"
    )

    printf "%b%s%b\n" "${BLUE}" "GitHub TUI" "${NC}"
    printf "%b%s%b\n" "${GREEN}" "Select an option:" "${NC}"

    local choice
    choice=$(printf '%s\n' "${options[@]}" | fzf --height=40% --border --prompt="⚡ > ")

    case $choice in
        "🏠 Repositories") repo_menu ;;
        "📝 Issues") issue_menu ;;
        "🔄 Pull Requests") pr_menu ;;
        "🌟 Starred") starred_menu ;;
        "📦 Releases") release_menu ;;
        "👥 Collaborators") collab_menu ;;
        "🔍 Search") search_menu ;;
        "⚡ Actions") actions_menu ;;
        "❌ Exit") exit 0 ;;
        *) show_menu ;;
    esac
}

# Repository management
repo_menu() {
    local options=(
        "📋 List Repositories"
        "📥 Clone Repository"
        "➕ Create Repository"
        "🔍 View Repository"
        "↩️  Back"
    )

    local choice
    choice=$(printf '%s\n' "${options[@]}" | fzf --height=40% --border --prompt="Repository > ")

    case $choice in
        "📋 List Repositories")
            local repo
            repo=$(gh repo list --limit 100 | fzf --height=40% --border --prompt="Select Repository > " | awk '{print $1}')
            if [ -n "$repo" ]; then
                # gh repo view "$repo" --web
                gh repo view "$repo"
            fi
            repo_menu
            ;;
        "📥 Clone Repository")
            local repo
            repo=$(gh repo list --limit 100 | fzf --height=40% --border --prompt="Select Repository to Clone > " | awk '{print $1}')
            if [ -n "$repo" ]; then
                gh repo clone "$repo"
            fi
            repo_menu
            ;;
        "➕ Create Repository")
            echo -n "Repository name: "
            read -r name
            gh repo create "$name"
            repo_menu
            ;;
        "🔍 View Repository")
            local repo
            repo=$(gh repo list --limit 100 | fzf --height=40% --border --prompt="Select Repository > " | awk '{print $1}')
            if [ -n "$repo" ]; then
                gh repo view "$repo"
                read -n 1 -s -r -p "Press any key to continue"
            fi
            repo_menu
            ;;
        "↩️  Back") show_menu ;;
        *) repo_menu ;;
    esac
}

# Issue management
issue_menu() {
    local options=(
        "📋 List Issues"
        "➕ Create Issue"
        "🔍 View Issue"
        "↩️  Back"
    )

    local choice
    choice=$(printf '%s\n' "${options[@]}" | fzf --height=40% --border --prompt="Issues > ")

    case $choice in
        "📋 List Issues")
            gh issue list | fzf --height=40% --border --prompt="Select Issue > "
            read -n 1 -s -r -p "Press any key to continue"
            issue_menu
            ;;
        "➕ Create Issue")
            gh issue create
            issue_menu
            ;;
        "🔍 View Issue")
            local issue
            issue=$(gh issue list | fzf --height=40% --border --prompt="Select Issue > " | awk '{print $1}')
            if [ -n "$issue" ]; then
                gh issue view "$issue"
                read -n 1 -s -r -p "Press any key to continue"
            fi
            issue_menu
            ;;
        "↩️  Back") show_menu ;;
        *) issue_menu ;;
    esac
}

# PR management
pr_menu() {
    local options=(
        "📋 List PRs"
        "➕ Create PR"
        "🔍 View PR"
        "✅ Review PR"
        "↩️  Back"
    )

    local choice
    choice=$(printf '%s\n' "${options[@]}" | fzf --height=40% --border --prompt="Pull Requests > ")

    case $choice in
        "📋 List PRs")
            gh pr list | fzf --height=40% --border --prompt="Select PR > "
            read -n 1 -s -r -p "Press any key to continue"
            pr_menu
            ;;
        "➕ Create PR")
            gh pr create
            pr_menu
            ;;
        "🔍 View PR")
            local pr
            pr=$(gh pr list | fzf --height=40% --border --prompt="Select PR > " | awk '{print $1}')
            if [ -n "$pr" ]; then
                gh pr view "$pr"
                read -n 1 -s -r -p "Press any key to continue"
            fi
            pr_menu
            ;;
        "✅ Review PR")
            local pr
            pr=$(gh pr list | fzf --height=40% --border --prompt="Select PR to Review > " | awk '{print $1}')
            if [ -n "$pr" ]; then
                gh pr review "$pr"
            fi
            pr_menu
            ;;
        "↩️  Back") show_menu ;;
        *) pr_menu ;;
    esac
}

# Starred repos
starred_menu() {
    local options=(
        "📋 List Starred"
        "⭐ Star Repository"
        "↩️  Back"
    )

    local choice
    choice=$(printf '%s\n' "${options[@]}" | fzf --height=40% --border --prompt="Starred > ")

    case $choice in
        "📋 List Starred")
            gh api user/starred --paginate | jq -r '.[].full_name' | fzf --height=40% --border --prompt="Select Starred Repository > "
            read -n 1 -s -r -p "Press any key to continue"
            starred_menu
            ;;
        "⭐ Star Repository")
            echo -n "Repository (owner/name): "
            read -r repo
            gh api --method PUT "user/starred/$repo"
            starred_menu
            ;;
        "↩️  Back") show_menu ;;
        *) starred_menu ;;
    esac
}

# Main execution
check_deps
show_menu
