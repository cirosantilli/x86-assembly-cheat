; # stos

    ; Store from `a` and move `edi`

#include <lkmc.h>

section .data

    bs4 db 0, 1, 2, 3
    bs4_2 db 0, 0, 0, 0

LKMC_PROLOGUE

    mov edi, bs4

    cld
    mov bl, 1
    mov al, bl
    stosb
    LKMC_ASSERT_EQ_32 [bs4], bl
    mov eax, edi
    sub eax, bs4
    LKMC_ASSERT_EQ_32(%eax, $1)

    std
    mov bl, 2
    mov al, bl
    stosb
    LKMC_ASSERT_EQ_32 [bs4 + 1], bl
    mov eax, edi
    sub eax, bs4
    LKMC_ASSERT_EQ_32(%eax, $0)

    cld

LKMC_EPILOGUE
