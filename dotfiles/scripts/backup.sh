#!/bin/bash
set -e

echo "🔄 Iniciando backup de dotfiles..."

# Verificar si estamos en el directorio correcto
if [[ ! -f "install.sh" ]]; then
  echo "❌ Error: No estás en el directorio arch-dots"
  echo "💡 Navega al directorio: cd ~/github/arch-dots"
  exit 1
fi

# Verificar si git está configurado
if ! git config --get user.name >/dev/null 2>&1; then
  echo "❌ Error: Git no está configurado"
  echo "💡 Configura git: git config --global user.name 'Tu Nombre'"
  echo "💡 Configura git: git config --global user.email 'tu@email.com'"
  exit 1
fi

# Verificar si hay cambios para commitear
if git diff --quiet && git diff --cached --quiet; then
  echo "ℹ️ No hay cambios para hacer backup"
  exit 0
fi

# Hacer backup
echo "📦 Agregando archivos..."
git add .

echo "💾 Creando commit..."
git commit -m "Backup: $(date '+%Y-%m-%d %H:%M:%S') - $(whoami)@$(hostname)"

echo "🚀 Subiendo a GitHub..."
if git push; then
  echo "✅ Backup completado exitosamente!"
  echo "📊 Último commit: $(git log -1 --oneline)"
else
  echo "❌ Error al subir a GitHub"
  echo "💡 Verifica tu conexión a internet y permisos de push"
  exit 1
fi 