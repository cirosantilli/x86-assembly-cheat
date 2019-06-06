.rodata
    hello_world db "hello world", 10
    hello_world_len equ $ - hello_world
.text
    .global _start
    _start: 
        movl $4, %eax
        movl $1, %ebx
        movl $hello_world, %ecx
        movl $hello_world_len, %edx
        int $0x80
        movl $1, %eax
        movl $0, %ebx
        int $0x80
