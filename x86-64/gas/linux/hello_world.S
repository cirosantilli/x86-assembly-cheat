.data
hello_world:
    .ascii "hello world\n"
    hello_world_len = . - hello_world
.text
.global _start
_start:
    /* write */
    mov $1, %rax
    mov $1, %rdi
    mov $hello_world, %rsi
    mov $hello_world_len, %rdx
    syscall

    /* exit */
    mov $60, %rax
    mov $0, %rdi
    syscall
