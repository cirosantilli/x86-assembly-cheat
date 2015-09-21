/*
# cmp

    cmp must take the value first, register after,
    otherwise you get "operand type mismatch""

    http://stackoverflow.com/questions/30200515/gcc-inline-operand-type-mismatch-for-cmp
*/

#include "lib/asm_io_s.h"

ENTRY
    mov $1, %eax
    /* Good. */
    cmp $1, %eax
    /* Error.. */
    /*cmp %eax, 0*/
    ASSERT_FLAG(jz)
    EXIT
