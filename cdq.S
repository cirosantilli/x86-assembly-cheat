# Convert double word to quadword.
#
# Sign extend `eax` into `edx:eax`.
#
# Common combo with idiv 32-bit, which takes the input from `edx:eax`:
# so you need to set up `edx` before calling it.

#include <lkmc.h>

LKMC_PROLOGUE
    mov $1, %eax
    mov $0x01234567, %edx
    cltd
    LKMC_ASSERT_EQ_32(%edx, $0)

    mov $-1, %eax
    mov $0x01234567, %edx
    cltd
    LKMC_ASSERT_EQ_32(%edx, $0xFFFFFFFF)

LKMC_EPILOGUE
