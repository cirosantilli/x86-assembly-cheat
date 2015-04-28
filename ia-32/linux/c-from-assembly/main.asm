extern puts, exit
section .data
    hello_world db "Hello world!", 0
section .text
    ; When we use gcc, the entry point must be called `main` and not `_start`.
    global main
    main:
        push hello_world
        ; We must use gcc to link instead of ld because otherwise we won't see the stdlib.
        call puts
        pop eax

        push 0
        call exit
