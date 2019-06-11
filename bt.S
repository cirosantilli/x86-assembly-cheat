# # BT

    # Bit test.

        # bt ax, i
        # CF = ( ax[i] == 1 ) ? 1 : 0

#include <lkmc.h>

LKMC_PROLOGUE
    mov $0x0A, %ax

    btw $0, %ax
    ASSERT_FLAG jnc

    btw $1, %ax
    ASSERT_FLAG jc

    btw $2, %ax
    ASSERT_FLAG jnc

    btw $3, %ax
    ASSERT_FLAG jc

    # Unchanged
    LKMC_ASSERT_EQ_32(%ax, $0x0A)

    # Not for bytes
    #bt al, 0

LKMC_EPILOGUE
