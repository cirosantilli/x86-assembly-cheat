/*
# movz

# movs

    Intel `movzx` and `movsx`.

    Can add suffixes of form:

        bl
        bw
        wl

    to mean that it is from byte to long, or word to long.
*/

#include "lib/common_gas.h"

LKMC_PROLOGUE
    mov $0x01234567, %eax
    mov $1, %bl
    movzbl %bl, %eax
    LKMC_ASSERT_EQ(%eax, $1)

    mov $0x01234567, %eax
    mov $-1, %bl
    movzbl %bl, %eax
    LKMC_ASSERT_EQ(%eax, $0xFF)

    /* Can omit the last character. */
    mov $0x01234567, %eax
    mov $-1, %bl
    movzb %bl, %eax
    LKMC_ASSERT_EQ(%eax, $0xFF)

    /* ERROR: Cannot omit the before last character. */
    /*movz %bl, %eax*/

LKMC_EPILOGUE
