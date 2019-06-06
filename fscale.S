# # fscale
#
# st0 = st0 * 2 ^ RoundTowardZero(st1)

#include <lkmc.h>

.data
    float_1_0 dd 1.0
    float_2_5 dd 2.5
    float_4_0 dd 4.0
LKMC_PROLOGUE
    fldl float_4_0
    # st0 = 4.0

    fldl float_2_5
    # st0 = 2.5
    # st1 = 4.0

    fldl float_1_0
    # st0 = 1.0
    # st1 = 2.5
    # st2 = 4.0

    # st0 = 1 * 2 ^ (2) == 4
    fscale
    # st0 = 4.0
    # st1 = 2.5
    # st2 = 4.0

    fcomip %st(2)
    # st0 = 4.0
    # st1 = 2.5

    ASSERT_FLAG je
LKMC_EPILOGUE
