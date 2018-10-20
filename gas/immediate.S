/*
# Immediate

# $

# Dollar sign
*/

#include "lib/common_gas.h"

.data

    symbol: .long 1

ENTRY
    /*
    Immediates require `$`.
    */
    mov $1, %eax
    ASSERT_EQ($1, %eax)

    mov $-1, %eax
    ASSERT_EQ($-1, %eax)

    /*
    Without `$`, the data at given address is understood. Segfault:
    */
    /*PRINT_INT(1)*/

    /*
    The same goes for symbol and label addresses: `$` indicates the address,
    and its absence dereferences automatically.
    */

        mov symbol, %eax
        ASSERT_EQ($1, %eax)

        mov $symbol, %ebx
        mov (%ebx), %eax
        ASSERT_EQ($1, %eax)

        1:
        nop
        2:

        mov $0, %eax
        mov 1b, %al
        /* Encoding of NOP. */
        ASSERT_EQ($0x90, %eax)

        1:
        nop
        2:

        mov $2b, %eax
        sub $1b, %eax
        ASSERT_EQ($1, %eax)

    /*
    Jump instructions however break the rule: you don't need `$` for the actual address.

    To do that you need indirect jmp addressing.
    */

        jmp 1f
        ASSERT_FAIL
        1:

EXIT
