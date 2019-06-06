; # lods

    ; Load data a and move `esi`.

    ; Does not touch edi.

#include <lkmc.h>

DATA

    bs4 db 0, 1

LKMC_PROLOGUE

    mov esi, bs4
    mov edi, 0

    cld
    ; Increase ESI
    lodsb
    LKMC_ASSERT_EQ_32(%al, $0)
    mov eax, esi
    sub eax, bs4
    LKMC_ASSERT_EQ_32(%eax, $1)
    LKMC_ASSERT_EQ_32(%edi, $0)

    std
    ; Decrease ESI
    lodsb
    LKMC_ASSERT_EQ_32(%al, $1)
    mov eax, esi
    sub eax, bs4
    LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%edi, $0)

LKMC_EPILOGUE
