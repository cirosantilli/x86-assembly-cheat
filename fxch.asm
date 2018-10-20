; # fxch
;
; Swap st0 and another register.

%include "lib/common_nasm.inc"

section .data
    float_0_0 dd 0.0
    float_1_0 dd 1.0
ENTRY
    fldz
    ; st0 = 0.0

    fld1
    ; st0 = 1.0
    ; st1 = 0.0

    fxch st1
    ; st0 = 0.0
    ; st1 = 1.0
    fldz
    ; st0 = 0.0
    ; st1 = 0.0
    ; st2 = 1.0
    fcomip st1
    ; st0 = 0.0
    ; st1 = 1.0
    ASSERT_FLAG je

    fxch st1
    ; st0 = 1.0
    ; st1 = 0.0
    fld1
    ; st0 = 1.0
    ; st1 = 1.0
    ; st2 = 0.0
    fcomip st1
    ; st0 = 1.0
    ; st1 = 0.0
    ASSERT_FLAG je
EXIT
