; movabs is the AT&T syntax for moving 64-bit immediates into registers.
; It is encoded differently from 32-bit moves.

%include "lib/asm_io.inc"

section .text
    global asm_main
    asm_main:

        ; mov
        mov rax, 1
        call print_long

        ; movabs
        mov rax, 0x1000_0000_0000_0000
        call print_long

        mov rbx, 1
        mov rax, rbx
        call print_long

        ; movabs. TODO shouldn't this fail?
        ; http://stackoverflow.com/questions/19415184/load-from-a-64-bit-address-into-other-register-than-rax
        mov rbx, 0x1000_0000_0000_0000
        mov rax, rbx
        call print_long

        mov rax, 0
        ret
