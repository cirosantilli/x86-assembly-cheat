/*
# local symbol

# .L

    Symbols that start with `.L` don't appear at all on the ELF output.

    By default, symbols do appear on ELF, but are local.

# .global

    To make symbols visible, you must use `.global`.

# .local

    TODO what is the effect of this?

    Variables marked as such were no different than those without.
*/

#include "lib/asm_io_s.h"

.data
    s:
        .int 1
    .Ls:
        .int 2
    .global g
    g:
        .int 3
    .local l
    l:
        .int 4
ENTRY
    PRINT_INT(s)
    PRINT_INT(.Ls)
    PRINT_INT(g)
    PRINT_INT(l)

    /* Same for labels. */
    lbl:
    .Llbl:

    EXIT
