#!/usr/bin/env bash

# TP3 - Tarea 5: Procesamiento de registros Syslog
# Legajo: 8488

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOSITORIO="$(dirname "$SCRIPT_DIR")"
ARCHIVO_ORIGEN="${1:-/var/log/syslog}"
ARCHIVO_REPORTE="$REPOSITORIO/logs/reporte_errores_8488.txt"

# Verificar que el archivo de origen se pueda leer
if [[ ! -r "$ARCHIVO_ORIGEN" ]]; then
    echo "Error: No se puede leer $ARCHIVO_ORIGEN"
    exit 1
fi

# Crear la carpeta de logs si no existe
mkdir -p "$REPOSITORIO/logs"

# Procesar los registros con AWK
awk '
BEGIN {
    split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec", meses, " ")

    printf "%-7s %-8s %-25s %-50s\n", "FECHA", "HORA", "PROCESO", "MENSAJE"
}

tolower($0) ~ /error|fail|critical/ {
    # Separar la fecha del formato ISO 8601
    split(substr($1, 1, 10), partes, "-")
    fecha = meses[partes[2] + 0] " " partes[3]

    # Obtener la hora sin los milisegundos
    hora = substr($1, 12, 8)

    # Extraer el proceso y eliminar su PID
    proceso = $3
    sub(/:$/, "", proceso)
    sub(/\[[0-9]+\]$/, "", proceso)
    sub(/^.*\//, "", proceso)

    # Reconstruir el mensaje desde la cuarta columna
    mensaje = ""
    for (i = 4; i <= NF; i++) {
        mensaje = mensaje (i == 4 ? "" : " ") $i
    }

    # Imprimir columnas fijas y limitar el mensaje a 50 caracteres
    printf "%-7s %-8s %-25s %-50.50s\n", fecha, hora, proceso, mensaje
}
' "$ARCHIVO_ORIGEN" > "$ARCHIVO_REPORTE"

echo "Reporte generado correctamente."
echo "Archivo: $ARCHIVO_REPORTE"
