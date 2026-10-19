#!/usr/bin/env bash

# TP3 - Tarea 2: Descarga programada de archivos
# Legajo: 8488

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOSITORIO="$(dirname "$SCRIPT_DIR")"
DESTINO="$REPOSITORIO/descargas"

# Verificar que se haya ingresado una URL
if [[ $# -ne 1 ]]; then
    echo "Error: Debe ingresar una URL."
    echo "Uso: $0 <URL>"
    exit 1
fi

URL="$1"

# Validar que la URL utilice HTTP o HTTPS
if [[ ! "$URL" =~ ^https?:// ]]; then
    echo "Error: La URL debe comenzar con http:// o https://"
    exit 1
fi

# Obtener el nombre del archivo desde la URL
RUTA_ARCHIVO="${URL%%\?*}"
ARCHIVO="${RUTA_ARCHIVO##*/}"

# Verificar que sea un archivo comprimido
if [[ ! "$ARCHIVO" =~ \.(zip|tar|tar\.gz|tgz|gz|bz2|xz|7z)$ ]]; then
    echo "Error: La URL debe apuntar a un archivo comprimido."
    exit 1
fi

# Crear la carpeta de descargas si no existe
mkdir -p "$DESTINO"

# Descargar el archivo utilizando wget
echo "Iniciando descarga: $ARCHIVO"

if wget -O "$DESTINO/$ARCHIVO" "$URL"; then
    echo "Descarga completada correctamente."
    echo "Archivo guardado en: $DESTINO/$ARCHIVO"
else
    echo "Error: No se pudo completar la descarga."
    exit 1
fi
