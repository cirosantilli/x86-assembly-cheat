/*
# Immediate

# $

# Dollar sign
*/

#include "lib/common_gas.h"

.data

    symbol: .long 1

LKMC_PROLOGUE
    /*
    Immediates require `$`.
    */
    mov $1, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)

    mov $-1, %eax
    LKMC_ASSERT_EQ_32(%eax, $-1)

    /*
    Without `$`, the data at given address is understood. Segfault:
    */
    /*PRINT_INT(1)*/

    /*
    The same goes for symbol and label addresses: `$` indicates the address,
    and its absence dereferences automatically.
    */

        mov symbol, %eax
        LKMC_ASSERT_EQ_32(%eax, $1)

        mov $symbol, %ebx
        mov (%ebx), %eax
        LKMC_ASSERT_EQ_32(%eax, $1)

        1:
        nop
        2:

        mov $0, %eax
        mov 1b, %al
        /* Encoding of NOP. */
        LKMC_ASSERT_EQ_32(%eax, $0x90)

        1:
        nop
        2:

        mov $2b, %eax
        sub $1b, %eax
        LKMC_ASSERT_EQ_32(%eax, $1)

    /*
    Jump instructions however break the rule: you don't need `$` for the actual address.

    To do that you need indirect jmp addressing.
    */

        jmp 1f
        ASSERT_FAIL
        1:

LKMC_EPILOGUE
