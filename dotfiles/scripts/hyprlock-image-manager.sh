#!/bin/bash

# Hyprlock Image Manager - Script Unificado
# Este script maneja todo lo relacionado con imágenes de Hyprlock

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HYPRLOCK_CONFIG="$HOME/.config/hyprlock"
HYPRLOCK_ASSETS="$HYPRLOCK_CONFIG/assets"
HYPRLOCK_WALLPAPERS="$HYPRLOCK_CONFIG/wallpapers"
PICTURES_DIR="$HOME/Pictures"

# Crear directorios necesarios
mkdir -p "$HYPRLOCK_CONFIG"
mkdir -p "$HYPRLOCK_ASSETS"
mkdir -p "$HYPRLOCK_WALLPAPERS"

# Assets predefinidos
ASSETS=(
    "mocha.webp:Catppuccin Mocha"
    "latte.webp:Catppuccin Latte"
    "macchiato.webp:Catppuccin Macchiato"
    "frappe.webp:Catppuccin Frappe"
)

show_help() {
    echo "🎨 Hyprlock Image Manager - Script Unificado"
    echo ""
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "🎯 Selección de Imágenes:"
    echo "  -p, --picker           Selector interactivo desde ~/Pictures"
    echo "  -r, --random           Imagen aleatoria desde ~/Pictures"
    echo "  -s, --search TERM      Buscar imágenes por nombre"
    echo "  -f, --folder PATH      Usar carpeta específica"
    echo "  -g, --graphical        Selector gráfico de archivos"
    echo ""
    echo "🎨 Fondos Predefinidos:"
    echo "  -a, --assets           Listar fondos predefinidos"
    echo "  -t, --theme NAME       Usar tema predefinido (mocha, latte, etc.)"
    echo "  -ra, --random-asset    Tema predefinido aleatorio"
    echo ""
    echo "🔄 Sincronización:"
    echo "  -w, --wallpaper        Usar wallpaper del sistema"
    echo "  -as, --auto-sync       Habilitar auto-sync con wallpaper"
    echo "  -ds, --disable-sync    Deshabilitar auto-sync"
    echo ""
    echo "⚙️  Efectos y Configuración:"
    echo "  -b, --blur             Toggle efecto blur"
    echo "  -n, --noise            Toggle efecto noise"
    echo "  -v, --vibrancy         Toggle efecto vibrancy"
    echo "  -c, --copy PATH        Copiar imagen a Hyprlock"
    echo "  -l, --list             Listar todas las imágenes disponibles"
    echo "  -h, --help             Mostrar esta ayuda"
    echo ""
    echo "Examples:"
    echo "  $0 --picker                    # Selector interactivo"
    echo "  $0 --random                    # Imagen aleatoria"
    echo "  $0 --search wallpaper          # Buscar wallpapers"
    echo "  $0 --theme mocha               # Usar tema Catppuccin Mocha"
    echo "  $0 --wallpaper                 # Usar wallpaper del sistema"
    echo "  $0 --auto-sync                 # Habilitar auto-sync"
    echo "  $0 --copy /path/to/image.jpg  # Copiar imagen"
}

# Función para encontrar imágenes
find_images() {
    local search_dir="$1"
    local search_term="$2"
    
    local find_cmd="find \"$search_dir\" -type f"
    local extensions="\( -iname \"*.jpg\" -o -iname \"*.jpeg\" -o -iname \"*.png\" -o -iname \"*.webp\" -o -iname \"*.bmp\" -o -iname \"*.gif\" \)"
    
    if [ -n "$search_term" ]; then
        find_cmd="$find_cmd -iname \"*$search_term*\" $extensions"
    else
        find_cmd="$find_cmd $extensions"
    fi
    
    eval "$find_cmd" 2>/dev/null | sort
}

