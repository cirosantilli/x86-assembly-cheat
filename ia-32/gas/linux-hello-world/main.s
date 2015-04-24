.data

    s:
        .ascii "Hello world!\n"
        len = . - s

.global _start
_start:

    movl $4, %eax
    movl $1, %ebx
    movl $s, %ecx
    movl $len, %edx
    int $0x80

    movl $1, %eax
    movl $0, %ebx
    int $0x80
