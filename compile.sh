#!/bin/bash
archivo="$1"  # Recibe el nombre del archivo .asm como argumento

if [ -z "$archivo" ]; then
    echo "Uso: ./compile.sh <archivo.asm>"
    exit 1
fi

nombre_sin_extension="${archivo%.*}"  # Quita la extensión .asm

# Ensambla
nasm -f elf64 "$archivo" -o "$nombre_sin_extension.o"

# Enlaza
ld "$nombre_sin_extension.o" -o "$nombre_sin_extension"

# Ejecuta
./"$nombre_sin_extension"
