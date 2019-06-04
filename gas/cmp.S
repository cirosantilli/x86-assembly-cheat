/*
# cmp

    cmp must take the value first, register after,
    otherwise you get "operand type mismatch""

    http://stackoverflow.com/questions/30200515/gcc-inline-operand-type-mismatch-for-cmp
*/

#include "lib/common_gas.h"

LKMC_PROLOGUE
    mov $1, %eax

    /* Equal. */
    cmp $1, %eax
    ASSERT_FLAG(jz)

    /* Different. */
    cmp $2, %eax
    ASSERT_FLAG(jnz)

LKMC_EPILOGUE
