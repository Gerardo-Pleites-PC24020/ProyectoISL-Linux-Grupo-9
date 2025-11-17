# Proyecto Final - Introducción al Software Libre (ISL135)
 
## Información del Proyecto
- **Curso:** Introducción al Software Libre
- **Ciclo:** II-2025
- **Grupo:** 9
- **Universidad:** Universidad de El Salvador - Facultad Multidisciplinaria de Occidente
 
## Integrantes
1. [Nombre Integrante 1]
2. [Nombre Integrante 2]
3. [Nombre Integrante 3]
4. [Nombre Integrante 4]
 
## Descripción
Servidor Linux automatizado implementado con Docker, que incluye:
- Administración de usuarios y grupos
- Estructura de directorios con permisos específicos
- Script de monitoreo automatizado con cron
- Servidor web containerizado con Nginx
- Control de versiones con Git
 
## Estructura del Proyecto
```
/proyecto/
├── datos/      	# Archivos de configuración (grupo: soporte)
├── web/        	# Archivos del sitio web (grupo: web)
├── scripts/    	# Scripts de automatización
│   └── reporte_sistema.sh
├── capturas/   	# Evidencias del proyecto
└── README.md   	# Este archivo
```
 
## Instalación y Configuración
 
### 1. Configuración del Sistema
```bash
# Cambiar hostname
sudo hostnamectl set-hostname servidor-grupo9
 
# Crear usuarios
sudo adduser adminsys
sudo adduser tecnico
sudo adduser visitante
 
# Crear grupos
sudo groupadd soporte
sudo groupadd web
 
# Asignar permisos
sudo usermod -aG sudo adminsys
sudo usermod -aG soporte tecnico
sudo usermod -aG web visitante
```
 
### 2. Estructura de Directorios
```bash
# Crear estructura
sudo mkdir -p /proyecto/{datos,web,scripts,capturas}
 
# Asignar grupos
sudo chgrp soporte /proyecto/datos
sudo chgrp web /proyecto/web
 
# Configurar setgid
sudo chmod g+s /proyecto/datos
sudo chmod g+s /proyecto/web
```
 
### 3. Script de Monitoreo
```bash
# Dar permisos de ejecución
sudo chmod +x /proyecto/scripts/reporte_sistema.sh
 
# Configurar cron (cada 30 minutos)
sudo crontab -e
# Agregar: */30 * * * * /proyecto/scripts/reporte_sistema.sh >> /var/log/proyecto/reporte_sistema.log 2>&1
```
 
### 4. Docker (Pendiente)
Instalación y configuración de Docker para servidor web Nginx.
 
## Logs y Monitoreo
- Los reportes del sistema se almacenan en: `/var/log/proyecto/reporte_sistema.log`
- Ejecución automática cada 30 minutos vía cron
 
## Repositorio
- **GitHub:** https://github.com/tu-usuario/proyecto-linux-grupo9
 
## Fecha de Entrega
17 de noviembre de 2025
