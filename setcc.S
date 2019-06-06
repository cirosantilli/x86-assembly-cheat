# # SETcc

    # Set version of CMOVcc

#include <lkmc.h>

LKMC_PROLOGUE

    movl $0, %eax

    stc
    setcb %al
    LKMC_ASSERT_EQ_32(%eax, $1)

    clc
    setcb %al
    LKMC_ASSERT_EQ_32(%eax, $0)

    # ERROR: only for 8 bit registers or memory.
    #setc eax

LKMC_EPILOGUE
