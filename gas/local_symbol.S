/*
# local symbol

# .L

Symbols that start with `.L` don't appear at all on the ELF output.

By default, symbols do appear on ELF, but are local.

Unlike NASM's `.label`, such labels are visible on the entire file,
and cannot be redefined.
*/

#include "lib/common_gas.h"

.data
    not_local:
        .long 1

    .Lyes_local:
        .long 2
LKMC_PROLOGUE
    mov not_local, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)

    mov .Lyes_local, %eax
    LKMC_ASSERT_EQ_32(%eax, $2)

LKMC_EPILOGUE
