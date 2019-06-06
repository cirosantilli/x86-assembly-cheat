# # fsqrt
#
# Square root.
#
# st0 = sqrt(st0)

#include <lkmc.h>

.data
    float_1_41 dd 1.41
    float_1_42 dd 1.42
    float_2_0 dd 2.0
    float_4_0 dd 4.0
LKMC_PROLOGUE
    # sqrt(4) == 4
    fldl float_4_0
    fsqrt
    fldl float_2_0
    fcomip %st(1)
    ASSERT_FLAG je

    # 1.41 < sqrt(2) < 1.42
    fsqrt
    fldl float_1_41
    fcomip %st(1)
    ASSERT_FLAG jbe
    fldl float_1_42
    fcomip %st(1)
    ASSERT_FLAG jae
LKMC_EPILOGUE
