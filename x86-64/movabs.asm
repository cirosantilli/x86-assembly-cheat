; TODO review this, it is a mess.
;
; Most instructions cannot deal with 64-bit addresses:
; they simply use 32 bits bytes and *sign* extend to 64 bits.
;
; http://stackoverflow.com/questions/33318342/when-is-it-better-for-an-assembler-to-use-sign-extended-relocation-like-r-x86-64
; http://stackoverflow.com/questions/3623899/nasm-64-bit-immediate-address-for-movlps-gives-dword-data-exceeds-bounds
; https://reverseengineering.stackexchange.com/questions/2627/what-is-the-meaning-of-movabs-in-gas-x86-att-syntax
;
; For mov, rax is the only register that accepts it.
; TODO see other instructions.
;
; I think this is encoded as `MOV moffs64*,RAX`. TODO better understand the `moffs` thing.
;
; movabs is the AT&T name of the special form that accepts 64-bit immediates.
;
; Intel just puts it under MOV, and NASM just uses `mov`.
;
; NASM only gives warnings in case an impossible mov is coded,
; and silently truncates the address.
;
; http://stackoverflow.com/questions/19415184/load-from-a-64-bit-address-into-other-register-than-rax

%include "lib/common_nasm.inc"

ENTRY
    ; TODO what is the case where only rax works?
    ; All of the below give the same error.
    ; Error: dword exceeds bounds.
    ;mov [0x8000_0000_0000_0000], rax
    ;mov [0x8000_0000_0000_0000], rbx
    ;mov rax, [0x8000_0000_0000_0000]
    ;mov rbx, [0x8000_0000_0000_0000]

    ; These assemble. TODO create a minimal example well defined example that does
    ; not access random memory addresses.
    ; mov rax, 0x8000_0000_0000_0000
    ; mov qword [rax], rbx
    ; mov rbx, 0x8000_0000_0000_0000
    ; mov qword [rbx], rcx

EXIT
