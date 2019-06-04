; # fld1
;
; Float LoaD 1
;
; Push 1 to st0

#include <lkmc.h>

section .data
    float_1_0 dd 1.0
LKMC_PROLOGUE
    fld1
    ; st0 == 1.0

    fld dword [float_1_0]
    ; st0 == 1.0
    ; st1 == 1.0

    fcomip st1
    ; st0 == 1.0

    ASSERT_FLAG je
LKMC_EPILOGUE
