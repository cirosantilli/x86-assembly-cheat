; # fild
;
; Convert integer to float and push to st0.

%include "lib/common_nasm.inc"

section .data
    float_10_0 dd 10.0
section .bss
    my_float resd 1
ENTRY
    mov dword [my_float], 10
    fild dword [my_float]
    fld dword [float_10_0]
    fcomip st1
    ASSERT_FLAG je
    finit
EXIT
