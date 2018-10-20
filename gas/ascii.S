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

ENTRY
    mov s, %eax
    ASSERT_EQ($0x00636261, %eax)

    /* Concatenates literals like C does. */
    mov cat, %eax
    ASSERT_EQ($0x64636261, %eax)

    mov $s_len, %eax
    ASSERT_EQ($4, %eax)

    mov $0, %edx
    mov $30, %eax
    mov $25, %ecx
    div %ecx
    mov %edx, %eax
    ASSERT_EQ($5, %eax)

EXIT
