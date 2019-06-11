# # btr

    # BT + reset.

#include <lkmc.h>

LKMC_PROLOGUE
    mov $0x0A, %ax
    btrw $1, %ax
    LKMC_ASSERT_EQ_32(%ax, $8)
    ASSERT_FLAG jc
LKMC_EPILOGUE
