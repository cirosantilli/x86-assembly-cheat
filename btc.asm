; # btc

    ; BT + complement.

#include <lkmc.h>

LKMC_PROLOGUE
    mov ax, 0x0A
    btc ax, 0
    LKMC_ASSERT_EQ(%ax, $0x0B)
    ASSERT_FLAG jnc

    mov ax, 0x0A
    btc ax, 1
    LKMC_ASSERT_EQ(%ax, $0x08)
    ASSERT_FLAG jc

LKMC_EPILOGUE
