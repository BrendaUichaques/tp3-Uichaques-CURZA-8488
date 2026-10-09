#!/usr/bin/env bash

# TP3 - Tarea 3: Diagnóstico de red con Systemd
# Legajo: 8488

REPOSITORIO="$HOME/tp3-Uichaques-CURZA-8488"
ARCHIVO_LOG="$REPOSITORIO/logs/ping_report_8488.log"
GATEWAY="192.168.1.1"

# Crear la carpeta de logs si no existe
mkdir -p "$REPOSITORIO/logs"

# Registrar la fecha y hora del diagnóstico
echo "===== Diagnóstico: $(date '+%Y-%m-%d %H:%M:%S') =====" >> "$ARCHIVO_LOG"

# Realizar 4 solicitudes ping al gateway
ping -c 4 -W 2 "$GATEWAY" >> "$ARCHIVO_LOG" 2>&1

# Registrar el resultado de la ejecución
if [[ $? -eq 0 ]]; then
    echo "Resultado: Gateway accesible" >> "$ARCHIVO_LOG"
else
    echo "Resultado: Gateway no accesible" >> "$ARCHIVO_LOG"
fi

echo "----------------------------------------" >> "$ARCHIVO_LOG"
