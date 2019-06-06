# # btc

    # BT + complement.

#include <lkmc.h>

LKMC_PROLOGUE
    movw $0x0A,%ax
    btcw $0,%ax
    LKMC_ASSERT_EQ_32(%ax, $0x0B)
    ASSERT_FLAG jnc

    movw $0x0A,%ax
    btcw $1,%ax
    LKMC_ASSERT_EQ_32(%ax, $0x08)
    ASSERT_FLAG jc

LKMC_EPILOGUE
