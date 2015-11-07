global _start
_start:
    sub rsp, 0x7FF000
    mov [rsp], rax
    mov rax, 60
    mov rdi, 0
    syscall
