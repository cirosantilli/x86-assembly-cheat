extern puts, exit
section .data
    hello_world db "hello world", 0
section .text
    global main
    main:
        push hello_world
        call puts
        pop eax

        push 0
        call exit
