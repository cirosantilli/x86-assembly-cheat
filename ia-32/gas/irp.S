/*
# irp

Macro for in loop.

TODO: mnemonic?
*/

#include "lib/asm_io_s.h"

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
    ASSERT_EQ($6)
    EXIT
