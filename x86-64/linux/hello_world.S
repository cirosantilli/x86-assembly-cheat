.global _start
_start: 
    # Write.
    mov $1, %rax
    mov $1, %rdi
    mov $hello_world, %rsi
    mov $hello_world_len, %rdx
    syscall

    # Exit.
    mov $60, %rax
    mov $0, %rdi
    syscall

hello_world db "hello world", 10
hello_world_len equ $ - hello_world
