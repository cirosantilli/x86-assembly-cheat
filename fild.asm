; # fild
;
; Convert integer to float and push to st0.

#include <lkmc.h>

section .data
    float_10_0 dd 10.0
section .bss
    my_float resd 1
LKMC_PROLOGUE
    mov dword [my_float], 10
    fild dword [my_float]
    fld dword [float_10_0]
    fcomip st1
    ASSERT_FLAG je
    finit
LKMC_EPILOGUE
