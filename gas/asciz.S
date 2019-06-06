/*
# asciz

    Like `.ascii` but adds null char to string

    Same as:

        .ascii "assert failed\n\x00"
        .ascii "assert failed\n\000"
*/

#include "lib/common_gas.h"

.data
s:
    .asciz "abc"
    s_len = . - s
cat:
    .asciz "a" "b"

LKMC_PROLOGUE
    mov s, %eax
    LKMC_ASSERT_EQ_32(%eax, $0x00636261)

    /*
    Concatenates literals somewhat like C does,
    BUT adds a null after each one.
    */
    mov cat, %eax
    LKMC_ASSERT_EQ_32(%eax, $0x00620061)

    mov $s_len, %eax
    LKMC_ASSERT_EQ_32(%eax, $4)
LKMC_EPILOGUE
