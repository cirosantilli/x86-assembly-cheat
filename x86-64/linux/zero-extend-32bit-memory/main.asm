section .text
global _start
_start:

    ; This mov gets the 64-bit address truncated to 32-bits.
    ; The CPU sign extends it.
    mov byte al, 0xFFFFFFFF80000000
    mov [output], al

    mov rax, 1
    mov rdi, 1
    mov rsi, output
    mov rdx, 1
    syscall

    ; TODO do another move with the full explicit 64-bit address.
    ; Should give the same output.
    mov byte al, 0xFFFFFFFF80000000
    mov [output], al

    mov rax, 1
    mov rdi, 1
    mov rsi, output
    mov rdx, 1
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
section .data
    output:
        db 'a'
section .data2
    input:
        db 'b'

