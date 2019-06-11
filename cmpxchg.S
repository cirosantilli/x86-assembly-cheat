# # CMPXCHG

    # Synchronization primitive.

        # cmpxchg x, y

    # Can have the LOCK prefix, but that is useless as it has lock semantics by default.

#include <lkmc.h>

LKMC_PROLOGUE
    mov $0, %eax
    mov $1, %ebx
    mov $2, %ecx
    cmpxchgl %ecx, %ebx
    ASSERT_FLAG jnz
    # TODO
    #LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%ebx, $1)
    LKMC_ASSERT_EQ_32(%ecx, $2)

    mov $0, %eax
    mov $0, %ebx
    mov $2, %ecx
    cmpxchgl %ecx, %ebx
    ASSERT_FLAG jz
    LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%ebx, $2)
    LKMC_ASSERT_EQ_32(%ecx, $2)

LKMC_EPILOGUE
