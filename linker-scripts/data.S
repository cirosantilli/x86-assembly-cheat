.section .text
    movb $0, x
    mov $1, %eax
    mov $0, %ebx
    mov x, %bl
    int $0x80
.section .data
    x: .byte 1
