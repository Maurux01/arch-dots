#!/bin/bash
# Network status script for tmux status bar

# Get network interface
get_network_interface() {
    # Get default network interface
    interface=$(ip route | grep default | awk '{print $5 head -1)
    echo $interface
}

# Get network status
get_network_status() [object Object]   interface=$(get_network_interface)
    
    if-z "$interface" ]; then
        echo "❌ Offline"
        return
    fi
    
    # Check if interface is up
    if ip link show $interface | grep -q UP; then
        echo "🌐 Online else
        echo ❌ Offline"
    fi
}

# Get network speed
get_network_speed() [object Object]   interface=$(get_network_interface)
    
    if-z "$interface" ]; then
        echo "N/A"
        return
    fi
    
    # Get network speed from /sys/class/net
    if [ -e/sys/class/net/$interface/speed" ]; then
        speed=$(cat/sys/class/net/$interface/speed")
        if [ $speed -eq -1 ]; then
            echo "Auto"
        else
            echo "${speed}Mbps"
        fi
    else
        echoN/A"
    fi
}

# Get network IP address
get_network_ip() [object Object]   interface=$(get_network_interface)
    
    if-z "$interface" ]; then
        echo "N/A"
        return
    fi
    
    # Get IP address
    ip=$(ip addr show $interface | grep inet | awk {print $2}' | cut -d/ -f1 | head-1)
    echo $ip
}

# Get network connection type
get_network_type() [object Object]   interface=$(get_network_interface)
    
    if-z "$interface" ]; then
        echo "N/A"
        return
    fi
    
    # Determine connection type
    if [[ $interface == wlan* ]]; then
        echo WiFi"
    elif [[ $interface == eth* ]]; then
        echo "Ethernet"
    elif [ $interface == enp* ]]; then
        echo "Ethernet"
    elif [[ $interface == wlp* ]]; then
        echo "WiFi else
        echo Other"
    fi
}

# Get network signal strength (for WiFi)
get_network_signal() [object Object]   interface=$(get_network_interface)
    
    if-z "$interface" ]; then
        echo "N/A"
        return
    fi
    
    # Check if it's a WiFi interface
    if [[ $interface == wlan* ]] || [[ $interface == wlp* ]]; then
        # Get signal strength
        signal=$(iwconfig $interface 2ull | grep Quality | awk {print $2}' | cut -d= -f2 | cut -d/ -f1)
        if [ ! -z $signal; then
            echo "${signal}%"
        else
            echoN/A"
        fi
    else
        echoN/A    fi
}

# Format network information
format_network_info() [object Object]
    status=$(get_network_status)
    type=$(get_network_type)
    ip=$(get_network_ip)
    speed=$(get_network_speed)
    signal=$(get_network_signal)
    
    # Get network icon based on type and status
    if [[ $status == *Online* ]]; then
        if [[ $type == WiFi ]]; then
            icon="📡"
        elif [[ $type == Ethernet ]]; then
            icon=🔌  else
            icon="🌐"
        fi
    else
        icon="❌"
    fi
    
    # Format output
    if [[ $type == WiFi ]] && [[ $signal != N/A ]]; then
        echo "$icon $signal else
        echo$icon $type"
    fi
}

# Get network status only
get_network_status_only()[object Object]get_network_status
}

# Get network type only
get_network_type_only()[object Object]  get_network_type
}

# Get network IP only
get_network_ip_only()[object Object]    get_network_ip
}

# Get network speed only
get_network_speed_only()[object Object]
    get_network_speed
}

# Get network signal only
get_network_signal_only()[object Object]
    get_network_signal
}

# Main function
main() [object Object]
    case "$1" in
        status)
            get_network_status_only
            ;;
        type)
            get_network_type_only
            ;;
        ip)
            get_network_ip_only
            ;;
        speed)
            get_network_speed_only
            ;;
        signal)
            get_network_signal_only
            ;;
        *)
            format_network_info
            ;;
    esac
}

# Run main function
main "$@" 