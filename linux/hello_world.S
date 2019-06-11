.rodata
    hello_world db "hello world", 10
    hello_world_len equ $ - hello_world
.text
    .global _start
    _start: 
        mov $4, %eax
        mov $1, %ebx
        mov $hello_world, %ecx
        mov $hello_world_len, %edx
        int $0x80
        mov $1, %eax
        mov $0, %ebx
        int $0x80
