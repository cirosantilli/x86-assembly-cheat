# # pusha

# # popa

    # Push and restore the following registers using the stack:
    # EAX, ECX, EDX, EBX, ESP, EBP, ESI, EDI

    # This is important for example in the C calling convention, 
    # where certain registers must not be changed by functions.

#include <lkmc.h>

LKMC_PROLOGUE

    mov $0, %ebx
    mov $0, %ecx

    mov %esp, %eax
    pusha
    subl %esp, %eax
    # 8x 4 bytes
    LKMC_ASSERT_EQ_32(%eax, $32)

    mov $1, %ebx
    mov $1, %ecx
    popa
    LKMC_ASSERT_EQ_32(%ebx, $0)
    LKMC_ASSERT_EQ_32(%ecx, $0)

LKMC_EPILOGUE
