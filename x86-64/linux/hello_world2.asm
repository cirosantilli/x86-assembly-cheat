section .data
    hello_world db "Hello world!", 10
    hello_world_len equ $ - hello_world
    hello_world2 db "Hello world 2!", 10
    hello_world2_len equ $ - hello_world2
section .text
    global _start
    _start:
        mov rax, 1
        mov rdi, 1
        mov rsi, hello_world
        mov rdx, hello_world_len
        syscall
        mov rax, 1
        mov rdi, 1
        mov rsi, hello_world2
        mov rdx, hello_world2_len
        syscall
        mov rax, 60
        mov rdi, 0
        syscall
