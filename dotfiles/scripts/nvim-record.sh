#!/bin/bash
# nvim-record.sh - Graba la sesión de Neovim en video

DEST_DIR="$HOME/Videos/nvim_sessions"
mkdir -p "$DEST_DIR"
FILENAME="nvim_record_$(date +%Y%m%d_%H%M%S)"

# Preferencia: wf-recorder (Wayland), luego ffmpeg, luego asciinema
if command -v wf-recorder &> /dev/null; then
    OUTFILE="$DEST_DIR/$FILENAME.mp4"
    echo "Grabando con wf-recorder. Pulsa Ctrl+C para detener."
    wf-recorder -f "$OUTFILE"
    echo "✅ Grabación guardada en $OUTFILE"
elif command -v ffmpeg &> /dev/null; then
    OUTFILE="$DEST_DIR/$FILENAME.mp4"
    echo "Grabando con ffmpeg. Pulsa q para detener."
    ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0 "$OUTFILE"
    echo "✅ Grabación guardada en $OUTFILE"
elif command -v asciinema &> /dev/null; then
    OUTFILE="$DEST_DIR/$FILENAME.cast"
    echo "Grabando con asciinema. Pulsa Ctrl+D para detener."
    asciinema rec "$OUTFILE"
    echo "✅ Grabación guardada en $OUTFILE"
else
    echo "Error: No se encontró wf-recorder, ffmpeg ni asciinema."
    exit 1
fi 