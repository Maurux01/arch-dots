#!/bin/bash

# Configuración del clima
CITY="${WEATHER_CITY:-"Madrid"}"  # Ciudad por defecto
API_KEY="${WEATHER_API_KEY:-""}"  # API key de OpenWeatherMap (opcional)

# Función para obtener clima con wttr.in (fallback)
get_weather_wttr() {
  local city="$1"
  WEATHER_RAW=$(curl -s --max-time 5 "wttr.in/$city?format=%c+%t+%C" 2>/dev/null)
  
  if [[ -n "$WEATHER_RAW" && "$WEATHER_RAW" != *"Unknown location"* ]]; then
    WEATHER_ICON=$(echo $WEATHER_RAW | awk '{print $1}')
    WEATHER_TEMP=$(echo $WEATHER_RAW | awk '{print $2}')
    WEATHER_DESC=$(echo $WEATHER_RAW | cut -d' ' -f3-)
    echo "✓ $WEATHER_ICON $WEATHER_TEMP $WEATHER_DESC"
  else
    echo "⚠ Clima no disponible"
  fi
}

# Función para obtener clima con OpenWeatherMap (si hay API key)
get_weather_openweather() {
  local city="$1"
  local api_key="$2"
  
  if [[ -n "$api_key" ]]; then
    local url="http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api_key&units=metric"
    local response=$(curl -s --max-time 5 "$url" 2>/dev/null)
    
    if [[ -n "$response" && "$response" != *"404"* ]]; then
      local temp=$(echo "$response" | jq -r '.main.temp // "N/A"' 2>/dev/null)
      local desc=$(echo "$response" | jq -r '.weather[0].description // "N/A"' 2>/dev/null)
      local icon=$(echo "$response" | jq -r '.weather[0].icon // "N/A"' 2>/dev/null)
      
      if [[ "$temp" != "N/A" ]]; then
        echo "🌤️ ${temp}°C $desc"
        return 0
      fi
    fi
  fi
  
  return 1
}

# Intentar obtener clima con OpenWeatherMap primero
if get_weather_openweather "$CITY" "$API_KEY"; then
  # Éxito con OpenWeatherMap
  :
else
  # Fallback a wttr.in
  get_weather_wttr "$CITY"
fi

# Exportar variables para eww
export WEATHER_ICON
export WEATHER_TEMP
export WEATHER_DESC 