# Función para obtener wallpaper del sistema
get_system_wallpaper() {
    local wallpaper_path=""
    
    # Check if using swww
    if command -v swww >/dev/null 2>&1; then
        wallpaper_path=$(swww query | grep -o 'image: .*' | cut -d' ' -f2)
    fi
    
    # Check if using feh
    if [ -z "$wallpaper_path" ] && command -v feh >/dev/null 2>&1; then
        wallpaper_path=$(cat ~/.fehbg 2>/dev/null | grep -o "'[^']*'" | tr -d "'" || echo "")
    fi
    
    # Check if using nitrogen
    if [ -z "$wallpaper_path" ] && command -v nitrogen >/dev/null 2>&1; then
        wallpaper_path=$(nitrogen --get-current 2>/dev/null || echo "")
    fi
    
    # Check common wallpaper directories
    if [ -z "$wallpaper_path" ]; then
        for dir in ~/Pictures/wallpapers ~/Pictures ~/wallpapers ~/.config/wallpapers; do
            if [ -d "$dir" ]; then
                wallpaper_path=$(find "$dir" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | head -1)
                break
            fi
        done
    fi
    
    echo "$wallpaper_path"
}

# Función para cambiar fondo de Hyprlock
set_hyprlock_background() {
    local image_path="$1"
    
    if [ ! -f "$image_path" ]; then
        echo "❌ Error: Archivo no encontrado: $image_path"
        return 1
    fi
    
    echo "🖼️  Cambiando fondo de Hyprlock: $(basename "$image_path")"
    
    # Backup current config
    local backup_file="$HYPRLOCK_CONFIG/hyprlock.conf.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$HYPRLOCK_CONFIG/hyprlock.conf" "$backup_file" 2>/dev/null
    
    # Update the background configuration
    # First, comment out the solid color background
    sed -i 's/^background {/background {\n    # Solid color background (commented out)/' "$HYPRLOCK_CONFIG/hyprlock.conf"
    sed -i 's/^    color = rgba(26, 27, 38, 0.95)/    # color = rgba(26, 27, 38, 0.95)/' "$HYPRLOCK_CONFIG/hyprlock.conf"
    
    # Add or update image background
    if grep -q "path = " "$HYPRLOCK_CONFIG/hyprlock.conf"; then
        # Update existing path
        sed -i "s|path = .*|path = $image_path|" "$HYPRLOCK_CONFIG/hyprlock.conf"
    else
        # Add path after the commented color line
        sed -i "/# color = rgba(26, 27, 38, 0.95)/a\    path = $image_path" "$HYPRLOCK_CONFIG/hyprlock.conf"
    fi
    
    # Enable blur and effects
    sed -i 's/# blur_passes = 3/blur_passes = 3/' "$HYPRLOCK_CONFIG/hyprlock.conf"
    sed -i 's/# blur_size = 8/blur_size = 8/' "$HYPRLOCK_CONFIG/hyprlock.conf"
    sed -i 's/# noise = 0.0117/noise = 0.0117/' "$HYPRLOCK_CONFIG/hyprlock.conf"
    sed -i 's/# contrast = 0.8916/contrast = 0.8916/' "$HYPRLOCK_CONFIG/hyprlock.conf"
    sed -i 's/# brightness = 0.8172/brightness = 0.8172/' "$HYPRLOCK_CONFIG/hyprlock.conf"
    sed -i 's/# vibrancy = 0.1696/vibrancy = 0.1696/' "$HYPRLOCK_CONFIG/hyprlock.conf"
    sed -i 's/# vibrancy_darkness = 0.0/vibrancy_darkness = 0.0/' "$HYPRLOCK_CONFIG/hyprlock.conf"
    
    echo "✅ Fondo de Hyprlock actualizado"
    echo "💾 Backup guardado como: $backup_file"
    echo "🔄 Reinicia Hyprlock para ver los cambios"
}

