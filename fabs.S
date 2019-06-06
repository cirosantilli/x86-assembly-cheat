# # fabs
#
# Absolute value.
#
# st0 = |st0|


#include <lkmc.h>

.data
    float_minus_1_0 dd -1.0
    float_1_0 dd 1.0
LKMC_PROLOGUE
    # |-1| == 1
    fldl float_minus_1_0
    fabs
    fldl float_1_0
    fcomip %st(1)
    ASSERT_FLAG je
    finit

    # |1| == 1
    fldl float_1_0
    fabs
    fldl float_1_0
    fcomip %st(1)
    ASSERT_FLAG je
    finit
LKMC_EPILOGUE
