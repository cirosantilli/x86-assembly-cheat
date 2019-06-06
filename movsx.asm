; # MOVSX

    ; mov and sign extend

    ; In 2s complement, just extend sign bit.
    ; There are many anterior commands that do this
    ; for specific sizes, created before 32 bit registers.

#include <lkmc.h>

LKMC_PROLOGUE

    mov eax, 0
    mov ax, -1
    movsx eax, ax
    LKMC_ASSERT_EQ_32 eax, -1

LKMC_EPILOGUE
