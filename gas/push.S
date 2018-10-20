#include "lib/common_gas.h"

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
    ASSERT_EQ($3, val1)

    /* esp was reduced by 4. */
    ASSERT_EQ($val1, %eax)

    mov $val1, %esp
    pop %ebx
    mov %esp, %eax
    mov orig, %esp
    ASSERT_EQ($3, %ebx)
    ASSERT_EQ($val2, %eax)

EXIT
