# # CMPXCHG

    # Synchronization primitive.

        # cmpxchg x, y

    # Can have the LOCK prefix, but that is useless as it has lock semantics by default.

#include <lkmc.h>

LKMC_PROLOGUE
    movl $0,%eax
    movl $1,%ebx
    movl $2,%ecx
    cmpxchgl %ecx,%ebx
    ASSERT_FLAG jnz
    # TODO
    #LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%ebx, $1)
    LKMC_ASSERT_EQ_32(%ecx, $2)

    movl $0,%eax
    movl $0,%ebx
    movl $2,%ecx
    cmpxchgl %ecx,%ebx
    ASSERT_FLAG jz
    LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%ebx, $2)
    LKMC_ASSERT_EQ_32(%ecx, $2)

LKMC_EPILOGUE
