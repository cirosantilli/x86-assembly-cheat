; # NOT

#include <lkmc.h>

LKMC_PROLOGUE
    mov al, 0x0F0
    not al
    LKMC_ASSERT_EQ(%al, $0x0F)
LKMC_EPILOGUE
