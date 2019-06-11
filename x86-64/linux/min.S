# Minimal program that exits nicely with exit status 0: just does an exit syscall.
.text
    .global _start
    _start: 
        mov $60, %rax
        mov $0, %rdi
        syscall
