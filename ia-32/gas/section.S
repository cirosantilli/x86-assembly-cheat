/*
# .section

    Create ELF sections.

# .segment

    Same as `.section`.

    So don't use, since what we actually create are sections,
    not segments, which are created by the linker.

# .text

    TODO vs `.section .text`

# .data

    Creates a data section.

    TODO vs `.section .data`
    http://stackoverflow.com/questions/21606690/whats-difference-between-section-data-and-just-data-in-gas-coding

    Actually looks like the exact same: even with `.section .data`,
    the section is treated magically, e.g. gets W flag.

# Section flags

    Specified as:

        .section .custom, "awx"

    This would be an Allocatable Writable and eXecutable section.
*/

#include "lib/asm_io_s.h"

.section .data
    i: .int 1
.data
    j: .int 1
ENTRY
    mov i, %eax
    ASSERT_EQ($1)
    EXIT
