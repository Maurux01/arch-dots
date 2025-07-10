#!/bin/bash

# Weather script for Waybar
# Shows current weather information

# Configuration
CITY="Madrid"  # Change to your city
API_KEY=""     # Add your OpenWeatherMap API key if you have one

# Function to get weather data
get_weather() {
    if [ -n "$API_KEY" ]; then
        # Using OpenWeatherMap API (requires API key)
        weather_data=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$CITY&appid=$API_KEY&units=metric")
        temp=$(echo $weather_data | jq -r '.main.temp')
        condition=$(echo $weather_data | jq -r '.weather[0].main')
        
        # Convert condition to emoji
        case $condition in
            "Clear") icon="☀️" ;;
            "Clouds") icon="☁️" ;;
            "Rain") icon="🌧️" ;;
            "Snow") icon="❄️" ;;
            "Thunderstorm") icon="⛈️" ;;
            "Drizzle") icon="🌦️" ;;
            "Mist"|"Fog") icon="🌫️" ;;
            *) icon="🌤️" ;;
        esac
        
        echo "$icon ${temp}°C"
    else
        # Fallback using wttr.in (no API key required)
        weather=$(curl -s "wttr.in/$CITY?format=%C+%t" 2>/dev/null)
        if [ $? -eq 0 ] && [ -n "$weather" ]; then
            echo "$weather"
        else
            echo "🌤️ --°C"
        fi
    fi
}

# Function to get weather tooltip
get_weather_tooltip() {
    if [ -n "$API_KEY" ]; then
        weather_data=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$CITY&appid=$API_KEY&units=metric")
        temp=$(echo $weather_data | jq -r '.main.temp')
        feels_like=$(echo $weather_data | jq -r '.main.feels_like')
        humidity=$(echo $weather_data | jq -r '.main.humidity')
        wind_speed=$(echo $weather_data | jq -r '.wind.speed')
        description=$(echo $weather_data | jq -r '.weather[0].description')
        
        echo "🌡️ Temperature: ${temp}°C\n🌡️ Feels like: ${feels_like}°C\n💧 Humidity: ${humidity}%\n💨 Wind: ${wind_speed} m/s\n📝 ${description}"
    else
        echo "🌤️ Weather in $CITY\nClick to open weather app"
    fi
}

# Main execution
case "$1" in
    "tooltip")
        get_weather_tooltip
        ;;
    *)
        get_weather
        ;;
esac 