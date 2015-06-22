/*
# jmp indirect

    The asterisk jumps to the data at the address pointed to.
*/

#include "lib/asm_io_s.h"

.section .rodata
    symbol0: .int label0
ENTRY
    /* Sanity check: the label was stored OK in data. */
    mov symbol0, %eax
    ASSERT_EQ($label0)

    jmp *symbol0
    ASSERT_FAIL
    label0:

    EXIT
