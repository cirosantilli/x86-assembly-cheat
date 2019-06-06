; # BTS

    ; BT + Set.

    ; TODO confirm: synchronization primitive. http://wiki.osdev.org/Spinlock

#include <lkmc.h>

LKMC_PROLOGUE
    mov ax, 0x0A
    bts ax, 0
    LKMC_ASSERT_EQ_32(%ax, $0x0B)
    ASSERT_FLAG jnc

    mov ax, 0x0A
    bt ax, 1
    ASSERT_FLAG jc
    LKMC_ASSERT_EQ_32(%ax, $0x0A)

LKMC_EPILOGUE
