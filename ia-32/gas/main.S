/*
GAS syntax cheat.
*/

#include "lib/asm_io_s.h"

.data

    /*
    .int and .float are only mnemonics for data size,
    they do not impose any compile size typechecking.
    */

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

                a(b, c, d)

            is the same as Intel notation:

                [a + b * d + c]

            with:

            - `a`: immediate
            - `b`: register
            - `c`: register
            - `d`: immmediate power of 2
            */

        /* basic usage: */

            mov $0, %eax
            movl $1, i
            mov i, %eax
            ASSERT_EQ($1)

        /* `(i)` is the same as `i`: if the label is the only thing */
        /* inside the parenthesis, those can be omited. */

            movl $2, i
            mov i, %eax
            ASSERT_EQ($2)

        /* To get the actual adress instead of the data, use `$`: */

            /* ebx = &i */
            mov $i, %ebx
            /* eax = *ebx */
            mov (%ebx), %eax
            ASSERT_EQ(i)

    /* float */

            /* fld1 */
            /* fldl (f1) */
            /* fchs */
            /* fstpl (f) */
            /* movl (f), %eax */

        /*
        # $

        # Dollar sign

            Immediates:

            -  constants `$0x1F`
            - label addresses `$label`. Without dollar, it means the data itself!
        */


        /*
        # irp

            The macro below generates:

                add $3, %eax
                add $1, %eax
                add $2, %eax
        */

            mov $0, %eax
            .irp i, 3, 1, 2
                add $\i, %eax
            .endr
            ASSERT_EQ($6)

    EXIT
