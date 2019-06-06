# # Endianess

# x86 is little endian.

# http://stackoverflow.com/questions/5185551/why-is-x86-little-endian

#include <lkmc.h>

.data
    x dw 0x0102
LKMC_PROLOGUE
    LKMC_ASSERT_EQ_32 [x], 2, byte
LKMC_EPILOGUE
