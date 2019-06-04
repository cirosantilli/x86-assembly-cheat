; # fchs
;
; Change Sign.
;
; st0 *= -1

#include <lkmc.h>

section .data
    float_minus_1 dd -1.0
    float_1 dd 1.0
LKMC_PROLOGUE
    ; -(1) == -1
    fld dword [float_1]
    fchs
    fld dword[float_minus_1]
    fcomip st1
    ASSERT_FLAG je

    ; -(-1) == 1
    fchs
    fld dword [float_1]
    ASSERT_FLAG je
    finit
LKMC_EPILOGUE
