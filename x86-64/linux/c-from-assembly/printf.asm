; printf is a bit harder as it requires varargs.
extern printf, exit
section .data
    hello_world db "hello world", 0
    string_format db "%s", 10, 0
section .text
    global main
    main:
        sub rsp, 8
        mov rsi, hello_world
        mov rdi, string_format
        mov rax, 1
        call printf
        mov rdi, 0
        call exit
