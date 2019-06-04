; # XADD

    ; Add and swap.

    ; Useful syncrhonization primitive to make an atomc addition,
    ; this is how C++ atomic ++ is implemented in GCC 5.1.

#include <lkmc.h>

LKMC_PROLOGUE
    mov eax, 1
    mov ebx, 2
    xadd eax, ebx
    LKMC_ASSERT_EQ(%eax, $3)
    LKMC_ASSERT_EQ(%ebx, $1)
LKMC_EPILOGUE
