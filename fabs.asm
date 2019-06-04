; # fabs
;
; Absolute value.
;
; st0 = |st0|


#include <lkmc.h>

section .data
    float_minus_1_0 dd -1.0
    float_1_0 dd 1.0
LKMC_PROLOGUE
    ; |-1| == 1
    fld dword [float_minus_1_0]
    fabs
    fld dword[float_1_0]
    fcomip st1
    ASSERT_FLAG je
    finit

    ; |1| == 1
    fld dword [float_1_0]
    fabs
    fld dword[float_1_0]
    fcomip st1
    ASSERT_FLAG je
    finit
LKMC_EPILOGUE
