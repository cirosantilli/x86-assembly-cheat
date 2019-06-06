# define

#include <lkmc.h>

LKMC_PROLOGUE
    .equ SIZE, 10
    movl $SIZE, %eax
    LKMC_ASSERT_EQ_32(%eax, $10)
LKMC_EPILOGUE
