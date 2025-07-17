#!/bin/bash
# RAM usage script for tmux status bar

# Get RAM usage percentage
get_ram_usage() {
    # Get memory information from /proc/meminfo
    total=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
    available=$(cat /proc/meminfo | grep MemAvailable | awk '{print $2}')
    
    # Calculate used memory
    used=$((total - available))
    
    # Calculate usage percentage
    usage=$((used * 10/ total))
    
    echo $usage
}

# Get RAM usage in MB
get_ram_mb() {
    # Get memory information
    total=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
    available=$(cat /proc/meminfo | grep MemAvailable | awk '{print $2}')
    
    # Convert to MB
    total_mb=$((total / 1024))
    available_mb=$((available / 1024))
    used_mb=$((total_mb - available_mb))
    
    echo $used_mb/$total_mb"
}

# Get RAM usage in GB
get_ram_gb() {
    # Get memory information
    total=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
    available=$(cat /proc/meminfo | grep MemAvailable | awk '{print $2}')
    
    # Convert to GB
    total_gb=$((total /102424))
    available_gb=$((available /1024 / 1024))
    used_gb=$((total_gb - available_gb))
    
    echo $used_gb/$total_gb"
}

# Get free RAM percentage
get_ram_free() {
    # Get memory information
    total=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
    available=$(cat /proc/meminfo | grep MemAvailable | awk '{print $2}')
    
    # Calculate free percentage
    free_percent=$((available * 10/ total))
    
    echo $free_percent
}

# Format RAM information
format_ram_info() {
    usage=$(get_ram_usage)
    used_total=$(get_ram_mb)
    
    # Get RAM icon based on usage
    if [ $usage -ge 80 ]; then
        icon="💾"
    elif [ $usage -ge 60 ]; then
        icon="💾"
    elif [ $usage -ge 40 ]; then
        icon="💾"
    elif [ $usage -ge 20 ]; then
        icon="💾"
    else
        icon="💾"
    fi
    
    # Format output
    echo "$icon $usage%"
}

# Get RAM usage only
get_ram_percent() {
    get_ram_usage
}

# Get RAM usage in MB only
get_ram_mb_only() {
    get_ram_mb
}

# Get RAM usage in GB only
get_ram_gb_only() {
    get_ram_gb
}

# Get free RAM percentage only
get_ram_free_percent() {
    get_ram_free
}

# Main function
main() {
    case "$1" in
        percent)
            get_ram_percent
            ;;
        mb)
            get_ram_mb_only
            ;;
        gb)
            get_ram_gb_only
            ;;
        free)
            get_ram_free_percent
            ;;
        *)
            format_ram_info
            ;;
    esac
}

# Run main function
main "$@" 