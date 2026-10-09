#!/usr/bin/env bash

# TP3 - Tarea 1: Monitoreo de usuarios activos
# Legajo: 8488

REPOSITORIO="$HOME/tp3-Uichaques-CURZA-8488"
ARCHIVO_LOG="$REPOSITORIO/logs/usuarios_activos_8488.log"
LEGAJO="8488"
TOKEN="84881289"

# Crear el directorio de logs si no existe
mkdir -p "$REPOSITORIO/logs"

# Agregar el encabezado únicamente si el archivo está vacío o no existe
if [[ ! -s "$ARCHIVO_LOG" ]]; then
    echo "Legajo: $LEGAJO | Token de autenticidad: $TOKEN" > "$ARCHIVO_LOG"
fi

# Obtener la fecha, hora y cantidad de usuarios conectados
FECHA_HORA=$(date "+%Y-%m-%d %H:%M:%S")
USUARIOS=$(who | wc -l)

# Anexar el resultado sin sobrescribir los registros anteriores
echo "$FECHA_HORA | Usuarios activos: $USUARIOS" >> "$ARCHIVO_LOG"
