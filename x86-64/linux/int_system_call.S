.text
    .global _start
    _start: 
        movl $1,%eax
        movl $0,%ebx
        int $0x80
