#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "🚀 Iniciando despliegue del Portafolio Vanille..."

SOURCE_DIR="$HOME/vanille-homepage"
TARGET_DIR="$HOME/vanillevault.github.io"
FILE_NAME="vanille_portfolio.html"

echo "Comprobando archivo $FILE_NAME en $SOURCE_DIR..."
if [ ! -f "$SOURCE_DIR/$FILE_NAME" ]; then
  echo "❌ ERROR: No se encontró $FILE_NAME en $SOURCE_DIR"
  exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
  echo "Clonando repo vanillevault.github.io..."
  git clone https://github.com/vanillevault/vanillevault.github.io.git "$TARGET_DIR" || {
    echo "❌ ERROR: No se pudo clonar el repo."
    exit 1
  }
fi

echo "Copiando archivo a $TARGET_DIR..."
cp "$SOURCE_DIR/$FILE_NAME" "$TARGET_DIR/" || {
  echo "❌ ERROR: No se pudo copiar el archivo."
  exit 1
}

cd "$TARGET_DIR"

echo "Haciendo git pull..."
git pull origin main || echo "⚠️ No se pudo hacer git pull, continuando..."

echo "Agregando cambios..."
git add "$FILE_NAME"

echo "Commit y push..."
git commit -m "🚀 Añadir vanille_portfolio.html desde script" || echo "⚠️ Nada que commitear"
git push origin main || {
  echo "❌ ERROR: No se pudo hacer push."
  exit 1
}

echo "✅ ¡Portafolio desplegado correctamente!"
echo "🌐 URL: https://vanillevault.github.io/vanille_portfolio.html"
