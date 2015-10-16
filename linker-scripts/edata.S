.section .text
    mov $1, %eax
    mov sdata, %ebx
    int $0x80
.section .data
    .byte 1
