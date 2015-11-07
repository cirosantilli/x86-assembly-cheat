/*
# push

# pop
*/

#include "lib/asm_io_s.h"

.data
    val1:
        .long 1
    val2:
        .long 2
    orig:
        .skip 4
ENTRY

    mov %esp, orig

    mov $val2, %esp
    push $3
    mov %esp, %eax

    /* Restore esp to not break our IO. */
    mov orig, %esp

    /* val1 was modified by the push. */
    ASSERT_EQ2($3, val1)

    /* esp was reduced by 4. */
    ASSERT_EQ2($val1, %eax)

    mov $val1, %esp
    pop %ebx
    mov %esp, %eax
    mov orig, %esp
    ASSERT_EQ2($3, %ebx)
    ASSERT_EQ2($val2, %eax)

    EXIT
