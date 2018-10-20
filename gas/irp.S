/*
# irp

Macro for in loop.

TODO: mnemonic?

See also: .rept
*/

#include "lib/common_gas.h"

ENTRY
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
    ASSERT_EQ($6, %eax)
EXIT
