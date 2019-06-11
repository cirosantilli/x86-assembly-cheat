# # NOT

#include <lkmc.h>

LKMC_PROLOGUE
    mov $0x0F0, %al
    notb %al
    LKMC_ASSERT_EQ_32(%al, $0x0F)
LKMC_EPILOGUE
