section .data

    hello_world db "Hello world!", 10
    hello_world_len  equ $ - hello_world

section .text

    global _start

_start:

    ; write
    mov eax, 4
    mov ebx, 1
    mov ecx, hello_world
    mov edx, hello_world_len
    int 80h

    ; exit
    mov eax, 1
    mov ebx, 0
    int 0x80
