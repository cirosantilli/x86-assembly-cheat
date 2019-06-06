# # cmps

    # Compare two arrays

#include <lkmc.h>

.data

    bs4 db 0, 1, 2, 3
    bs4_2 db 0, 0, 0, 0

LKMC_PROLOGUE

    movl $bs4, %esi
    movb $0,bs4
    mov byte [bs4 + 1], 1

    movl $bs4_2, %edi
    movb $0,bs4_2
    mov byte [bs4_2 + 1], 2

    cld
    cmpsb
    ASSERT_FLAG jz
    movl %esi,%eax
    subl $bs4, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)
    movl %edi,%eax
    subl $bs4_2, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)
    LKMC_ASSERT_EQ_32 [bs4], 0, byte
    LKMC_ASSERT_EQ_32 [bs4_2], 0, byte

    std
    movsb
    ASSERT_FLAG jnz
    movl %esi,%eax
    subl $bs4, %eax
    LKMC_ASSERT_EQ_32(%eax, $0)
    movl %edi,%eax
    subl $bs4_2, %eax
    LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32 [bs4 + 1], 1, byte
    # TODO why fail?
    #LKMC_ASSERT_EQ_32 [bs4_2 + 1], 2, byte

LKMC_EPILOGUE
