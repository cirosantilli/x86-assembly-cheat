extern puts, exit
section .data
    hello_world db "hello world", 0
section .text
    global main
    main:
        ; Required to align the stack to 16 bytes
        ; after call puts an 8 byte address there.
        sub rsp, 8

        mov rdi, hello_world
        call puts

        mov rdi, 0
        call exit
