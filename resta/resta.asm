; Ejercicio #2: Escriba un programa para 
; multiplicar dos números enteros, usando registros de 8 bits.

; ---------- SECCION DE DATOS ------
section .data
    ; Definimos las variables (de 16 bits) en decimal
    n1 dw 2025                      ; numero #1 con valor de 2025
    n2 dw 519                       ; numero #2 con valor de 519
    n3 dw 825                       ; numero #3 con valor de 825
    
    ; Definimos el mensaje que se mostrara en la consola
    mensaje db "Resultado de la resta: 2025 - 519 - 825 = "
    ; Calculamos la longitud del mensaje de forma automatica
    mensaje_len equ $ - mensaje
    
    ; Reservamos el espacio para guardar el resultado como texto
    resultado times 6 db 0  
    
    ; salto de linea para la consola
    newline db 0xA

; -------- SECCION DE CODIGO --------
section .text
    global _start                   ; Punto de entrada del ejecutable (sistema)

_start:
    ; Limpiamos los registros
    xor rax, rax                    ; RAX = 0
    xor rbx, rbx                    ; RBX = 0
    xor rcx, rcx                    ; RCX = 0
    
    ; Cargamos los numeros de 16 bits en los registros
    mov ax, [n1]                    ; AX = 2025
    mov bx, [n2]                    ; BX = 519 
    mov cx, [n3]                    ; CX = 825 
    
    ; Realizamos la operacion de resta (n1 - n2 - n3)
    sub ax, bx                      ; AX = AX - BX (2025 - 519)
    sub ax, cx                      ; AX = AX - CX (resultado anterior(1506) - 825)
    
    ; Preparamos para convertir el numero a texto (Mostrar el resultado)
    mov rdi, resultado              ; RDI apunta a donde guardaremos el texto
    
    ; Llamamos a la rutina de conversion
    call convertir_int_to_string
    
    ; Mostramos el mensaje inicial
    mov rax, 1                      ; sys_write
    mov rdi, 1                      ; stdout
    mov rsi, mensaje                    ; Puntero al mensaje
    mov rdx, mensaje_len                ; Longitud del mensaje
    syscall                         ; Llamada al sistema
    
    ; Mostramos el resultado numerico
    mov rax, 1                      ; sys_write
    mov rdi, 1                      ; stdout
    mov rsi, resultado              ; Puntero al resultado
    mov rdx, 5                      ; Mostrar hasta 5 digitos
    syscall
    
    ; Mostramos un salto de linea, para que el resultado del programa realice un salto de linea al final
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    
    ; Salimos del programa
    mov rax, 60                     ; sys_exit
    xor rdi, rdi                    ; Codigo de salida (0 = sin errores)
    syscall


; Convierte el numero en AX a texto y lo guarda donde apunta RDI
convertir_int_to_string:
    push rbx                        ; Guardamos RBX (lo usaremos para la base)
    push rcx                        ; Guardamos RCX (contador de digitos)
    push rdx                        ; Guardamos RDX (para la division)
    
    mov rbx, 10                     ; Base 10 para la conversion
    xor rcx, rcx                    ; Iniciamos contador de digitos
    
    ; Caso especial si el numero es 0
    cmp ax, 0
    jne .convertir                  ; Si no es cero, saltamos a convertir
    
    ; Si es cero, lo manejamos directamente
    mov byte [rdi], '0'
    inc rdi                         ; Movemos el puntero
    jmp .fin                        ; Saltamos al final
    
.convertir:
    xor rdx, rdx                    ; Limpiamos RDX para la division
    div bx                          ; Dividimos AX por 10 (BX=10)
                                    ; AX = cociente, DX = resto
    
    add dl, '0'                     ; Convertimos el resto a caracter ASCII
    push dx                         ; Guardamos el digito en la pila
    inc cx                          ; Incrementamos el contador de digitos
    
    test ax, ax                     ; ¿AX es cero?
    jnz .convertir                  ; Si no es cero, seguimos convirtiendo  

; Extraemos los digitos de la pila
.extraer:
    pop dx                          ; Recuperamos un digito
    mov [rdi], dl                   ; Lo guardamos en el buffer
    inc rdi                         ; Movemos el puntero
    loop .extraer                   ; Repetimos para todos los digitos
    
.fin:
    mov byte [rdi], 0               ; Añadimos terminador nulo
    pop rdx                         ; Restauramos registros
    pop rcx
    pop rbx
    ret                             ; Volvemos al punto donde nos llamaron