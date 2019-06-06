#include "lib/common_gas.h"

.data
    val1:
        .long 1
    val2:
        .long 2
    orig:
        .skip 4
LKMC_PROLOGUE

    mov %esp, orig

    mov $val2, %esp
    push $3
    mov %esp, %eax

    /* Restore esp to not break our IO. */
    mov orig, %esp

    /* val1 was modified by the push. */
    LKMC_ASSERT_EQ_32(val1, $3)

    /* esp was reduced by 4. */
    LKMC_ASSERT_EQ_32(%eax, $val1)

    mov $val1, %esp
    pop %ebx
    mov %esp, %eax
    mov orig, %esp
    LKMC_ASSERT_EQ_32(%ebx, $3)
    LKMC_ASSERT_EQ_32(%eax, $val2)

LKMC_EPILOGUE
