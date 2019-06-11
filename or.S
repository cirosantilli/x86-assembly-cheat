# # OR

#include <lkmc.h>

LKMC_PROLOGUE
    mov $0x00FF, %ax
    orw $0x0F0F, %ax
    LKMC_ASSERT_EQ_32(%ax, $0x0FFF)
LKMC_EPILOGUE
