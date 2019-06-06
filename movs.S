# # movs

    # Copy one string into another.

    # Input pointed by esi, output by edi.

#include <lkmc.h>

.data

    src db 0, 1
    dest db 2, 3

LKMC_PROLOGUE

    movl $src, %esi
    movl $dest, %edi

    cld
    movsb
    LKMC_ASSERT_EQ_32 [dest], 0, byte
    movl %esi, %eax
    subl $src, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)
    movl %edi, %eax
    subl $dest, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)

    std
    movsb
    LKMC_ASSERT_EQ_32 [dest + 1], 1, byte
    movl %esi, %eax
    subl $src, %eax
    LKMC_ASSERT_EQ_32(%eax, $0)
    movl %edi, %eax
    subl $dest, %eax
    LKMC_ASSERT_EQ_32(%eax, $0)

LKMC_EPILOGUE
