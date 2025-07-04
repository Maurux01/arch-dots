# 📜 Scripts de Arch Dots

Esta carpeta contiene scripts útiles para mantener y gestionar tu instalación de Arch Dots.

## 🛠️ Scripts Disponibles

### **install.sh** (Principal)
**Ubicación:** `./install.sh`  
**Propósito:** Instalador principal del sistema  
**Uso:**
```bash
./install.sh
```

**Características:**
- ✅ Instalación interactiva con menú
- ✅ Detección automática de entorno (real vs virtual)
- ✅ Verificación de archivos antes de copiar
- ✅ Manejo robusto de errores
- ✅ Separación de paquetes oficiales vs AUR

---

### **postinstall.sh**
**Ubicación:** `dotfiles/scripts/postinstall.sh`  
**Propósito:** Configuración post-instalación  
**Uso:**
```bash
./dotfiles/scripts/postinstall.sh
```

**Funcionalidades:**
- 📦 Instalación automática de fuentes Nerd Fonts
- 🔄 Actualización de caché de fuentes
- 🔧 Configuración de eww widgets
- ✅ Verificación de configuraciones
- 📝 Instrucciones para Neovim

---

### **backup.sh**
**Ubicación:** `dotfiles/scripts/backup.sh`  
**Propósito:** Backup automático de dotfiles  
**Uso:**
```bash
./dotfiles/scripts/backup.sh
```

**Funcionalidades:**
- 🔍 Verificación de directorio correcto
- ⚙️ Verificación de configuración Git
- 📦 Commit automático con timestamp
- 🚀 Push a GitHub
- ✅ Feedback detallado del proceso

---

### **utils.sh** (Nuevo)
**Ubicación:** `dotfiles/scripts/utils.sh`  
**Propósito:** Utilidades del sistema  
**Uso:**
```bash
./dotfiles/scripts/utils.sh [comando]
```

**Comandos disponibles:**

#### **Actualizar Sistema**
```bash
./dotfiles/scripts/utils.sh update
```
- 🔄 Sincroniza repositorios
- 📦 Actualiza paquetes
- 🧹 Limpia caché
- 🗑️ Elimina paquetes huérfanos

#### **Limpiar Sistema**
```bash
./dotfiles/scripts/utils.sh clean
```
- 🧹 Limpia caché de pacman
- 🗑️ Elimina paquetes huérfanos
- 🧹 Limpia caché de yay
- 📝 Limpia logs antiguos

#### **Verificar Estado**
```bash
./dotfiles/scripts/utils.sh check
```
- 🔍 Verifica paquetes rotos
- 💾 Muestra uso de disco
- 🧠 Muestra uso de memoria
- 🌡️ Muestra temperatura (si está disponible)

#### **Configurar Firewall**
```bash
./dotfiles/scripts/utils.sh firewall
```
- 🔥 Habilita UFW
- 🛡️ Configura reglas básicas
- 📊 Muestra estado del firewall

#### **Optimizar Sistema**
```bash
./dotfiles/scripts/utils.sh optimize
```
- ⚡ Optimiza SSD (si aplica)
- 🔧 Ajusta swappiness
- 🚀 Aplica optimizaciones generales

#### **Información del Sistema**
```bash
./dotfiles/scripts/utils.sh info
```
- 🐧 Información de distribución
- 🔧 Información de kernel
- 💻 Información de hardware
- 📦 Número de paquetes instalados

#### **Instalar Paquetes AUR**
```bash
./dotfiles/scripts/utils.sh aur paquete1 paquete2
```
- 📦 Instala paquetes desde AUR
- 🔄 Usa yay o pamac automáticamente
- ✅ Manejo de errores

---

## 🎯 Scripts de Eww

### **weather.sh**
**Ubicación:** `dotfiles/eww/scripts/weather.sh`  
**Propósito:** Obtener información del clima  
**Características:**
- 🌤️ Soporte para OpenWeatherMap API
- 🔄 Fallback a wttr.in
- ⚙️ Configuración de ciudad
- 🕐 Timeout para evitar bloqueos

**Configuración:**
```bash
export WEATHER_CITY="Madrid"
export WEATHER_API_KEY="tu-api-key"  # Opcional
```

### **battery.sh**
**Ubicación:** `dotfiles/eww/scripts/battery.sh`  
**Propósito:** Información de batería  
**Características:**
- 🔋 Estado de carga
- ⚡ Nivel de batería
- 🔌 Estado de conexión
- ⏱️ Tiempo restante

### **volume.sh**
**Ubicación:** `dotfiles/eww/scripts/volume.sh`  
**Propósito:** Control de volumen  
**Uso:**
```bash
./dotfiles/eww/scripts/volume.sh up    # Subir volumen
./dotfiles/eww/scripts/volume.sh down  # Bajar volumen
./dotfiles/eww/scripts/volume.sh mute  # Silenciar
```

---

## 🔧 Funciones de Fish Shell

### **dotbackup**
Función integrada en Fish para backup rápido:
```bash
dotbackup
```

### **update**
Actualizar sistema:
```bash
update
```

### **search**
Buscar paquetes:
```bash
search paquete
```

### **install**
Instalar paquetes:
```bash
install paquete1 paquete2
```

### **remove**
Desinstalar paquetes:
```bash
remove paquete1 paquete2
```

### **sysinfo**
Información del sistema:
```bash
sysinfo
```

### **weather**
Clima en terminal:
```bash
weather Madrid
```

---

## 🚀 Uso Avanzado

### **Combinar Scripts**
```bash
# Actualizar y limpiar en una línea
./dotfiles/scripts/utils.sh update && ./dotfiles/scripts/utils.sh clean
```

### **Automatización**
```bash
# Agregar a crontab para actualizaciones automáticas
0 2 * * 0 /ruta/a/arch-dots/dotfiles/scripts/utils.sh update
```

### **Logs y Debugging**
```bash
# Ver logs de eww
eww logs

# Debug de waybar
waybar -l debug

# Logs del sistema
journalctl -f
```

---

## 🔍 Troubleshooting

### **Scripts no ejecutables**
```bash
chmod +x dotfiles/scripts/*.sh
chmod +x dotfiles/eww/scripts/*.sh
```

### **Permisos de Git**
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

### **Configuración de eww**
```bash
eww kill
eww daemon
eww open-many main-bar
```

---

## 📝 Notas Importantes

- Todos los scripts incluyen manejo de errores
- Los scripts verifican dependencias antes de ejecutar
- Se incluyen mensajes informativos con emojis
- Los scripts son compatibles con entornos reales y virtuales
- Se incluye documentación detallada en cada script

---

**💡 Tip:** Usa `./dotfiles/scripts/utils.sh help` para ver todas las opciones disponibles. 