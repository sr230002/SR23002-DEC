; ---------- SECCION DE DATOS ------
section .data
    ; Numeros a multiplicar (8 bits)
    n1 db 13
    n2 db 17
    
    ; Mensajes
    mensaje db "El resultado de la multiplicacion es: "
    long_mensaje equ $ - mensaje

    ; Buffer para 3 digitos (ya se es de 8 bit el maximo seran 3 digitos, es decir 255) + salto de linea
    resultado db '000', 0xA  


; -------- SECCION DE CODIGO --------
section .text
    global _start

_start:
    ; Cargar valores
    xor eax, eax        ; Limpiamos EAX
    mov al, [n1]        ; Carga n1 en AL
    mov bl, [n2]        ; Carga n2 en BL
    
    ; Realizamos la operacion de multiplicacion
    mul bl              ; AX = AL * BL
    
    ; Conversion a ASCII 
    mov rdi, resultado + 2  ; Apunta al ultimo digito
    mov rbx, 10             ; Base 10 para conversion
    
    ; Conversion de digitos
    mov cx, 3           ; 3 digitos a convertir

; Conversion de digitos binarios a ASCII
.convertir:
    xor rdx, rdx        ; Limpia RDX para division
    div bx              ; Divide AX por 10
    add dl, '0'         ; Convierte resto a ASCII
    mov [rdi], dl       ; Almacena digito
    dec rdi             ; Mueve al digito anterior
    loop .convertir     ; Repite para los 3 digitos

    ; Mostrar resultados
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    mov rsi, mensaje        ; Puntero al mensaje
    mov rdx, long_mensaje   ; Longitud del mensaje
    syscall
    
    ; Resultado
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, resultado  ; Puntero al resultado
    mov rdx, 4          ; 3 digitos + salto de linea
    syscall             ; Mostrar resultado
    
    ; Salir
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; Codigo de salida 0
    syscall             ; Salir