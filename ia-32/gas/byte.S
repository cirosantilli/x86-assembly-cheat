/*
# byte

# word

# long

# quad

# dquad

Write bytes to the object file.
*/

#include "lib/asm_io_s.h"

.data
byte:
    .byte 0x12
byte2:
    .byte 0x12, 0x34
word:
    .word 0x1234
long:
    .long 0x12345678
quad:
    .quad 0x0123456789ABCDEF

ENTRY
    mov byte, %al
    ASSERT_EQ2($0x12, %al)

    /* TODO why is this inverted from next? */
    mov byte2, %ax
    ASSERT_EQ2($0x3412, %ax)

    mov word, %ax
    ASSERT_EQ2($0x1234, %ax)

    mov long, %eax
    ASSERT_EQ2($0x12345678, %eax)

    /* TODO does the last one come first? */
    mov quad, %eax
    ASSERT_EQ2($0x89ABCDEF, %eax)
    mov $quad, %eax
    add $4, %eax
    mov (%eax), %eax
    ASSERT_EQ2($0x01234567, %eax)

    EXIT
