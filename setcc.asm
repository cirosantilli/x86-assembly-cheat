; # SETcc

    ; Set version of CMOVcc

#include <lkmc.h>

LKMC_PROLOGUE

    mov eax, 0

    stc
    setc al
    LKMC_ASSERT_EQ_32(%eax, $1)

    clc
    setc al
    LKMC_ASSERT_EQ_32(%eax, $0)

    ; ERROR: only for 8 bit registers or memory.
    ;setc eax

LKMC_EPILOGUE
