%define _exit exit
%define _printf printf
extern _printf, _exit

segment .data
long_format db "%ld", 10, 0
segment .text
; TODO restore registers.
global print_long
print_long:
    sub rsp, 8
    mov rsi, rax
    mov rdi, long_format
    mov rax, 1
    call _printf
    add rsp, 8
    ret

; TODO restore registers.
segment .data
string_format db "%s", 10, 0
segment .text
global print_string
print_string:
    sub rsp, 8
    mov rsi, rax
    mov rdi, string_format
    mov rax, 1
    call _printf
    add rsp, 8
    ret

section .data
assert_fail_str db 10, 'ASSERT FAILED AT LINE: ', 0
section .text
global assert_fail
assert_fail:
    sub rsp, 8
    mov rbx, rax
    mov rax, assert_fail_str
    call print_string
    mov rax, rbx
    call print_long

    ; Call libc exit with exit status 1:
    mov rdi, 1
    call _exit
