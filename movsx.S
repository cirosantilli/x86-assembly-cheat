# # MOVSX

    # mov and sign extend

    # In 2s complement, just extend sign bit.
    # There are many anterior commands that do this
    # for specific sizes, created before 32 bit registers.

#include <lkmc.h>

LKMC_PROLOGUE

    movl $0, %eax
    movw $-1, %ax
    movswl %ax, %eax
    LKMC_ASSERT_EQ_32 eax, -1

LKMC_EPILOGUE
