# Trabajo Práctico N.º 3 - Automatización y Scripting

**Universidad:** Universidad Nacional del Comahue  
**Centro Regional:** CURZAS  
**Carrera:** Tecnicatura Superior en Administración de Sistemas y Software Libre  
**Asignatura:** Automatización y Scripting  
**Alumna:** Brenda Uichaques  
**Legajo:** 8488

## Descripción del trabajo

Este repositorio contiene la resolución del Trabajo Práctico N.º 3 de la asignatura Automatización y Scripting.

El trabajo consiste en implementar herramientas de automatización y administración de sistemas Linux mediante scripts desarrollados en Bash.

Se utilizaron herramientas como Cron, At, Systemd, grep, sed y awk para realizar tareas de monitoreo, programación de descargas, diagnóstico de red, configuración del hostname y procesamiento de registros del sistema.

## Tareas desarrolladas

1. **Monitoreo de usuarios con Cron:** registro periódico de usuarios conectados al sistema. Se utilizan rutas dinámicas para guardar los registros dentro del repositorio.

2. **Descargas programadas con At:** programación de descargas de archivos comprimidos, utilizando rutas dinámicas para su almacenamiento.

3. **Diagnóstico de red con Systemd Timers:** monitoreo automático de la conectividad con el gateway, detectado mediante `ip route`.

   **Nota sobre la instalación:** el archivo `config/monitoreo_8488.service` utiliza una ruta absoluta en `ExecStart` y un usuario específico en `User`. Estos valores deben adaptarse a la ubicación del repositorio y al usuario del equipo donde se instale el servicio.

4. **Configuración segura del hostname:** modificación del nombre del equipo mediante un script con privilegios de administrador.

5. **Procesamiento de Syslog:** filtrado y generación de reportes estructurados de errores del sistema mediante `awk`, utilizando rutas dinámicas para guardar los resultados.
