# # TEST

    # `test X, Y` is like `and` but only sets flags:

        # ZF = (!(X && Y)) ? 1 : 0

    # Contrast this with `cmp` which does `sub` instead of `and`.

    # This file is named `test_instruction`
    # so as to not conflict with the `test` make target.

#include <lkmc.h>

LKMC_PROLOGUE
    movb $0x0F0,%al
    testb $0,%al
    ASSERT_FLAG jz
    LKMC_ASSERT_EQ_32(%al, $0x0F0)

    movb $0x0F0,%al
    LKMC_ASSERT_EQ_32(%al, $0x0F0)
    testb $0x0F0,%al
    ASSERT_FLAG jnz
    LKMC_ASSERT_EQ_32(%al, $0x0F0)

    # # test %eax, %eax vc cmp %eax, 0

        # http://stackoverflow.com/questions/147173/x86-assembly-testl-eax-against-eax

        # `test %eax, %eax` is often used instead of `cmp %eax, 0`
        # as it generates shorter instructions:

LKMC_EPILOGUE
