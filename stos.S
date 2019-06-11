# # stos

    # Store from `a` and move `edi`

#include <lkmc.h>

.data

    bs4 db 0, 1, 2, 3
    bs4_2 db 0, 0, 0, 0

LKMC_PROLOGUE

    mov $bs4, %edi

    cld
    mov $1, %bl
    mov %bl, %al
    stosb
    LKMC_ASSERT_EQ_32 [bs4], bl
    mov %edi, %eax
    subl $bs4, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)

    std
    mov $2, %bl
    mov %bl, %al
    stosb
    LKMC_ASSERT_EQ_32 [bs4 + 1], bl
    mov %edi, %eax
    subl $bs4, %eax
    LKMC_ASSERT_EQ_32(%eax, $0)

    cld

LKMC_EPILOGUE
