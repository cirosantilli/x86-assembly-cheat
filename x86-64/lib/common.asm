; System V calling convention used for all functions.

%define _exit exit
%define _printf printf
extern _printf, _exit

segment .text

global print_long
print_long:
    sub rsp, 8
    mov rsi, rdi
    mov rdi, .format
    mov rax, 1
    call _printf
    add rsp, 8
    ret
.format db "%ld", 10, 0

global print_long_hex
print_long_hex:
    sub rsp, 8
    mov rsi, rdi
    mov rdi, .format
    mov rax, 1
    call _printf
    add rsp, 8
    ret
.format db "%lx", 10, 0

global print_string
print_string:
    sub rsp, 8
    mov rsi, rdi
    mov rdi, .format
    mov rax, 1
    call _printf
    add rsp, 8
    ret
.format db "%s", 10, 0

global assert_fail
assert_fail:
    sub rsp, 8
    mov rbx, rdi
    mov rdi, .message
    call print_string
    mov rdi, rbx
    call print_long

    ; Call libc exit with exit status 1.
    mov rdi, 1
    call _exit
.message db 10, 'ASSERT FAILED AT LINE: ', 0
