section .data

    hello_world db "Hello world!", 10
    hello_world_len  equ $ - hello_world

section .text

    global _start
    _start:

        ; # syscall

            ; Custom system call instruction added.

            ; Preferred way over int, may be faster.

            ; Used by Linux.

            ; Will not be further commented here as OS specific.

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

        ; # PUSHA

        ; # POPA

            ; `PUSHA` and `POPA` were removed from x86-64:
            ; <http://stackoverflow.com/questions/6837392/how-to-save-the-registers-on-x86-64-for-an-interrupt-service-routine>

                ; ERROR
                ;pusha
                ;popa

        ; # pop only works with quadwords

            ; Some instructions do not work with operand sizes for which they work in 32 bit mode.
            ; E.g., you cannot do `pop eax`, only `pop rax`.

                ; ERROR
                ;pop eax

        mov rax, 1
        mov rdi, 1
        mov rsi, hello_world
        mov rdx, hello_world_len
        syscall

        mov rax, 60
        mov rdi, 0
        syscall
