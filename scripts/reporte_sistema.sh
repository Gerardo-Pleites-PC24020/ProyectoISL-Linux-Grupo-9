#!/bin/bash
 
echo "========================================="
echo " 	REPORTE DEL SISTEMA"
echo "========================================="
echo ""
echo "Fecha y hora actual:"
date "+%Y-%m-%d %H:%M:%S"
echo ""
echo "Nombre del host:"
hostname
echo ""
echo "Usuarios conectados:"
who | wc -l
echo ""
echo "Espacio libre en disco principal:"
df -h / | awk 'NR==2 {print "Disponible: " $4 " de " $2 " (" $5 " usado)"}'
echo ""
echo "Memoria RAM disponible:"
free -h | awk 'NR==2 {print "Disponible: " $7 " de " $2}'
echo ""
echo "Contenedores Docker activos:"
docker ps -q 2>/dev/null | wc -l
echo ""
echo "========================================="

