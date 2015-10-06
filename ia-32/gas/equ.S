/*
# equ

# set

    `.equ` and `.set` are the same.

    https://sourceware.org/binutils/docs/as/Equ.html
    https://sourceware.org/binutils/docs/as/Set.html#Set
*/

#include "lib/asm_io_s.h"

ENTRY

    .equ x, 0x1234567
    mov $0, %eax
    mov $x, %eax
    ASSERT_EQ($0x1234567)

    .set y, 0x1234567
    mov $0, %eax
    mov $y, %eax
    ASSERT_EQ($0x1234567)


    /*
    TODO: vs macro?

    One difference is that expressions can be used. Is that the main one?
    */

    .set y, 2 * 1 + 1
    mov $0, %eax
    mov $y, %eax
    ASSERT_EQ($0x3)

    EXIT
