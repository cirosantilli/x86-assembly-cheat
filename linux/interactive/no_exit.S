# Without the exist system call, the instruction pointer
# just keeps increating until segfault.
.data
    hello_world db "Hello world!", 10
    hello_world_len  equ $ - hello_world
.text
    .global _start
    _start: 
        mov $4, %eax
        mov $1, %ebx
        mov $hello_world, %ecx
        mov $hello_world_len, %edx
        int $0x80
