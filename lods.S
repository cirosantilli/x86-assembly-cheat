# # lods

    # Load data a and move `esi`.

    # Does not touch edi.

#include <lkmc.h>

.data

    bs4 db 0, 1

LKMC_PROLOGUE

    mov $bs4, %esi
    mov $0, %edi

    cld
    # Increase ESI
    lodsb
    LKMC_ASSERT_EQ_32(%al, $0)
    mov %esi, %eax
    subl $bs4, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)
    LKMC_ASSERT_EQ_32(%edi, $0)

    std
    # Decrease ESI
    lodsb
    LKMC_ASSERT_EQ_32(%al, $1)
    mov %esi, %eax
    subl $bs4, %eax
    LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%edi, $0)

LKMC_EPILOGUE
