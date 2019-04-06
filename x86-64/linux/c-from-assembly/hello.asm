default rel
extern puts
section .rodata
    message db "hello", 0
section .text
global main
main:
    sub rsp, 8
    lea rdi, [rel message]
    call puts
    xor eax, eax
    add rsp, 8
    ret
