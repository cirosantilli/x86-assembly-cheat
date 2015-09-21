/*
# Indirect addressing

Documented at:
https://sourceware.org/binutils/docs-2.18/as/i386_002dMemory.html#i386_002dMemory

Of form:

    s:a(b, c, d)

is the same as Intel notation:

    s:[a + b * d + c]

with:

- `s`: segment register
- `a`: immediate
- `b`: register
- `c`: register
- `d`: immmediate power of 2

Most of the parts are optional.
*/

#include "lib/asm_io_s.h"

.data
    i:
        .int 0
ENTRY
    /* Basic usage: */
    mov $0, %eax
    movl $1, i
    mov i, %eax
    ASSERT_EQ($1)

    /* TODO why does `(i)` work? What is a, b, c, d and the missing defaults? */
    movl $2, (i)
    mov (i), %eax
    ASSERT_EQ($2)

    /* To get the actual adress instead of the data, use `$`: */
    /* ebx = &i */
    mov $i, %ebx
    /* eax = *ebx */
    mov (%ebx), %eax
    ASSERT_EQ(i)

    EXIT
