; Negate: i *= -1.

#include <lkmc.h>

LKMC_PROLOGUE
    mov eax, 2
    neg eax
    LKMC_ASSERT_EQ_32 eax, -2
    neg eax
    LKMC_ASSERT_EQ_32(%eax, $2)
LKMC_EPILOGUE
