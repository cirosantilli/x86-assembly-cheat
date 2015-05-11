; See what `rsp` is worth at initialization.
;
; Similar to IA-32, except that this time we are at around 2^48 = 256 TiB.
%macro print_rsp 0
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    bswap rsi
    mov [resq0], rsi
    mov rsi, resq0
    mov rdx, 8
    syscall
%endmacro

section .bss

    resq0 resq 1

section .text

    global _start
    _start:

        print_rsp
        push 1
        print_rsp

        mov rax, 60
        mov rdi, 0
        syscall
