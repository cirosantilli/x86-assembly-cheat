; # OR

#include <lkmc.h>

LKMC_PROLOGUE
    mov ax, 0x00FF
    or  ax, 0x0F0F
    LKMC_ASSERT_EQ_32(%ax, $0x0FFF)
LKMC_EPILOGUE
