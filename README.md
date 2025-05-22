# SR23002-DEC

**DEC135 - 2025 - Ciclo 05 - UES**

Repositorio para la asignatura DEC135, correspondientes al ciclo 05 del año 2025 en la Universidad de El Salvador (UES).
Contiene 3 sencillos programas de ensamblador para la resta, multiplicación y división.

## 📁 Estructura del repositorio

- `division/` – Implementación de la operación de división en ensamblador.
- `multiplicacion/` – Implementación de la operación de multiplicación en ensamblador.
- `resta/` – Implementación de la operación de resta en ensamblador.
- `test/` – Pruebas y ejemplos adicionales para verificar el funcionamiento de los programas.

## ⚙️ Requisitos

- **Sistema operativo:** Linux de 64 bits
- **Ensamblador:** NASM
- **Enlazador:** ld (GNU linker)

## 🛠️ Compilación y ejecución

Para compilar y ejecutar los programas de ejemplo, sigue los siguientes pasos en tu terminal:

```bash
# Ensamblar el archivo fuente
nasm -f elf64 archivo.asm -o archivo.o

# Enlazar el archivo objeto
ld archivo.o -o programa

# Ejecutar el programa
./programa