# Función para toggle de efectos
toggle_effect() {
    local effect="$1"
    local config_key=""
    local default_value=""
    
    case "$effect" in
        "blur")
            config_key="blur_passes"
            default_value="3"
            ;;
        "noise")
            config_key="noise"
            default_value="0.0117"
            ;;
        "vibrancy")
            config_key="vibrancy"
            default_value="0.1696"
            ;;
        *)
            echo "❌ Efecto desconocido: $effect"
            return 1
            ;;
    esac
    
    if grep -q "^    $config_key = " "$HYPRLOCK_CONFIG/hyprlock.conf"; then
        # Toggle off
        sed -i "s/^    $config_key = .*/# $config_key = $default_value/" "$HYPRLOCK_CONFIG/hyprlock.conf"
        echo "🔇 Efecto $effect deshabilitado"
    else
        # Toggle on
        sed -i "s/# $config_key = $default_value/$config_key = $default_value/" "$HYPRLOCK_CONFIG/hyprlock.conf"
        echo "🔊 Efecto $effect habilitado"
    fi
}

# Función para selector interactivo
interactive_picker() {
    local search_dir="$1"
    
    echo "🖼️  Selector Interactivo de Imágenes"
    echo "===================================="
    echo ""
    
    # Buscar todas las imágenes
    local images=($(find_images "$search_dir"))
    local count=${#images[@]}
    
    if [ $count -eq 0 ]; then
        echo "❌ No se encontraron imágenes en $search_dir"
        echo "💡 Asegúrate de tener imágenes en formato: jpg, jpeg, png, webp, bmp, gif"
        return 1
    fi
    
    echo "📋 Encontradas $count imágenes:"
    echo ""
    
    # Mostrar primeras 20 imágenes
    local display_count=$((count > 20 ? 20 : count))
    
    for i in $(seq 0 $((display_count-1))); do
        local filename=$(basename "${images[$i]}")
        local size=$(du -h "${images[$i]}" 2>/dev/null | cut -f1)
        local dimensions=$(identify -format "%wx%h" "${images[$i]}" 2>/dev/null || echo "Unknown")
        echo "  $((i+1)). $filename ($size, $dimensions)"
    done
    
    if [ $count -gt 20 ]; then
        echo "  ... y $((count-20)) imágenes más"
    fi
    
    echo ""
    echo "💡 Opciones:"
    echo "  - Ingresa un número (1-$display_count)"
    echo "  - Ingresa 'r' para selección aleatoria"
    echo "  - Ingresa 's' para buscar"
    echo "  - Ingresa 'a' para ver assets predefinidos"
    echo "  - Ingresa 'w' para usar wallpaper del sistema"
    echo "  - Ingresa 'q' para salir"
    echo ""
    
    read -p "Selecciona una opción: " choice
    
    case $choice in
        [0-9]*)
            if [ "$choice" -ge 1 ] && [ "$choice" -le $display_count ]; then
                local selected_image="${images[$((choice-1))]}"
                echo "✅ Imagen seleccionada: $(basename "$selected_image")"
                set_hyprlock_background "$selected_image"
            else
                echo "❌ Número inválido"
            fi
            ;;
        r|R)
            random_image "$search_dir"
            ;;
        s|S)
            read -p "Buscar imágenes con: " search_term
            search_and_pick "$search_dir" "$search_term"
            ;;
        a|A)
            list_assets
            ;;
        w|W)
            use_system_wallpaper
            ;;
        q|Q)
            echo "👋 ¡Hasta luego!"
            ;;
        *)
            echo "❌ Opción inválida"
            ;;
    esac
}

