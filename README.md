# SR23002-DEC

**DEC135 - 2025 - Ciclo 05 - UES**

Repositorio para la actividad de portafolio que contiene ejercicios de programación en lenguaje ensamblador.  
Los ejercicios están diseñados para ejecutarse en entornos Linux de 64 bits, utilizando NASM y WSL en Windows 11.

## 📁 Estructura del repositorio

- `division/` – Solución del ejercicio de la operación de división, el cual resta 03 números de 16 bits.
- `multiplicacion/` – Solución del ejercicio de la operación de multiplicación que multiplica 02 números de 8 bits.
- `resta/` – Solución del ejercicio de la operación de resta que divide 2 números enteros de 32 bits.

 Por cada carpeta se encuentar el archivo de código **.asm**, el archivo compilado como objeto **.o** y el archivo enlazado **ejecutable sin extensión**.

## ⚙️ Requisitos para ejecución

- **Sistema operativo:** Linux de 64 bits (en mi caso utilicé WSL en Windows 11 con Debian)
- **Ensamblador:** NASM versión 2.16.01
- **Enlazador:** GNU ld (GNU Binutils for Debian) 2.40
- **Sintaxis:** Intel de 64 bits (`nasm -f elf64`)

## 🛠️ Compilación y ejecución

Para compilar y ejecutar los programas de ejemplo, tienes **dos opciones**:

### ✅ Opción 1: Compilación manual

```bash
# Ensamblar el archivo fuente
nasm -f elf64 archivo.asm -o archivo.o

# Enlazar el archivo objeto
ld archivo.o -o programa

# Ejecutar el programa
./programa
```
### 📜 Opción 2: Script de compilación automática

Se incluye un script `compile.sh` en la raíz del repositorio para facilitar la compilación de los programas.

#### 🚀 Uso del script

🔸 Primero, asegúrate de dar permisos de ejecución al script:
```bash
chmod +x compile.sh
```
🔸 Para compilar cualquier programa, navega a la carpeta correspondiente y ejecuta:
```bash
../compile.sh nombre_del_archivo.asm
```

🔸 Esto ensamblará, enlazará y dejará listo el ejecutable.
Por ejemplo, desde la carpeta resta/:

```
../compile.sh resta.asm
```

## 🎯 Propósito de cada ejercicio

### 1. Resta de Tres Enteros (`resta/`)
**Objetivo:**  
Implementar un programa en ensamblador que realice la operación de resta con tres números enteros utilizando exclusivamente registros de 16 bits.

**Descripción:**
- Opera con valores enteros de 16 bits almacenados en memoria
- Realiza la operación: resultado = n1 - n2 - n3
- Muestra el resultado formateado en la salida estándar
- Incluye conversión de número binario a cadena ASCII para visualización

### 2. Multiplicación de Dos Enteros (`multiplicacion/`)
**Objetivo:**  
Implementar un programa que ejecute la multiplicación de dos números enteros empleando registros de 8 bits.

**Descripción:**
- Utiliza registros de 8 bits para operandos y resultado
- Maneja correctamente el desbordamiento cuando el producto excede 8 bits

### 3. División de Dos Enteros (`division/`)
**Objetivo:**  
Implementar un programa que divida dos números enteros utilizando registros de 32 bits, mostrando tanto el cociente como el residuo.

**Descripción:**
- Opera con valores de 32 bits
- Implementa la división entera mostrando ambos resultados (cociente y residuo)
- Incluye rutinas de conversión numérica para visualización
- Maneja correctamente el registro EDX para divisiones de 32 bits