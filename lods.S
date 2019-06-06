# # lods

    # Load data a and move `esi`.

    # Does not touch edi.

#include <lkmc.h>

DATA

    bs4 db 0, 1

LKMC_PROLOGUE

    movl $bs4, %esi
    movl $0,%edi

    cld
    # Increase ESI
    lodsb
    LKMC_ASSERT_EQ_32(%al, $0)
    movl %esi,%eax
    subl $bs4, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)
    LKMC_ASSERT_EQ_32(%edi, $0)

    std
    # Decrease ESI
    lodsb
    LKMC_ASSERT_EQ_32(%al, $1)
    movl %esi,%eax
    subl $bs4, %eax
    LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%edi, $0)

LKMC_EPILOGUE
