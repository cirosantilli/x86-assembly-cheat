/*
# irp

Macro for in loop.

TODO: mnemonic?

See also: .rept
*/

#include "lib/common_gas.h"

LKMC_PROLOGUE
    mov $0, %eax
    /*
    Generate:

        add $3, %eax
        add $1, %eax
        add $2, %eax
    */
    .irp i, 3, 1, 2
        add $\i, %eax
    .endr
    LKMC_ASSERT_EQ(%eax, $6)
LKMC_EPILOGUE
