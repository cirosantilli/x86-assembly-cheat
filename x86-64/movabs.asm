; Most 64 bit instructions cannot take 64-bit immediates, including dereference.
;
; For mov, rax is the only register that accepts it.
;
; movabs is the AT&T name of the special form that accepts 64-bit immediates,
; NASM just uses `mov`.
;
; NASM only gives warnings in case an impossible mov is coded,
; and silently truncates the address.
;
; http://stackoverflow.com/questions/19415184/load-from-a-64-bit-address-into-other-register-than-rax

%include "lib/asm_io.inc"

section .text
    global asm_main
    asm_main:
        ; Eror: dword exceeds bounds.
        ; TODO what is the case where only rax works?
        ; All of the below give the same error.
        ;mov [0x8000_0000_0000_0000], rax
        ;mov [0x8000_0000_0000_0000], rbx
        ;mov rax, [0x8000_0000_0000_0000]
        ;mov rbx, [0x8000_0000_0000_0000]
        mov rax, 0
        ret
