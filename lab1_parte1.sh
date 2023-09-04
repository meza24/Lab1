#!/bin/bash

# Recibiendo como parámetro un archivo 
if [ $# -ne 1 ]; then
    echo "Error: Proporcione  un archivo como argumento."
    exit 1
fi

archivo="$1"

# Verificamos que el archivo existe
if [ ! -e "$archivo" ]; then
    echo "Error: El archivo '$archivo' no existe."
    exit 2
fi

# Obtenemos los permisos del archivo y lo guardamos 
permisos=$(stat -c "%A" "$archivo")

# Usamos la función get_permission_verbose para obtener la información
get_permissions_verbose() {
    permisos="$1"
    usuario="${permisos:1:3}"
    grupo="${permisos:4:3}"
    otros="${permisos:7:3}"

    echo "Permisos del usuario: $usuario"
    echo "Permisos del grupo: $grupo"
    echo "Permisos de otros: $otros"
}

get_permissions_verbose "$permisos"

