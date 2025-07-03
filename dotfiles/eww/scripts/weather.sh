#!/bin/bash
# Ejemplo simple usando wttr.in
WEATHER_RAW=$(curl -s 'wttr.in/?format=%c+%t+%C')
WEATHER_ICON=$(echo $WEATHER_RAW | awk '{print $1}')
WEATHER_TEMP=$(echo $WEATHER_RAW | awk '{print $2}')
WEATHER_DESC=$(echo $WEATHER_RAW | cut -d' ' -f3-)
export WEATHER_ICON
export WEATHER_TEMP
export WEATHER_DESC
echo $WEATHER_ICON $WEATHER_TEMP $WEATHER_DESC 