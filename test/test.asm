section .data
    mensaje db "Hello, World!", 0xA   ; El mensaje y salto de línea
    len_mensaje equ $ - mensaje       ; Longitud del mensaje

section .text
    global _start

_start:
    ; sys_write (escribir en pantalla)
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, mensaje    ; puntero al mensaje
    mov rdx, len_mensaje; longitud del mensaje
    syscall             ; invocar syscall

    ; sys_exit (salida limpia)
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; código de salida = 0
    syscall             ; invocar syscall
