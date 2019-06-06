# Subtraction.

#include <lkmc.h>

LKMC_PROLOGUE
    movl $1,%eax
    subl $1,%eax
    LKMC_ASSERT_EQ_32(%eax, $0)
LKMC_EPILOGUE
