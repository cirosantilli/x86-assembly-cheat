%define _printf printf
extern _printf

segment .data

    long_format db "%ld", 10, 0
    string_format db "%s", 10, 0

segment .text

    ; TODO restore registers.
    global print_long
    print_long:
        mov rsi, rax
        mov rdi, long_format
        call _printf
        ret

    ; TODO restore registers.
    global print_string
    print_string:
        mov rsi, rax
        mov rdi, string_format
        call _printf
        ret
