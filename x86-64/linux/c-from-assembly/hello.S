default rel
.extern puts
.rodata
    message db "hello", 0
.text
.global main
main: 
    subq $8,%rsp
    lea rdi, [rel message]
    call puts
    xorl %eax,%eax
    addq $8,%rsp
    ret
