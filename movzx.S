# # MOVZX

    # mov and zero extend

    # Works for unsigned numbers.

#include <lkmc.h>

LKMC_PROLOGUE

    mov $0, %eax
    mov $0x1000, %ax
    movzwl %ax, %eax
    LKMC_ASSERT_EQ_32(%eax, $0x1000)

    mov $0, %ebx
    mov $0x10, %al
    movzbl %al, %ebx
    mov %ebx, %eax
    LKMC_ASSERT_EQ_32(%eax, $0x10)

    mov $0, %eax
    mov $-1, %ax
    movzwl %ax, %eax
    ASSERT_NEQ eax, -1

    # ERROR: operands have the same size. Fist must be larger.
    #movzx al, al

    # ERROR: must be a register
    #movzx eax, 0
LKMC_EPILOGUE
