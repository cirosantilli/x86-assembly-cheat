# # fild
#
# Convert integer to float and push to st0.

#include <lkmc.h>

.data
    float_10_0 dd 10.0
.bss
    my_float resd 1
LKMC_PROLOGUE
    movl $10, my_float
    fildl my_float
    fldl float_10_0
    fcomip %st(1)
    ASSERT_FLAG je
    finit
LKMC_EPILOGUE
