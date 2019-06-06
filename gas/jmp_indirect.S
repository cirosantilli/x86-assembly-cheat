/*
# jmp indirect

    The asterisk jumps to the data at the address pointed to.

    Not very consistent syntax with default memory access like `mov x, %eax`, 
    which uses `$x` for the address, and `x` for indirection.
*/

#include "lib/common_gas.h"

.section .rodata
    symbol0: .int label0
LKMC_PROLOGUE
    /* Sanity check: the label was stored OK in data. */
    mov symbol0, %eax
    LKMC_ASSERT_EQ_32(%eax, $label0)

    jmp *symbol0
    ASSERT_FAIL
    label0:

LKMC_EPILOGUE