# Función para imagen aleatoria
random_image() {
    local search_dir="$1"
    
    echo "🎲 Seleccionando imagen aleatoria..."
    
    local images=($(find_images "$search_dir"))
    local count=${#images[@]}
    
    if [ $count -eq 0 ]; then
        echo "❌ No se encontraron imágenes en $search_dir"
        return 1
    fi
    
    local random_index=$((RANDOM % count))
    local selected_image="${images[$random_index]}"
    
    echo "✅ Imagen aleatoria seleccionada: $(basename "$selected_image")"
    set_hyprlock_background "$selected_image"
}

# Función para buscar y seleccionar
search_and_pick() {
    local search_dir="$1"
    local search_term="$2"
    
    echo "🔍 Buscando imágenes con '$search_term'..."
    
    local images=($(find_images "$search_dir" "$search_term"))
    local count=${#images[@]}
    
    if [ $count -eq 0 ]; then
        echo "❌ No se encontraron imágenes con '$search_term'"
        return 1
    fi
    
    echo "📋 Encontradas $count imágenes:"
    echo ""
    
    for i in "${!images[@]}"; do
        local filename=$(basename "${images[$i]}")
        echo "  $((i+1)). $filename"
    done
    
    echo ""
    read -p "Selecciona una imagen (1-$count): " choice
    
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le $count ]; then
        local selected_image="${images[$((choice-1))]}"
        echo "✅ Imagen seleccionada: $(basename "$selected_image")"
        set_hyprlock_background "$selected_image"
    else
        echo "❌ Selección inválida"
    fi
}

# Función para listar assets
list_assets() {
    echo "🎨 Assets Predefinidos Disponibles:"
    echo "=================================="
    echo ""
    
    for asset in "${ASSETS[@]}"; do
        IFS=':' read -r filename name <<< "$asset"
        if [ -f "$HYPRLOCK_ASSETS/$filename" ]; then
            echo "  ✓ $filename - $name"
        else
            echo "  ✗ $filename - $name (no encontrado)"
        fi
    done
    
    echo ""
    read -p "¿Usar un asset? (s/n): " use_asset
    if [[ "$use_asset" =~ ^[Ss]$ ]]; then
        echo ""
        echo "Assets disponibles:"
        for i in "${!ASSETS[@]}"; do
            IFS=':' read -r filename name <<< "${ASSETS[$i]}"
            if [ -f "$HYPRLOCK_ASSETS/$filename" ]; then
                echo "  $((i+1)). $filename - $name"
            fi
        done
        echo ""
        read -p "Selecciona un asset (1-${#ASSETS[@]}): " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#ASSETS[@]} ]; then
            IFS=':' read -r filename name <<< "${ASSETS[$((choice-1))]}"
            if [ -f "$HYPRLOCK_ASSETS/$filename" ]; then
                echo "✅ Asset seleccionado: $filename"
                set_hyprlock_background "$HYPRLOCK_ASSETS/$filename"
            else
                echo "❌ Asset no encontrado"
            fi
        else
            echo "❌ Selección inválida"
        fi
    fi
}

# Función para usar wallpaper del sistema
use_system_wallpaper() {
    local wallpaper_path=$(get_system_wallpaper)
    
    if [ -n "$wallpaper_path" ] && [ -f "$wallpaper_path" ]; then
        echo "🖼️  Usando wallpaper del sistema: $(basename "$wallpaper_path")"
        set_hyprlock_background "$wallpaper_path"
    else
        echo "❌ No se encontró wallpaper del sistema"
        echo "💡 Usa --copy para establecer una imagen específica"
    fi
}

# Función para auto-sync
enable_auto_sync() {
    echo "🔄 Habilitando auto-sync con wallpaper del sistema..."
    
    # Create a systemd user service for auto-sync
    local service_dir="$HOME/.config/systemd/user"
    local service_file="$service_dir/hyprlock-wallpaper-sync.service"
    
    mkdir -p "$service_dir"
    
    cat > "$service_file" << EOF
[Unit]
Description=Hyprlock Wallpaper Sync
After=graphical-session.target

[Service]
Type=oneshot
ExecStart=$SCRIPT_DIR/hyprlock-image-manager.sh --wallpaper
RemainAfterExit=yes

[Install]
WantedBy=graphical-session.target
EOF

    # Enable and start the service
    systemctl --user enable hyprlock-wallpaper-sync.service
    systemctl --user start hyprlock-wallpaper-sync.service
    
    echo "✅ Auto-sync habilitado"
    echo "💡 El servicio se sincronizará automáticamente cuando cambies wallpapers"
}

disable_auto_sync() {
    echo "🔄 Deshabilitando auto-sync..."
    
    # Stop and disable the service
    systemctl --user stop hyprlock-wallpaper-sync.service 2>/dev/null
    systemctl --user disable hyprlock-wallpaper-sync.service 2>/dev/null
    
    # Remove the service file
    rm -f "$HOME/.config/systemd/user/hyprlock-wallpaper-sync.service"
    
    echo "✅ Auto-sync deshabilitado"
}

# Función para copiar imagen
copy_image() {
    local image_path="$1"
    
    if [ ! -f "$image_path" ]; then
        echo "❌ Error: Archivo no encontrado: $image_path"
        return 1
    fi
    
    local filename=$(basename "$image_path")
    local target_path="$HYPRLOCK_WALLPAPERS/$filename"
    
    echo "📁 Copiando imagen a Hyprlock..."
    cp "$image_path" "$target_path"
    
    if [ $? -eq 0 ]; then
        echo "✅ Imagen copiada a: $target_path"
        echo "💡 Ahora puedes usar esta imagen con: $0 --picker"
    else
        echo "❌ Error al copiar la imagen"
        return 1
    fi
}

# Función para listar todas las imágenes
list_all_images() {
    echo "📋 Todas las Imágenes Disponibles"
    echo "================================"
    echo ""
    
    # Assets predefinidos
    echo "🎨 Assets Predefinidos:"
    for asset in "${ASSETS[@]}"; do
        IFS=':' read -r filename name <<< "$asset"
        if [ -f "$HYPRLOCK_ASSETS/$filename" ]; then
            echo "  ✓ $filename - $name"
        fi
    done
    
    echo ""
    echo "🖼️  Imágenes en ~/Pictures:"
    local pictures_images=($(find_images "$PICTURES_DIR"))
    local count=${#pictures_images[@]}
    if [ $count -gt 0 ]; then
        echo "  Encontradas $count imágenes"
        for i in "${!pictures_images[@]}"; do
            if [ $i -lt 10 ]; then
                local filename=$(basename "${pictures_images[$i]}")
                echo "    $((i+1)). $filename"
            fi
        done
        if [ $count -gt 10 ]; then
            echo "    ... y $((count-10)) imágenes más"
        fi
    else
        echo "  No se encontraron imágenes"
    fi
    
    echo ""
    echo "📁 Imágenes en Hyprlock:"
    if [ -d "$HYPRLOCK_WALLPAPERS" ] && [ "$(ls -A "$HYPRLOCK_WALLPAPERS" 2>/dev/null)" ]; then
        for file in "$HYPRLOCK_WALLPAPERS"/*; do
            if [ -f "$file" ]; then
                local filename=$(basename "$file")
                echo "  ✓ $filename"
            fi
        done
    else
        echo "  No hay imágenes personalizadas"
    fi
}

# Función para selector gráfico
graphical_picker() {
    local search_dir="$1"
    
    if command -v zenity >/dev/null 2>&1; then
        local selected_file=$(zenity --file-selection \
            --title="Seleccionar imagen para Hyprlock" \
            --filename="$search_dir/" \
            --file-filter="Imágenes | *.jpg *.jpeg *.png *.webp *.bmp *.gif")
        
        if [ -n "$selected_file" ] && [ -f "$selected_file" ]; then
            echo "✅ Imagen seleccionada: $(basename "$selected_file")"
            set_hyprlock_background "$selected_file"
        else
            echo "❌ No se seleccionó ninguna imagen"
        fi
    elif command -v kdialog >/dev/null 2>&1; then
        local selected_file=$(kdialog --getopenfilename \
            --title="Seleccionar imagen para Hyprlock" \
            "$search_dir/" "*.jpg *.jpeg *.png *.webp *.bmp *.gif")
        
        if [ -n "$selected_file" ] && [ -f "$selected_file" ]; then
            echo "✅ Imagen seleccionada: $(basename "$selected_file")"
            set_hyprlock_background "$selected_file"
        else
            echo "❌ No se seleccionó ninguna imagen"
        fi
    else
        echo "⚠️  No se encontró selector gráfico (zenity/kdialog)"
        echo "💡 Usando selector de texto..."
        interactive_picker "$search_dir"
    fi
}

# Main script logic
case "${1:-}" in
    -p|--picker)
        if [ -n "$2" ]; then
            interactive_picker "$2"
        else
            interactive_picker "$PICTURES_DIR"
        fi
        ;;
    -r|--random)
        if [ -n "$2" ]; then
            random_image "$2"
        else
            random_image "$PICTURES_DIR"
        fi
        ;;
    -s|--search)
        if [ -n "$2" ]; then
            search_and_pick "$PICTURES_DIR" "$2"
        else
            echo "❌ Error: Debes especificar un término de búsqueda"
            show_help
            exit 1
        fi
        ;;
    -f|--folder)
        if [ -n "$2" ]; then
            interactive_picker "$2"
        else
            echo "❌ Error: Debes especificar una carpeta"
            show_help
            exit 1
        fi
        ;;
    -g|--graphical)
        if [ -n "$2" ]; then
            graphical_picker "$2"
        else
            graphical_picker "$PICTURES_DIR"
        fi
        ;;
    -a|--assets)
        list_assets
        ;;
    -t|--theme)
        if [ -n "$2" ]; then
            if [ -f "$HYPRLOCK_ASSETS/$2.webp" ]; then
                echo "✅ Usando tema: $2"
                set_hyprlock_background "$HYPRLOCK_ASSETS/$2.webp"
            else
                echo "❌ Tema no encontrado: $2"
                echo "💡 Temas disponibles:"
                for asset in "${ASSETS[@]}"; do
                    IFS=':' read -r filename name <<< "$asset"
                    echo "  - ${filename%.webp}"
                done
            fi
        else
            echo "❌ Error: Debes especificar un tema"
            show_help
            exit 1
        fi
        ;;
    -ra|--random-asset)
        local random_index=$((RANDOM % ${#ASSETS[@]}))
        IFS=':' read -r filename name <<< "${ASSETS[$random_index]}"
        if [ -f "$HYPRLOCK_ASSETS/$filename" ]; then
            echo "✅ Tema aleatorio seleccionado: $name"
            set_hyprlock_background "$HYPRLOCK_ASSETS/$filename"
        else
            echo "❌ Asset no encontrado: $filename"
        fi
        ;;
    -w|--wallpaper)
        use_system_wallpaper
        ;;
    -as|--auto-sync)
        enable_auto_sync
        ;;
    -ds|--disable-sync)
        disable_auto_sync
        ;;
    -b|--blur)
        toggle_effect "blur"
        ;;
    -n|--noise)
        toggle_effect "noise"
        ;;
    -v|--vibrancy)
        toggle_effect "vibrancy"
        ;;
    -c|--copy)
        if [ -n "$2" ]; then
            copy_image "$2"
        else
            echo "❌ Error: Debes especificar una imagen"
            show_help
            exit 1
        fi
        ;;
    -l|--list)
        list_all_images
        ;;
    -h|--help)
        show_help
        ;;
    "")
        show_help
        ;;
    *)
        # Si se pasa una ruta de archivo directamente
        if [ -f "$1" ]; then
            set_hyprlock_background "$1"
        else
            echo "❌ Error: Opción desconocida o archivo no encontrado: $1"
            show_help
            exit 1
        fi
        ;;
esac 