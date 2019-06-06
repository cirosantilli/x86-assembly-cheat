# Negate: i *= -1.

#include <lkmc.h>

LKMC_PROLOGUE
    movl $2, %eax
    negl %eax
    LKMC_ASSERT_EQ_32 eax, -2
    negl %eax
    LKMC_ASSERT_EQ_32(%eax, $2)
LKMC_EPILOGUE
