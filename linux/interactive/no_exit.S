# Without the exist system call, the instruction pointer
# just keeps increating until segfault.
.data
    hello_world db "Hello world!", 10
    hello_world_len  equ $ - hello_world
.text
    .global _start
    _start: 
        movl $4,%eax
        movl $1,%ebx
        movl $hello_world, %ecx
        movl $hello_world_len, %edx
        int $0x80
