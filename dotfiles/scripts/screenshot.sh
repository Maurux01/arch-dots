#!/bin/bash

# Enhanced Screenshot Script for Hyprland
# Soporta múltiples modos de captura, notificaciones y conversión a JPEG

set -e

# Configuración
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
TEMP_DIR="/tmp"
DATE_FORMAT="%Y%m%d_%H%M%S"
MAX_RETRIES=3

# Crear carpeta si no existe
mkdir -p "$SCREENSHOT_DIR"

# Función para notificaciones
send_notification() {
    local urgency="$1"
    local title="$2"
    local message="$3"
    local icon="$4"
    if command -v notify-send &>/dev/null; then
        notify-send --urgency="$urgency" --app-name="screenshot" --icon="$icon" "$title" "$message"
    fi
}

# Herramienta de captura
echo "[DEBUG] Buscando herramienta de captura..." >&2
get_screenshot_tool() {
    if command -v wl-screenshot &> /dev/null; then
        echo "wl-screenshot"
    elif command -v grim &> /dev/null; then
        echo "grim"
    else
        echo ""
    fi
}

# Herramienta de portapapeles
echo "[DEBUG] Buscando herramienta de portapapeles..." >&2
get_clipboard_tool() {
    if command -v wl-copy &> /dev/null; then
        echo "wl-copy"
    elif command -v xclip &> /dev/null; then
        echo "xclip"
    else
        echo ""
    fi
}

# Copiar al portapapeles
copy_to_clipboard() {
    local file="$1"
    local clipboard_tool="$2"
    if [ "$clipboard_tool" = "wl-copy" ]; then
        wl-copy < "$file"
    elif [ "$clipboard_tool" = "xclip" ]; then
        xclip -selection clipboard -t image/png < "$file"
    fi
}

# Convertir a JPEG
convert_to_jpeg() {
    local input_file="$1"
    local output_file="$2"
    if command -v convert &> /dev/null; then
        convert "$input_file" "$output_file" && rm "$input_file"
        echo "✅ Captura guardada en $output_file"
    elif command -v ffmpeg &> /dev/null; then
        ffmpeg -y -i "$input_file" "$output_file" && rm "$input_file"
        echo "✅ Captura guardada en $output_file"
    else
        echo "⚠️  No se encontró imagemagick ni ffmpeg. Captura guardada como PNG en $input_file"
    fi
}

# Mostrar ayuda
show_help() {
    echo "Enhanced Screenshot Script for Hyprland"
    echo ""
    echo "Uso: $0 [modo] [--jpeg|-j]"
    echo ""
    echo "Modos disponibles:"
    echo "  s, select        - Captura área seleccionada"
    echo "  m, monitor       - Captura monitor actual"
    echo "  p, all           - Captura todos los monitores"
    echo "  w, window        - Captura ventana activa"
    echo "  c, clipboard     - Captura y copia al portapapeles"
    echo "  v, video         - Graba video de la pantalla"
    echo "  (sin modo)       - Captura pantalla completa"
    echo ""
    echo "Opciones:"
    echo "  --jpeg, -j       - Convertir la captura a JPEG"
    echo ""
    echo "Ejemplo: $0 s --jpeg"
    echo ""
    echo "Archivos se guardan en: $SCREENSHOT_DIR"
}

# Parsear argumentos
MODE=""
TO_JPEG=0
for arg in "$@"; do
    case "$arg" in
        s|select|m|monitor|p|all|w|window|c|clipboard|v|video)
            MODE="$arg"
            ;;
        --jpeg|-j)
            TO_JPEG=1
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
    esac
    # No shift, para permitir orden flexible
    # shift
done

# Timestamp y nombres de archivo
TIMESTAMP=$(date +"$DATE_FORMAT")
FILENAME="screenshot_${TIMESTAMP}.png"
FILEPATH="$SCREENSHOT_DIR/$FILENAME"
JPG_FILEPATH="${FILEPATH%.png}.jpg"

