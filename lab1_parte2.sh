#!/bin/bash

# Verificamos que se proporcionen dos argumentos: nuevo_nombre_usuario y nombre_grupo
if [ $# -ne 2 ]; then
    echo "Error: Debes proporcionar el nombre del nuevo usuario y el nombre del grupo."
    exit 1
fi

nuevo_nombre_usuario="$1"
nombre_grupo="$2"

# Aseguramos si el usuario ya existe
if id "$nuevo_nombre_usuario" &>/dev/null; then
    echo "El usuario '$nuevo_nombre_usuario' ya existe."
else
    # Creamos el nuevo usuario si no existe
    sudo useradd "$nuevo_nombre_usuario"
    echo "Usuario '$nuevo_nombre_usuario' creado."
fi

# Verificamos si el grupo ya existe
if grep -q "^$nombre_grupo:" /etc/group; then
    echo "El grupo '$nombre_grupo' ya existe."
else
    # Creamos el grupo si no existe
    sudo groupadd "$nombre_grupo"
    echo "Grupo '$nombre_grupo' creado."
fi

# Agregar usuarios al grupo
sudo usermod -aG "$nombre_grupo" "$USER"  # Agregamos el usuario actual al grupo
sudo usermod -aG "$nombre_grupo" "$nuevo_nombre_usuario"  # Agregamos el nuevo usuario al grupo
echo "Usuarios agregados al grupo '$nombre_grupo'."


#Permisos de ejecución del del script lab1_parte1 para que solo miembros del grupo lab1 puedan ejecutarlo
sudo chgrp "$nombre_grupo" script.sh  
sudo chmod 750 script.sh

echo "Permisos asignados al script para el grupo '$nombre_grupo'." 
