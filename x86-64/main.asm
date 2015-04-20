section .data

    hello_world db "Hello world!", 10
    hello_world_len  equ $ - hello_world

section .text

    global _start

_start:

    ; # Registers

        ; General purpose registers got longer versions,
        ; and 8 new ones were extended: r8 through r15.

            mov rax, 0xFFFFFFFFFFFFFFFF
            mov rbx, 0xFFFFFFFFFFFFFFFF
            mov rcx, 0xFFFFFFFFFFFFFFFF
            mov rdx, 0xFFFFFFFFFFFFFFFF
            mov rsi, 0xFFFFFFFFFFFFFFFF
            mov rdi, 0xFFFFFFFFFFFFFFFF
            ;mov ebp, 0xFFFFFFFFFFFFFFFF
            ;mov esp, 0xFFFFFFFFFFFFFFFF
            mov r8,  0xFFFFFFFFFFFFFFFF
            mov r9,  0xFFFFFFFFFFFFFFFF
            mov r15, 0xFFFFFFFFFFFFFFFF

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
