#!/usr/bin/env bash

# TP3 - Tarea 4: Configuración segura del hostname
# Legajo: 8488

# Verificar que se ejecute como administrador
if [[ $EUID -ne 0 ]]; then
    echo "Error: Este script requiere privilegios de administrador."
    echo "Ejecutelo utilizando sudo."
    exit 1
fi

# Verificar que se haya ingresado un argumento válido
if [[ $# -ne 1 || "$1" != "curzas-alumno-8488" ]]; then
    echo "Error: Debe indicar el hostname curzas-alumno-8488."
    echo "Uso: sudo $0 curzas-alumno-8488"
    exit 1
fi

NUEVO_HOSTNAME="$1"
HOSTNAME_ANTERIOR=$(cat /etc/hostname)

# Comprobar que exista la referencia anterior en /etc/hosts
if ! grep -Fq "$HOSTNAME_ANTERIOR" /etc/hosts; then
    echo "Error: No se encontro el hostname anterior en /etc/hosts."
    exit 1
fi

# Crear copias de seguridad
cp -p /etc/hostname /etc/hostname.bak
cp -p /etc/hosts /etc/hosts.bak

# Actualizar /etc/hosts utilizando sed
sed -i "/^127\.0\.1\.1[[:space:]]/s/$HOSTNAME_ANTERIOR/$NUEVO_HOSTNAME/" /etc/hosts

# Actualizar /etc/hostname
echo "$NUEVO_HOSTNAME" > /etc/hostname

# Aplicar el nuevo nombre al sistema
hostname "$NUEVO_HOSTNAME"

echo "Hostname actualizado correctamente."
echo "Anterior: $HOSTNAME_ANTERIOR"
echo "Nuevo: $NUEVO_HOSTNAME"
