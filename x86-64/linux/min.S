# Minimal program that exits nicely with exit status 0: just does an exit syscall.
.text
    .global _start
    _start: 
        movq $60,%rax
        movq $0,%rdi
        syscall
