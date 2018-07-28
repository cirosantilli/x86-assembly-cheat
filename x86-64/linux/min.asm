; Minimal program that exits nicely with exit status 0: just does an exit syscall.
section .text
    global _start
    _start:
        mov rax, 60
        mov rdi, 0
        syscall
