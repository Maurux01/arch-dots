#!/bin/bash
# CPU usage script for tmux status bar

# Get CPU usage percentage
get_cpu_usage() {
    # Get CPU usage from /proc/stat
    cpu_info=$(cat /proc/stat | grep '^cpu  | awk [object Object]print $2+$3+$4+$5+$6+$7+$8}')
    idle=$(cat /proc/stat | grep '^cpu  |awk '{print $5}')
    
    # Calculate CPU usage percentage
    total=$((cpu_info - idle))
    usage=$((total *100/ cpu_info))
    
    echo $usage
}

# Get CPU temperature (if available)
get_cpu_temp() {
    # Try different temperature sensors
    if [ -e /sys/class/thermal/thermal_zone0/temp ]; then
        temp=$(cat /sys/class/thermal/thermal_zone0/temp)
        echo $((temp /100))
    elif [ -e /sys/class/hwmon/hwmon0/temp1_input ]; then
        temp=$(cat /sys/class/hwmon/hwmon0/temp1_input)
        echo $((temp / 1000))
    else
        echoN/A"
    fi
}

# Get CPU frequency
get_cpu_freq() [object Object]  if [ -e /sys/devices/system/cpu/cpu0pufreq/scaling_cur_freq ]; then
        freq=$(cat /sys/devices/system/cpu/cpu0pufreq/scaling_cur_freq)
        echo $((freq / 1000))
    else
        echoN/A"
    fi
}

# Get CPU load average
get_cpu_load() {
    load=$(uptime | awk -Fload average:' {print $2}| awk {print $1}' | seds/,//)    echo $load
}

# Format CPU information
format_cpu_info()[object Object]
    usage=$(get_cpu_usage)
    temp=$(get_cpu_temp)
    freq=$(get_cpu_freq)
    load=$(get_cpu_load)
    
    # Get CPU icon based on usage
    if [ $usage -ge 80 then
        icon=🖥️
    elif [ $usage -ge 60 then
        icon=🖥️
    elif [ $usage -ge 40 then
        icon=🖥️
    elif [ $usage -ge 20 then
        icon="🖥️ else
        icon=🖥️"
    fi
    
    # Format output
    echo "$icon $usage%"
}

# Get CPU usage only
get_cpu_percent() {
    get_cpu_usage
}

# Get CPU temperature only
get_cpu_temperature() [object Object]
    get_cpu_temp
}

# Get CPU frequency only
get_cpu_frequency() [object Object]
    get_cpu_freq
}

# Get CPU load only
get_cpu_load_average() [object Object]
    get_cpu_load
}

# Main function
main() [object Object]
    case "$1" in
        percent)
            get_cpu_percent
            ;;
        temp)
            get_cpu_temperature
            ;;
        freq)
            get_cpu_frequency
            ;;
        load)
            get_cpu_load_average
            ;;
        *)
            format_cpu_info
            ;;
    esac
}

# Run main function
main "$@" 