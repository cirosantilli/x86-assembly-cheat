; # fldz
;
; Float LoaD Zero
;
; Push 0 to st0

%include "lib/common_nasm.inc"

section .data
    float_0_0 dd 0.0
ENTRY
    fldz
    ; st0 == 0.0

    fld dword [float_0_0]
    ; st0 == 0.0
    ; st1 == 0.0

    fcomip st1
    ; st0 == 0.0

    ASSERT_FLAG je
EXIT
