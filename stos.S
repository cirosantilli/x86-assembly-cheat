# # stos

    # Store from `a` and move `edi`

#include <lkmc.h>

.data

    bs4 db 0, 1, 2, 3
    bs4_2 db 0, 0, 0, 0

LKMC_PROLOGUE

    movl $bs4, %edi

    cld
    movb $1,%bl
    movb %bl,%al
    stosb
    LKMC_ASSERT_EQ_32 [bs4], bl
    movl %edi,%eax
    subl $bs4, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)

    std
    movb $2,%bl
    movb %bl,%al
    stosb
    LKMC_ASSERT_EQ_32 [bs4 + 1], bl
    movl %edi,%eax
    subl $bs4, %eax
    LKMC_ASSERT_EQ_32(%eax, $0)

    cld

LKMC_EPILOGUE
