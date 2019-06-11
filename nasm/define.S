# define

#include <lkmc.h>

LKMC_PROLOGUE
    .equ SIZE, 10
    mov $SIZE, %eax
    LKMC_ASSERT_EQ_32(%eax, $10)
LKMC_EPILOGUE
