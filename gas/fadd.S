/* # Floating point literal. */

#include "lib/common_gas.h"

.data
    float_1_5: .double 1.5
    float_2_5: .double 2.5
    float_4_0: .double 4.0
ENTRY
    fldl float_1_5
    fldl float_2_5
    faddp %st, %st(1)
    fldl float_4_0
    fcomip %st(1)
    ASSERT_FLAG(jz)
EXIT
