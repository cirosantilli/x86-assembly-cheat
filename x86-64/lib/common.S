# System V calling convention used for all functions.

extern printf, exit

.text

.global print_long
print_long: 
    subq $8, %rsp
    mov %rdi, %rsi
    mov $.format, %rdi
    mov $1, %rax
    call printf
    addq $8, %rsp
    ret
.format db "%ld", 10, 0

.global print_string
print_string: 
    subq $8, %rsp
    mov %rdi, %rsi
    mov $.format, %rdi
    mov $1, %rax
    call printf
    addq $8, %rsp
    ret
.format db "%s", 10, 0

.global assert_fail
assert_fail: 
    subq $8, %rsp
    mov %rdi, %rbx
    mov $.message, %rdi
    call print_string
    mov %rbx, %rdi
    call print_long

    # Call libc exit with exit status 1.
    mov $1, %rdi
    call exit
.message db 10, 'ASSERT FAILED AT LINE: ', 0
