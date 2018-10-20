/*
# Addressing

Documented at:
https://sourceware.org/binutils/docs-2.18/as/i386_002dMemory.html

Of form:

    s:a(b, c, d)

is the same as Intel notation:

    s:[b + c*d + a]

Then GAS has various syntaxes for omitting parts of the address.
It's a bit harder to remember than AT&T.
*/

#include "lib/common_gas.h"

.data
    i:
        .long 0
ENTRY

    /*
    It is easier to use lea to do the unit tests.

    Wherever a number is used, the label `i` could be used as well:
    remember that labels are just translated to addresses.
    */

        /*
        Full form with immediates:
        ebx + ecx * 2 + 4 =
        3   + 4   * 2 + 4 =
        3   +       8 + 4 =
        3   +       8 + 4 =
        15
        */
        mov $0, %eax
        mov $3, %ebx
        mov $4, %ecx
        /* GAS 2.24 Warning: segment override on `lea' is ineffectual. */
        /*lea %ds:4(%ebx, %ecx, 2), %eax*/
        lea 4(%ebx, %ecx, 2), %eax
        ASSERT_EQ($15, %eax)

        /*
        Omit the mulitplicator d.
        a(b,c) == a(b,c,1)
        */
        mov $0, %eax
        mov $3, %ebx
        mov $4, %ecx
        lea 2(%ebx, %ecx), %eax
        ASSERT_EQ($9, %eax)

        /* Omit c and d. */
        mov $0, %eax
        mov $1, %ebx
        lea 2(%ebx), %eax
        ASSERT_EQ($3, %eax)

        /* Register only address. We can omit commas. */
        mov $0, %eax
        mov $1, %ebx
        lea (%ebx), %eax
        ASSERT_EQ($1, %eax)

        /* TODO What is this syntax for? Compare to the next example. */
        mov $0, %eax
        lea 2(,1), %eax
        ASSERT_EQ($2, %eax)

        mov $0, %eax
        lea 2, %eax
        ASSERT_EQ($2, %eax)

        /* TODO What is this syntax for? Compare to the previous example. */
        mov $0, %eax
        lea (2), %eax
        ASSERT_EQ($2, %eax)

        mov $0, %eax
        mov $3, %ebx
        lea 2(,%ebx,4), %eax
        ASSERT_EQ($14, %eax)

        /*
        Expressions like (1 + 1) or more commonly (label + 1)
        can be used like anywhere else.
        */
        mov $1, %eax
        lea (1 + 1)(%eax), %eax
        ASSERT_EQ($3, %eax)

    /*
    Impossible addressings.

    AT&T syntax requires you to thing more about can or cannot be done.
    */

        /*lea (%bl), %eax*/

    /*
    Now some examples with the label and actual memory movs just for concreteness.
    */

        /* Simple memory IO. */
        mov $0, %eax
        /* `l` suffix needed here because there is no register to tell the size. */
        movl $1, i
        mov i, %eax
        ASSERT_EQ($1, %eax)

        /* To get the actual address instead of the data, use `$`: */
        mov $i, %ebx
        mov (%ebx), %eax
        ASSERT_EQ(i, %eax)

EXIT
