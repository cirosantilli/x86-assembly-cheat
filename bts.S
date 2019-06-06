# # BTS

    # BT + Set.

    # TODO confirm: synchronization primitive. http://wiki.osdev.org/Spinlock

#include <lkmc.h>

LKMC_PROLOGUE
    movw $0x0A,%ax
    btsw $0,%ax
    LKMC_ASSERT_EQ_32(%ax, $0x0B)
    ASSERT_FLAG jnc

    movw $0x0A,%ax
    btw $1,%ax
    ASSERT_FLAG jc
    LKMC_ASSERT_EQ_32(%ax, $0x0A)

LKMC_EPILOGUE
