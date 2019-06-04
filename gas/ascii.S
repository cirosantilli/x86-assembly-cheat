/*
# ascii

https://sourceware.org/binutils/docs/as/Ascii.html#Ascii

Create a byte string from ASCII characters.

Not null terminated.

TODO vs string? https://sourceware.org/binutils/docs/as/String.html
*/

#include "lib/common_gas.h"

.data
s:
    .ascii "abc\0"
    s_len = . - s
cat:
    .ascii  "ab" "cd"

LKMC_PROLOGUE
    mov s, %eax
    LKMC_ASSERT_EQ(%eax, $0x00636261)

    /* Concatenates literals like C does. */
    mov cat, %eax
    LKMC_ASSERT_EQ(%eax, $0x64636261)

    mov $s_len, %eax
    LKMC_ASSERT_EQ(%eax, $4)

    mov $0, %edx
    mov $30, %eax
    mov $25, %ecx
    div %ecx
    mov %edx, %eax
    LKMC_ASSERT_EQ(%eax, $5)

LKMC_EPILOGUE
