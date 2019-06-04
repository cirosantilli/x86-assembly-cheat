; # btr

    ; BT + reset.

#include <lkmc.h>

LKMC_PROLOGUE
    mov ax, 0x0A
    btr ax, 1
    LKMC_ASSERT_EQ(%ax, $8)
    ASSERT_FLAG jc
LKMC_EPILOGUE
