; Subtraction.

#include <lkmc.h>

LKMC_PROLOGUE
    mov eax, 1
    sub eax, 1
    LKMC_ASSERT_EQ_32(%eax, $0)
LKMC_EPILOGUE
