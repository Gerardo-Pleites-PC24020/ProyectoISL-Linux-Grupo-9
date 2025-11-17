# 🐧 Servidor Linux Automatizado con Docker

<div align="center">

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)

**Universidad de El Salvador**  
*Facultad Multidisciplinaria de Occidente*

</div>

---

## Información del Proyecto

| Campo | Detalle |
|-------|---------|
| **Asignatura** | Introducción al Software Libre (ISL135) |
| **Ciclo Académico** | II-2025 |
| **Grupo** | 9 |
| **Modalidad** | Educación en Línea |
| **Fecha de Entrega** | 17 de noviembre de 2025 |

---

## Integrantes del Equipo

<table>
  <tr>
    <td align="center">
      <img src="https://via.placeholder.com/100" width="100px;" alt=""/><br />
      <b>Rodrigo Alexis Mercado Calidonio</b>
    </td>
    <td align="center">
      <img src="https://via.placeholder.com/100" width="100px;" alt=""/><br />
      <b>Manuel Abilio Posada Reina</b>
    </td>
    <td align="center">
      <img src="https://via.placeholder.com/100" width="100px;" alt=""/><br />
      <b>José Gerardo Pleites Campos</b>
    </td>
    <td align="center">
      <img src="https://via.placeholder.com/100" width="100px;" alt=""/><br />
      <b>Juan Pablo José Martínez Santamaría</b>
    </td>
  </tr>
</table>

---

## Descripción del Proyecto

Este proyecto implementa un **servidor Linux automatizado** mediante el uso de tecnologías de contenedores (Docker), integrando prácticas modernas de administración de sistemas, control de versiones y virtualización.

### Objetivos Cumplidos

- ✅ Configuración completa de un servidor Linux (hostname, usuarios y grupos)
- ✅ Implementación de estructura de directorios con permisos específicos
- ✅ Automatización de monitoreo del sistema mediante scripts bash
- ✅ Programación de tareas con Cron
- ✅ Control de versiones con Git y GitHub
- ✅ Instalación y configuración de Docker
- ✅ Despliegue de servidor web Nginx containerizado

---

## Arquitectura del Proyecto

```
/proyecto/
├── 📁 datos/           # Archivos de configuración
│   └── .gitkeep
├── 📁 web/             # Archivo del sitio web (grupo: web)
│   └── index.html      # Página web personalizada del grupo
├── 📁 scripts/         # Scripts de automatización
│   └── reporte_sistema.sh
├── 📁 capturas/        # Evidencias y capturas del proyecto
│   └── .gitkeep
└── 📄 README.md        # Documentación del proyecto
```

### Configuración de Usuarios y Grupos

| Usuario | Grupos | Privilegios |
|---------|--------|-------------|
| `adminsys` | sudo | Administrador con privilegios elevados |
| `tecnico` | soporte | Acceso a archivos de configuración |
| `visitante` | web | Acceso a archivos web |

---

## Guía de Instalación y Configuración

### 1️⃣ Preparación del Entorno Servidor

#### Configuración del Sistema

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

# Asignar permisos y grupos
sudo usermod -aG sudo adminsys
sudo usermod -aG soporte tecnico
sudo usermod -aG web visitante
```

#### 📂 Estructura de Directorios

```bash
# Crear estructura completa
sudo mkdir -p /proyecto/{datos,web,scripts,capturas}

# Asignar grupos a directorios
sudo chgrp soporte /proyecto/datos
sudo chgrp web /proyecto/web

# Configurar herencia de grupo (setgid)
sudo chmod g+s /proyecto/datos
sudo chmod g+s /proyecto/web
```

**Verificación:**
```bash
ls -la /proyecto/
# Debe mostrar 's' en los permisos: drwxr-sr-x
```

---

### 2️⃣ Automatización y Monitoreo

#### Script de Monitoreo del Sistema

El script `reporte_sistema.sh` recopila información crítica del servidor:

```bash
# Dar permisos de ejecución
sudo chmod +x /proyecto/scripts/reporte_sistema.sh

