; # AND

#include <lkmc.h>

LKMC_PROLOGUE
    mov ax, 0x00FF
    and ax, 0x0F0F
    LKMC_ASSERT_EQ(%ax, $0x000F)
LKMC_EPILOGUE
