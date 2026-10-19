#!/usr/bin/env bash

# TP3 - Tarea 3: Diagnóstico de red con Systemd
# Legajo: 8488

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOSITORIO="$(dirname "$SCRIPT_DIR")"
ARCHIVO_LOG="$REPOSITORIO/logs/ping_report_8488.log"

# Crear la carpeta de logs si no existe
mkdir -p "$REPOSITORIO/logs"

# Detectar automáticamente el gateway
GATEWAY="$(ip route | awk '/^default/ {print $3; exit}')"

# Registrar la fecha y hora
echo "===== Diagnóstico: $(date '+%Y-%m-%d %H:%M:%S') =====" >> "$ARCHIVO_LOG"

# Verificar que se haya detectado un gateway
if [[ -z "$GATEWAY" ]]; then
    echo "Error: no se pudo detectar el gateway." >> "$ARCHIVO_LOG"
    echo "----------------------------------------" >> "$ARCHIVO_LOG"
    exit 1
fi

echo "Gateway detectado: $GATEWAY" >> "$ARCHIVO_LOG"

# Realizar 4 solicitudes ping al gateway
if ping -c 4 -W 2 "$GATEWAY" >> "$ARCHIVO_LOG" 2>&1; then
    echo "Resultado: Gateway accesible" >> "$ARCHIVO_LOG"
else
    echo "Resultado: Gateway no accesible" >> "$ARCHIVO_LOG"
fi

echo "----------------------------------------" >> "$ARCHIVO_LOG"