# Probar manualmente
sudo /proyecto/scripts/reporte_sistema.sh
```

**Información que reporta:**
- Fecha y hora actual
- Nombre del host
- Usuarios conectados
- Espacio libre en disco
- Memoria RAM disponible
- Contenedores Docker activos

#### Automatización con Cron

```bash
# Crear directorio para logs
sudo mkdir -p /var/log/proyecto

# Configurar tarea programada
sudo crontab -e
```

**Agregar al final del archivo:**
```cron
*/30 * * * * /proyecto/scripts/reporte_sistema.sh >> /var/log/proyecto/reporte_sistema.log 2>&1
```

**Verificación:**
```bash
# Ver configuración de cron
sudo crontab -l

# Verificar logs
cat /var/log/proyecto/reporte_sistema.log
```

---

### 3️⃣ Control de Versiones

#### Configuración de Git

```bash
# Navegar al directorio del proyecto
cd /proyecto

# Inicializar repositorio
sudo git init

# Configurar identidad
sudo git config --global user.name "usuario"
sudo git config --global user.email "correo@ues.edu.sv"

# Crear archivos .gitkeep para carpetas vacías
sudo touch capturas/.gitkeep datos/.gitkeep web/.gitkeep

# Agregar archivos al staging
sudo git add .

# Primer commit
sudo git commit -m "Primer commit: Estructura inicial del proyecto"
```

#### Conexión con GitHub

```bash
# Agregar repositorio remoto
sudo git remote add origin https://github.com/Gerardo-Pleites-PC24020/ProyectoISL-Linux-Grupo-9.git

# Establecer rama principal
sudo git branch -M main

# Subir cambios
sudo git push -u origin main
```

> **Nota:** Se requiere un Personal Access Token de GitHub para autenticación.

---

### 4️⃣ Docker

#### Instalación de Docker

```bash
# Actualizar sistema
sudo apt update

# Instalar dependencias
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Agregar clave GPG de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Verificar versión de Ubuntu base (para Linux Mint)
cat /etc/upstream-release/lsb-release

# Agregar repositorio de Docker
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu noble stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalar Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
```

#### Configuración de Docker

```bash
# Habilitar e iniciar servicio
sudo systemctl enable docker
sudo systemctl start docker

# Verificar instalación
docker --version
sudo systemctl status docker

# Agregar usuarios al grupo docker
sudo usermod -aG docker adminsys
sudo usermod -aG docker tecnico
sudo usermod -aG docker $USER

# Reiniciar para aplicar cambios
sudo reboot
```

#### Verificación de Docker

```bash
# Ejecutar contenedor de prueba
docker run hello-world

# Listar contenedores
docker ps -a

# Listar imágenes
docker images

# Ver información del sistema
docker info
```

---

### 5️⃣ Servidor Web Containerizado

#### Creación del Sitio Web

Se creó un archivo `index.html` personalizado en `/proyecto/web/` con el diseño del grupo.

```bash
# Verificar el archivo
cat /proyecto/web/index.html
ls -lh /proyecto/web/
```

#### Despliegue del Contenedor Nginx

```bash
# Ejecutar contenedor Nginx
docker run -d --name nginx-proyecto -p 8080:80 -v /proyecto/web:/usr/share/nginx/html nginx
```

**Parámetros explicados:**
- `-d`: Ejecuta en segundo plano (detached)
- `--name nginx-proyecto`: Nombre del contenedor
- `-p 8080:80`: Mapeo de puertos (host:contenedor)
- `-v /proyecto/web:/usr/share/nginx/html`: Montaje de volumen
- `nginx`: Imagen base de Nginx

#### Verificación del Servidor Web

```bash
# Verificar contenedor activo
docker ps

# Probar con curl
curl http://localhost:8080

# Ver logs
docker logs nginx-proyecto

# Logs en tiempo real
docker logs -f --tail 10 nginx-proyecto

# Verificar errores
docker logs nginx-proyecto 2>&1 | grep -i error
```

**Acceso desde navegador:** [http://localhost:8080](http://localhost:8080) 

---

## Comandos Útiles de Docker

### Gestión de Contenedores

```bash
# Detener contenedor
docker stop nginx-proyecto

