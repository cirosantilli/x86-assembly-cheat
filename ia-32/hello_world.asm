; Minimal example using the C driver.

%include "lib/asm_io.inc"

section .data

    hello_world db "Hello world!", 10

section .text

global asm_main
asm_main:

    mov  eax, hello_world
    call print_string

    mov eax, 0
    leave
    ret
