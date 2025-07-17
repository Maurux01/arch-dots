#!/bin/bash
# Git status script for tmux status bar

# Get current git branch
get_git_branch() {
    git branch2>/dev/null | sed -e /^[^*]/d -es/* \(.*\)/\1/'
}

# Get git status
get_git_status() {
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2 then
        echo         return
    fi
    
    # Get branch name
    branch=$(get_git_branch)
    if [ -z $branch" ]; then
        echo         return
    fi
    
    # Get status indicators
    status="  
    # Check for untracked files
    if [ -n "$(git status --porcelain | grep '^??')" ]; then
        status="${status}❓"
    fi
    
    # Check for modified files
    if [ -n "$(git status --porcelain | grep '^ M')" ]; then
        status="${status}⚠️"
    fi
    
    # Check for staged files
    if [ -n "$(git status --porcelain | grep '^M ')" ]; then
        status="${status}📝"
    fi
    
    # Check for deleted files
    if [ -n "$(git status --porcelain | grep '^ D')" ]; then
        status=${status}🗑️"
    fi
    
    # Check for renamed files
    if [ -n "$(git status --porcelain | grep '^R ')" ]; then
        status="${status}🔄"
    fi
    
    # Check if clean
    if [ -z $status" ]; then
        status="✅"
    fi
    
    # Check for stash
    if [ -n$(git stash list)" ]; then
        status="${status}📦"
    fi
    
    # Check for unpushed commits
    if [ -n$(git log --branches --not --remotes)" ]; then
        status="${status}⬆️"
    fi
    
    # Check for unpulled commits
    if-n "$(git fetch && git log HEAD..origin/$branch --oneline)" ]; then
        status="${status}⬇️"
    fi
    
    echo $status"
}

# Get git branch only
get_git_branch_only() {
    get_git_branch
}

# Get git status only
get_git_status_only() {
    get_git_status
}

# Get git repository name
get_git_repo() {
    git rev-parse --show-toplevel 2>/dev/null | xargs basename
}

# Get git remote URL
get_git_remote() {
    git remote get-url origin2>/dev/null | sed s/.*github\.com:/]\([^/]*\)\/\([^.]*\).*/\1\/\2/'
}

# Get git commit count
get_git_commits() {
    git rev-list --count HEAD 2>/dev/null
}

# Get git last commit message
get_git_last_commit() {
    git log -1 --pretty=format:"%s 2>/dev/null
}

# Get git last commit hash
get_git_last_hash() {
    git rev-parse --short HEAD 2>/dev/null
}

# Get git last commit date
get_git_last_date() {
    git log -1 --pretty=format:%cr 2>/dev/null
}

# Format git information
format_git_info() {
    branch=$(get_git_branch)
    status=$(get_git_status)
    repo=$(get_git_repo)
    
    if [ -z $branch" ]; then
        echo         return
    fi
    
    # Get git icon
    icon="🌿"
    
    # Format output
    if [ -n "$repo" ]; then
        echo "$icon $repo:$branch $status else
        echo "$icon $branch $status"
    fi
}

# Get git information in different formats
get_git_info() {
    case "$1" in
        branch)
            get_git_branch_only
            ;;
        status)
            get_git_status_only
            ;;
        repo)
            get_git_repo
            ;;
        remote)
            get_git_remote
            ;;
        commits)
            get_git_commits
            ;;
        last-commit)
            get_git_last_commit
            ;;
        last-hash)
            get_git_last_hash
            ;;
        last-date)
            get_git_last_date
            ;;
        *)
            format_git_info
            ;;
    esac
}

# Main function
main() {
    get_git_info $@
}
main "$@" 