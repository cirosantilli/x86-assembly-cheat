.data
s:
    .ascii "hello world\n"
    len = . - s
.text
.global _start
_start:
    /* write */
    mov $4, %eax
    mov $1, %ebx
    mov $s, %ecx
    mov $len, %edx
    int $0x80

    /* exit */
    mov $1, %eax
    mov $0, %ebx
    int $0x80
