# # faddp
#
# st0 = st0 + st1
# pop st0
#
# P means Pop st0.
#
# It is present in many instructions, 
# e.g. here we use it in fcompiP.

#include <lkmc.h>

.data
    float_1_5 dd 1.5
    float_2_5 dd 2.5
    float_4_0 dd 4.0
LKMC_PROLOGUE
    # Load to the FPU stack.
    # Push value from memory to the FPU stack.
    fldl float_1_5
    # FPU stack after operation:
    # st0 == 1.5

    fldl float_2_5
    # FPU stack after operation:
    # st0 == 2.5
    # st1 == 1.5

    # st0 = st0 + st1
    # P means Pop st0.
    faddp %st, %st(1)
    # FPU stack after operation:
    # st0 == 4.0

    fldl float_4_0
    # FPU stack after operation:
    # st0 == 4.0
    # st1 == 4.0

    # st0 == st1
    # Pop st0.
    fcomip %st(1)
    # FPU stack after operation:
    # st0 == 4.0
    ASSERT_FLAG je
LKMC_EPILOGUE
