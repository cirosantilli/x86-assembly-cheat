.global _start
_start: 
    # Write.
    movq $1,%rax
    movq $1,%rdi
    movq $hello_world, %rsi
    movq $hello_world_len, %rdx
    syscall

    # Exit.
    movq $60,%rax
    movq $0,%rdi
    syscall

hello_world db "hello world", 10
hello_world_len equ $ - hello_world
