# # xchg

#include <lkmc.h>

LKMC_PROLOGUE
    movl $0, %eax
    movl $1, %ebx

    xchgl %ebx, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)
    LKMC_ASSERT_EQ_32(%ebx, $0)

    xchgl %ebx, %eax
    LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%ebx, $1)

LKMC_EPILOGUE
