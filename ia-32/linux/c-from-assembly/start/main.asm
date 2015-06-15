extern puts, exit
section .data
    hello_world db "Hello world!", 0
section .text
    global _start
    _start:
        push hello_world
        call puts
        pop eax
        push 0
        call exit
