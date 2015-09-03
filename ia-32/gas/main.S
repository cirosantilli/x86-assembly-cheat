/*
GAS syntax cheat.
*/

#include "lib/asm_io_s.h"

.data

    i:
        .int 0

    f:
        .float 0.0

    f1:
        .float 1.0

    /* Strings */

        /* # ascii */

                s:
                    .ascii  "abcd\n"
                    s_len = . - s

                s0:
                    .ascii  "abcd\0"
                    s_len = . - s

        /*
        # asciz

            Like `.ascii` but adds null char to string

            Same as:

                .ascii "assert failed\n\x00"

                .ascii "assert failed\n\000"
        */

                sz:
                    .asciz  "abcd"
                    s_len = . - s

ENTRY

    /* # RAM memory */

        /*
        # Indirect addressing

            Documented at:
            https://sourceware.org/binutils/docs-2.18/as/i386_002dMemory.html#i386_002dMemory

            Of form:

                s:a(b, c, d)

            is the same as Intel notation:

                [a + b * d + c]

            with:

            - `s`: segment
            - `a`: immediate
            - `b`: register
            - `c`: register
            - `d`: immmediate power of 2

            Most of the parts are optional.
            */

        /* Basic usage: */

            mov $0, %eax
            movl $1, i
            mov i, %eax
            ASSERT_EQ($1)

        /* TODO why does `(i)` work? */

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
