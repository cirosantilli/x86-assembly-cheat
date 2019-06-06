# # scas

    # Compare array and a.

#include <lkmc.h>

.data

    bs4 db 0, 1, 2, 3
    bs4_2 db 0, 0, 0, 0

LKMC_PROLOGUE

    movl $bs4, %edi
    movb $0,bs4
    mov byte [bs4 + 1], 1

    cld
    movb $0,%al
    scasb
    ASSERT_FLAG jz
    movl %edi,%eax
    subl $bs4, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)

    std
    movb $2,%al
    scasb
    ASSERT_FLAG jnz
    movl %edi,%eax
    subl $bs4, %eax
    LKMC_ASSERT_EQ_32(%eax, $0)

LKMC_EPILOGUE
