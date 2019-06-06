# # pusha

# # popa

    # Push and restore the following registers using the stack:
    # EAX, ECX, EDX, EBX, ESP, EBP, ESI, EDI

    # This is important for example in the C calling convention,
    # where certain registers must not be changed by functions.

#include <lkmc.h>

LKMC_PROLOGUE

    movl $0,%ebx
    movl $0,%ecx

    movl %esp,%eax
    pusha
    subl %esp,%eax
    # 8x 4 bytes
    LKMC_ASSERT_EQ_32(%eax, $32)

    movl $1,%ebx
    movl $1,%ecx
    popa
    LKMC_ASSERT_EQ_32(%ebx, $0)
    LKMC_ASSERT_EQ_32(%ecx, $0)

LKMC_EPILOGUE
