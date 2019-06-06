/*
# .global

By default, ELF symbols are STB_LOCAL, and not visible by the linker.

This make them STB_LOCAL.

Observe this with:

    readelf -s object-file.o

The entry symbol, notably, must be global.

Local symbols still appear on the output obejct file. To remove them completely, use local symbol `.L`.

# .local

TODO what is the effect of this, since variables are already local by default?
*/

#include "lib/common_gas.h"

.data

    not_global:
        .long 1

    .global yes_global
    yes_global:
        .long 2

    .local yes_local
    yes_local:
        .long 3

LKMC_PROLOGUE
    mov not_global, %eax
    LKMC_ASSERT_EQ_32(%eax, $1)

    mov yes_global, %eax
    LKMC_ASSERT_EQ_32(%eax, $2)

    mov yes_local, %eax
    LKMC_ASSERT_EQ_32(%eax, $3)

LKMC_EPILOGUE
