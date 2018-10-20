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
ENTRY
    mov not_local, %eax
    ASSERT_EQ($1, %eax)

    mov .Lyes_local, %eax
    ASSERT_EQ($2, %eax)

EXIT
