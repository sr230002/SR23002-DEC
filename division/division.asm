; Ejercicio #3: Escriba un programa para 
; dividir dos números enteros, usando registros de 32 bits.

section .data
    ;  definirmos las variables a usar  (32 bits)
    dividendo dd 550       ; Numero a dividir
    divisor dd 3           ; Divisor
    
    ; Mensajes para mostrar
    mensaje db "El resultado de la division es: "
    long_mensaje equ $ - mensaje
    
    ; Buffers para conversion a texto
    cociente_str db '          ',0xA  ; 10 espacios + salto de linea
    residuo_msg db "Residuo: "
    long_residuo_msg equ $ - residuo_msg
    residuo_str db '          ',0xA   ; 10 espacios + salto de linea

section .text
    global _start

_start:
    ; ** PASO 1: Realizar la division (32 bits en modo 64) **
    mov eax, [dividendo]   ; Cargar dividendo
    xor edx, edx           ; Limpiar EDX para division sin signo
    div dword [divisor]    ; EAX = cociente, EDX = residuo
    
    ; ** PASO 2: Convertir cociente a texto **
    mov rdi, cociente_str + 3   ; Apuntar al final del buffer
    mov byte [rdi], 0           ; Terminador nulo
    call convertir_a_texto      ; Convertir EAX a string
    
    ; ** PASO 3: Convertir residuo a texto **
    mov eax, edx                ; Mover residuo a EAX
    mov rdi, residuo_str + 3    ; Apuntar al final del buffer
    mov byte [rdi], 0xA         ; Salto de linea al final
    call convertir_a_texto      ; Convertir EAX a string
    
    ; ** PASO 4: Mostrar resultados **
    ; Mostrar mensaje principal
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    mov rsi, mensaje        ; Puntero al mensaje
    mov rdx, long_mensaje   ; Longitud del mensaje
    syscall                 ; Mostrar mensaje
    
    ; Mostrar cociente
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    mov rsi, cociente_str   ; Puntero al resultado
    mov rdx, 11             ; 10 digitos + salto de linea
    syscall                 ; Mostrar resultado
    
    ; Mostrar mensaje de residuo
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    mov rsi, residuo_msg        ; Puntero al mensaje
    mov rdx, long_residuo_msg   ; Longitud del mensaje
    syscall                     ; Mostrar mensaje
    
    ; Mostrar valor del residuo
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    mov rsi, residuo_str        ; Puntero al resultado
    mov rdx, 4                  ; 3 digitos + salto de linea
    syscall                     ; Mostrar resultado
    
    
    ; ** PASO 5: Salir del programa **
    mov rax, 60             ; sys_exit
    xor rdi, rdi            ; Codigo de salida 0
    syscall

; ----------------------------------------------------------
; Rutina: convertir_a_texto
; Convierte numero en EAX a string ASCII
; Entrada:
;   EAX = numero a convertir
;   RDI = puntero al final del buffer destino
; ----------------------------------------------------------
convertir_a_texto:
    push rbx                ; Guardar registros usados
    push rcx
    
    mov rbx, 10             ; Base 10 para conversion
    mov ecx, eax            ; Copiar numero a ECX
    
.convertir:
    xor edx, edx            ; Limpiar EDX para division
    div ebx                 ; Dividir EAX por 10
    add dl, '0'             ; Convertir resto a ASCII
    dec rdi                 ; Retroceder puntero
    mov [rdi], dl           ; Almacenar digito
    test eax, eax           ; Verificar si queda algo
    jnz .convertir          ; Continuar si no es cero
    
    pop rcx                 ; Restaurar registros
    pop rbx                 ; Restaurar registros
    ret                     ; Regresa de la subrutina