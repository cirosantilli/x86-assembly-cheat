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

ENTRY
    mov $0x01234567, %eax
    mov $1, %bl
    movzbl %bl, %eax
    ASSERT_EQ($1, %eax)

    mov $0x01234567, %eax
    mov $-1, %bl
    movzbl %bl, %eax
    ASSERT_EQ($0xFF, %eax)

    /* Can omit the last character. */
    mov $0x01234567, %eax
    mov $-1, %bl
    movzb %bl, %eax
    ASSERT_EQ($0xFF, %eax)

    /* ERROR: Cannot omit the before last character. */
    /*movz %bl, %eax*/

EXIT
