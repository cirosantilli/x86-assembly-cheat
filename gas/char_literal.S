/*
http://stackoverflow.com/questions/33246811/how-to-use-character-literals-in-gnu-gas-to-replace-numbers

This syntax plays horribly with the C preprocessor:

    MACRO($'a)

fails because cpp treats string and char literals magically.

GAS macros work better here.

And it generates trailing whitespace... bad move from GAS devs. They should just have closed it like C.
*/

#include "lib/common_gas.h"

ENTRY

    /* Memory. */
    mov c, %al
    ASSERT_EQ($0x61, %al)

    /* Immediate. Without the `$`, does a memory access, and segfaults! */
    mov $'b, %al
    ASSERT_EQ($0x62, %al)

    /* Space character works. */
    mov $' , %al
    ASSERT_EQ($0x20, %al)

    /* Backslash escapes work. */
    mov $'\n , %al
    ASSERT_EQ($0x0A, %al)

EXIT

c:
    .byte 'a
