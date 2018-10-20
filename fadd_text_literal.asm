; Same as fadd.asm, but with literals in the text section.
;
; To create a constant you need to use the `__float32__` macro.
;
; TODO why? http://stackoverflow.com/questions/29925432/nasm-why-must-float32-1-5-be-used-for-floating-point-literals-instead-of-j
;
; E.g. this fails:
;
;     mov eax, 1.5

%include "lib/common_nasm.inc"

section .data
    my_float resd 1
ENTRY
    mov dword [my_float], __float32__(1.5)
    fld dword [my_float]
    mov dword [my_float], __float32__(2.5)
    fld dword [my_float]
    faddp st1, st0
    mov dword [my_float], __float32__(4.0)
    fld dword [my_float]
    fcomip st1
    ASSERT_FLAG je
EXIT