# Iniciar contenedor
docker start nginx-proyecto

# Reiniciar contenedor
docker restart nginx-proyecto

# Ver detalles del contenedor
docker inspect nginx-proyecto

# Eliminar contenedor
docker rm -f nginx-proyecto
```

### Gestión de Imágenes

```bash
# Listar imágenes
docker images

# Eliminar imagen
docker rmi nginx

# Limpiar imágenes no utilizadas
docker image prune -a
```

---

## Monitoreo y Logs

### Ubicación de Logs

| Servicio | Ubicación del Log |
|----------|-------------------|
| Sistema | `/var/log/proyecto/reporte_sistema.log` |
| Docker (general) | `/var/lib/docker/` |
| Nginx (contenedor) | `docker logs nginx-proyecto` |

### Visualización de Logs

```bash
# Ver reportes del sistema
cat /var/log/proyecto/reporte_sistema.log

# Ver últimos 20 reportes
tail -n 20 /var/log/proyecto/reporte_sistema.log

# Monitoreo en tiempo real
tail -f /var/log/proyecto/reporte_sistema.log
```

---

## Estado del Proyecto

### ✅ Fases Completadas

- [x] **Fase 1:** Preparación del Entorno Servidor
  - [x] Administración Básica del Sistema
  - [x] Estructura de Directorios y Permisos
- [x] **Fase 2:** Automatización y Monitoreo
  - [x] Script de Monitoreo del Sistema
  - [x] Automatización con Cron
- [x] **Fase 3:** Control de Versiones
  - [x] Repositorio Git Local y Remoto
- [x] **Fase 4:** Docker
  - [x] Instalación y Configuración
  - [x] Verificación Inicial
- [x] **Fase 5:** Servidor Web Containerizado
  - [x] Contenedor Nginx Básico
  - [x] Verificación del Servicio Web

---

## Solución de Problemas

### Problema: Docker no se inicia

```bash
# Verificar estado del servicio
sudo systemctl status docker

# Reiniciar servicio
sudo systemctl restart docker

# Ver logs de Docker
sudo journalctl -u docker.service
```

### Problema: Permisos denegados en Docker

```bash
# Verificar membresía de grupo
groups $USER

# Si no aparece 'docker', agregarlo y reiniciar sesión
sudo usermod -aG docker $USER
```

### Problema: Puerto ya en uso

```bash
# Ver qué proceso usa el puerto 8080
sudo lsof -i :8080

# Detener el proceso o usar otro puerto
docker run -d --name nginx-proyecto -p 8081:80 -v /proyecto/web:/usr/share/nginx/html nginx
```

---

## Recursos y Referencias

- [Documentación oficial de Docker](https://docs.docker.com/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Git Documentation](https://git-scm.com/doc)
- [Cron HowTo - Ubuntu](https://help.ubuntu.com/community/CronHowto)
- [Linux Mint Documentation](https://linuxmint.com/documentation.php)

---

## Notas Adicionales

### Consideraciones de Seguridad

- Los usuarios tienen permisos específicos según su rol
- Los directorios utilizan setgid para herencia de grupo
- Docker está configurado para uso sin sudo en usuarios específicos

### Rendimiento

- El script de monitoreo se ejecuta cada 30 minutos para no sobrecargar el sistema
- Los logs se almacenan con rotación automática del sistema

### Buenas Prácticas Implementadas

- ✅ Uso de control de versiones (Git)
- ✅ Documentación completa del proyecto
- ✅ Automatización de tareas repetitivas
- ✅ Separación de permisos por roles
- ✅ Contenedorización de servicios

---

## Contacto y Soporte

Para dudas o problemas con el proyecto, contactar a cualquiera de los integrantes del grupo o al tutor asignado de la asignatura.

---

<div align="center">

**Proyecto desarrollado por el Grupo 9**

*Universidad de El Salvador - Facultad Multidisciplinaria de Occidente*

*Ciclo II-2025*

---
</div>