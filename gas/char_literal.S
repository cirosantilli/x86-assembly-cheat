/*
http://stackoverflow.com/questions/33246811/how-to-use-character-literals-in-gnu-gas-to-replace-numbers

This syntax plays horribly with the C preprocessor:

    MACRO($'a)

fails because cpp treats string and char literals magically.

GAS macros work better here.

And it generates trailing whitespace... bad move from GAS devs. They should just have closed it like C.
*/

#include "lib/common_gas.h"

LKMC_PROLOGUE

    /* Memory. */
    mov c, %al
    LKMC_ASSERT_EQ(%al, $0x61)

    /* Immediate. Without the `$`, does a memory access, and segfaults! */
    mov $'b, %al
    LKMC_ASSERT_EQ(%al, $0x62)

    /* Space character works. */
    mov $' , %al
    LKMC_ASSERT_EQ(%al, $0x20)

    /* Backslash escapes work. */
    mov $'\n , %al
    LKMC_ASSERT_EQ(%al, $0x0A)

LKMC_EPILOGUE

c:
    .byte 'a
