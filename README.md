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


