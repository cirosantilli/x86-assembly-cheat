; # movs

    ; Copy one string into another.

    ; Input pointed by esi, output by edi.

#include <lkmc.h>

section .data

    src db 0, 1
    dest db 2, 3

LKMC_PROLOGUE

    mov esi, src
    mov edi, dest

    cld
    movsb
    LKMC_ASSERT_EQ_32 [dest], 0, byte
    mov eax, esi
    sub eax, src
    LKMC_ASSERT_EQ_32(%eax, $1)
    mov eax, edi
    sub eax, dest
    LKMC_ASSERT_EQ_32(%eax, $1)

    std
    movsb
    LKMC_ASSERT_EQ_32 [dest + 1], 1, byte
    mov eax, esi
    sub eax, src
    LKMC_ASSERT_EQ_32(%eax, $0)
    mov eax, edi
    sub eax, dest
    LKMC_ASSERT_EQ_32(%eax, $0)

LKMC_EPILOGUE
