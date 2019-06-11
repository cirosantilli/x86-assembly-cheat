# # pushf

# # pushfd

# # pushfq

# # popf

    # Like pusha and popa, but for flags:

    # - push/pop FLAGS
    # - pushd/popd EFLAGS


#include <lkmc.h>

LKMC_PROLOGUE

    clc
    mov %esp, %eax
    pushf
    subl %esp, %eax
    # Needs 2 bytes, stack min 1 dword.
    LKMC_ASSERT_EQ_32(%eax, $4)

    stc
    popf
    ASSERT_FLAG jnc

    clc
    pushfl
    stc
    popfl
    ASSERT_FLAG jnc

LKMC_EPILOGUE
