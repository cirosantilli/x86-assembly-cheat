## mov zero extend
#
# mov r32 zero extends to the full register.
#
# This does not happen on 8 and 16 bit operations.
#
# http://stackoverflow.com/questions/11177137/why-do-most-x64-instructions-zero-the-upper-part-of-a-32-bit-register

#include <lkmc.h>

LKMC_PROLOGUE
    movq $0x12345678_9ABCDEF0, %rax
    movl $1,%eax
    LKMC_ASSERT_EQ(%rax, $1)

    # Does not happen for 16 and 8 bit.
    movl $0x12345678,%eax
    movw $1,%ax
    LKMC_ASSERT_EQ(%rax, $0x12340001)

    movl $0x12345678,%eax
    movb $1,%al
    LKMC_ASSERT_EQ(%rax, $0x12345601)

LKMC_EPILOGUE
