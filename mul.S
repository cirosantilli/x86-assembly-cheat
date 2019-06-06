# Unsigned multiply.
#
# After:
#
#     mul SRC
#
# For 16 bits and up:
#
#     DX:AX = AX * SRC;
#
# And for 8 bits:
#
#     AX = AL * SRC;
#
# No immediate form, although imul has one:
# http://stackoverflow.com/questions/20499141/is-it-possible-to-multiply-by-and-immediate-with-mul-in-x86-assembly/33202309#33202309

#include <lkmc.h>

DATA
    x: .long 0x12341234

LKMC_PROLOGUE
    movl $2, %eax
    movl $2, %ebx
    mull %ebx
    LKMC_ASSERT_EQ_32(%eax, $4)
    LKMC_ASSERT_EQ_32(%ebx, $2)

    # 8 bit
    movl $0, %eax
    movb $2, %al
    movb $0x80, %bl
    movb $0, %dl
    mulb %bl
    LKMC_ASSERT_EQ_32(%eax, $0x100)

    # 16 bit
    movl $0, %eax
    movl $0, %edx
    movw $2, %ax
    movw $0x8000, %bx
    movw $0, %dx
    mulw %bx
    LKMC_ASSERT_EQ_32(%eax, $0)
    movw %dx, %ax
    LKMC_ASSERT_EQ_32(%eax, $1)

    # 32 bit
    movl $2, %eax
    movl $0x80000000, %ebx
    movl $0, %edx
    mull %ebx
    LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%edx, $1)

    # Memory version
    movl $2, %eax
    mull x
    LKMC_ASSERT_EQ_32(%eax, $0x24682468)

LKMC_EPILOGUE
