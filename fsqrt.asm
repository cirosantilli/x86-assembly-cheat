; # fsqrt
;
; Square root.
;
; st0 = sqrt(st0)

%include "lib/common_nasm.inc"

section .data
    float_1_41 dd 1.41
    float_1_42 dd 1.42
    float_2_0 dd 2.0
    float_4_0 dd 4.0
ENTRY
    ; sqrt(4) == 4
    fld dword [float_4_0]
    fsqrt
    fld dword [float_2_0]
    fcomip st1
    ASSERT_FLAG je

    ; 1.41 < sqrt(2) < 1.42
    fsqrt
    fld dword [float_1_41]
    fcomip st1
    ASSERT_FLAG jbe
    fld dword [float_1_42]
    fcomip st1
    ASSERT_FLAG jae
EXIT
