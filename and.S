# # AND

#include <lkmc.h>

LKMC_PROLOGUE
    mov $0x00FF, %ax
    andw $0x0F0F, %ax
    LKMC_ASSERT_EQ_32(%ax, $0x000F)
LKMC_EPILOGUE
