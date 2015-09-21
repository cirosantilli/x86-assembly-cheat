/*
Create a byte string from ASCII characters.

Not null terminated.
*/

#include "lib/asm_io_s.h"

.data
s:
    .ascii  "abc\0"
    s_len = . - s

ENTRY
    mov s, %eax
    ASSERT_EQ($0x00636261)

    mov $s_len, %eax
    ASSERT_EQ($4)
    EXIT
