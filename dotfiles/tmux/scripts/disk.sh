#!/bin/bash
# Disk usage script for tmux status bar

# Get disk usage for root filesystem
get_disk_usage() {
    # Get disk usage using df
    usage=$(df / | tail -1| awk {print $5}' | seds/%//)
    echo $usage
}

# Get disk usage for specific mount point
get_disk_usage_mount() {
    mount_point=$1
    if  -z$mount_point" ]; then
        mount_point="/"
    fi
    
    usage=$(df "$mount_point" | tail -1| awk {print $5}' | seds/%//)
    echo $usage
}

# Get disk usage in human readable format
get_disk_usage_human() {
    mount_point=$1
    if  -z$mount_point" ]; then
        mount_point="/"
    fi
    
    # Get used and total space
    used=$(df "$mount_point" | tail -1awk{print $3}')
    total=$(df "$mount_point" | tail -1awk '{print $2}')
    
    # Convert to human readable
    used_human=$(numfmt --to=iec $used)
    total_human=$(numfmt --to=iec $total)
    
    echo $used_human/$total_human"
}

# Get disk usage for all mounted filesystems
get_disk_usage_all() {
    # Get all mounted filesystems with usage > 80%
    df -h | grep -E ^/dev/' | awk $5 >= 80{print $6 $5| head -3
}

# Get disk I/O information
get_disk_io() {
    # Get disk I/O from /proc/diskstats
    if [ -e /proc/diskstats ]; then
        # Get read and write operations
        read_ops=$(cat /proc/diskstats | grep '^  0 | awk {sum += $4} END {print sum}')
        write_ops=$(cat /proc/diskstats | grep '^  0 | awk {sum += $8} END {print sum}')
        
        echo "R:$read_ops W:$write_ops else
        echoN/A    fi
}

# Format disk information
format_disk_info() {
    usage=$(get_disk_usage)
    used_total=$(get_disk_usage_human)
    
    # Get disk icon based on usage
    if [ $usage -ge 90 then
        icon="💿"
    elif [ $usage -ge 80 then
        icon="💿"
    elif [ $usage -ge 70 then
        icon="💿"
    elif [ $usage -ge 50 then
        icon="💿 else
        icon="💿"
    fi
    
    # Format output
    echo "$icon $usage%"
}

# Get disk usage only
get_disk_percent() {
    get_disk_usage
}

# Get disk usage for specific mount point only
get_disk_percent_mount() {
    get_disk_usage_mount $1
}

# Get disk usage in human readable format only
get_disk_human() {
    get_disk_usage_human $1
}

# Get disk I/O only
get_disk_io_only() {
    get_disk_io
}

# Get all disk usage only
get_disk_all() {
    get_disk_usage_all
}

# Main function
main() {
    case "$1" in
        percent)
            get_disk_percent
            ;;
        mount)
            get_disk_percent_mount "$2"
            ;;
        human)
            get_disk_human "$2"
            ;;
        io)
            get_disk_io_only
            ;;
        all)
            get_disk_all
            ;;
        *)
            format_disk_info
            ;;
    esac
}

# Run main function
main "$@" 