TOOL=$(get_screenshot_tool)
CLIPBOARD_TOOL=$(get_clipboard_tool)

if [ -z "$TOOL" ]; then
    echo "Error: No se encontró herramienta de captura (wl-screenshot o grim)" >&2
    send_notification "critical" "Screenshot" "No se encontró wl-screenshot ni grim. Instala uno de ellos." "camera"
    exit 1
fi

case "$MODE" in
    s|select)
        if [ "$TOOL" = "wl-screenshot" ]; then
            echo "[DEBUG] Usando wl-screenshot para selección de área" >&2
            wl-screenshot -g -f "$FILEPATH"
        elif [ "$TOOL" = "grim" ]; then
            if command -v slurp &> /dev/null; then
                echo "[DEBUG] Usando grim + slurp para selección de área" >&2
                grim -g "$(slurp)" "$FILEPATH"
            else
                echo "Error: grim requiere slurp para selección de área." >&2
                send_notification "critical" "Screenshot" "grim requiere slurp para selección de área." "camera"
                exit 1
            fi
        fi
        ;;
    m|monitor)
        MON=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true) | .name')
        [ -z "$MON" ] && MON="DP-1"
        if [ "$TOOL" = "wl-screenshot" ]; then
            wl-screenshot -o "$MON" -f "$FILEPATH"
        elif [ "$TOOL" = "grim" ]; then
            grim -o "$MON" "$FILEPATH"
        fi
        ;;
    p|all)
        if [ "$TOOL" = "wl-screenshot" ]; then
            wl-screenshot -f "$FILEPATH"
        elif [ "$TOOL" = "grim" ]; then
            grim "$FILEPATH"
        fi
        ;;
    w|window)
        if [ "$TOOL" = "wl-screenshot" ]; then
            wl-screenshot -w -f "$FILEPATH"
        else
            echo "Captura de ventana no soportada con grim, usando selección de área."
            if command -v slurp &> /dev/null; then
                grim -g "$(slurp)" "$FILEPATH"
            else
                echo "Error: grim requiere slurp para selección de área."
                exit 1
            fi
        fi
        ;;
    c|clipboard)
        if [ "$TOOL" = "wl-screenshot" ]; then
            wl-screenshot -f "$FILEPATH"
        elif [ "$TOOL" = "grim" ]; then
            grim "$FILEPATH"
        fi
        if [ -n "$CLIPBOARD_TOOL" ]; then
            copy_to_clipboard "$FILEPATH" "$CLIPBOARD_TOOL"
            echo "✅ Captura copiada al portapapeles"
        else
            echo "⚠️  No se encontró herramienta de portapapeles."
        fi
        ;;
    v|video)
        if command -v wf-recorder &> /dev/null; then
            VIDEO_FILE="$SCREENSHOT_DIR/screen_record_${TIMESTAMP}.mp4"
            wf-recorder -f "$VIDEO_FILE"
            echo "✅ Grabación guardada en $VIDEO_FILE"
        else
            echo "Error: wf-recorder no está instalado."
            exit 1
        fi
        ;;
    "")
        # Captura pantalla completa por defecto
        if [ "$TOOL" = "wl-screenshot" ]; then
            wl-screenshot -f "$FILEPATH"
        elif [ "$TOOL" = "grim" ]; then
            grim "$FILEPATH"
        fi
        ;;
    *)
        show_help
        exit 1
        ;;
esac

# Convertir a JPEG si se pidió
if [ "$TO_JPEG" = "1" ] && [ -f "$FILEPATH" ]; then
    convert_to_jpeg "$FILEPATH" "$JPG_FILEPATH"
fi

# Notificación final
if [ -f "$JPG_FILEPATH" ]; then
    send_notification "normal" "Screenshot" "Guardada en $JPG_FILEPATH" "camera"
elif [ -f "$FILEPATH" ]; then
    send_notification "normal" "Screenshot" "Guardada en $FILEPATH" "camera"
fi 