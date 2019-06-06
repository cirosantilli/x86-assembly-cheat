; # xchg

#include <lkmc.h>

LKMC_PROLOGUE
    mov eax, 0
    mov ebx, 1

    xchg eax, ebx
    LKMC_ASSERT_EQ_32(%eax, $1)
    LKMC_ASSERT_EQ_32(%ebx, $0)

    xchg eax, ebx
    LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%ebx, $1)

LKMC_EPILOGUE
