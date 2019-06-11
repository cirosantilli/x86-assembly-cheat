.text
.global _start
_start: 
    mov $1, %eax
    mov $0, %ebx
    int $0x80
