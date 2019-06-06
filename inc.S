# Increment, i++.

#include <lkmc.h>

LKMC_PROLOGUE
    movl $0, %eax
    # eax++
    incl %eax
    LKMC_ASSERT_EQ_32(%eax, $1)
LKMC_EPILOGUE
