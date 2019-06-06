# # MOVZX

    # mov and zero extend

    # Works for unsigned numbers.

#include <lkmc.h>

LKMC_PROLOGUE

    movl $0, %eax
    movw $0x1000, %ax
    movzwl %ax, %eax
    LKMC_ASSERT_EQ_32(%eax, $0x1000)

    movl $0, %ebx
    movb $0x10, %al
    movzbl %al, %ebx
    movl %ebx, %eax
    LKMC_ASSERT_EQ_32(%eax, $0x10)

    movl $0, %eax
    movw $-1, %ax
    movzwl %ax, %eax
    ASSERT_NEQ eax, -1

    # ERROR: operands have the same size. Fist must be larger.
    #movzx al, al

    # ERROR: must be a register
    #movzx eax, 0
LKMC_EPILOGUE
