; Same as fadd.asm, but with literals in the text section.
;
; To create a constant you need to use the `__float32__` macro.
;
; TODO why? Does not seem possible in gas either:
;
; - http://stackoverflow.com/questions/29925432/nasm-why-must-float32-1-5-be-used-for-floating-point-literals-instead-of-j
; - https://stackoverflow.com/questions/6514537/how-do-i-specify-immediate-floating-point-numbers-with-inline-assembly
; - https://stackoverflow.com/questions/48460385/express-floating-point-constant-from-equ-symbolic-name
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
