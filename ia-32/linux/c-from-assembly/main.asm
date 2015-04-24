extern puts, exit

section .data

    hello_world db "Hello world!", 0

section .text

    ; We must use gcc to link instead of ld because otherwise we won't see the stdlib.
    ; But when we use gcc, the entry point must be called `main` and not `_start`.
    global main
    main:

        push hello_world
        call puts

        mov eax, 0
        call exit
