#include "lib/asm_io_s.h"

.type asm_main, @function
ENTRY
    nop
.type sym, @function
.global sym
sym:
    PRINT_STRING_LITERAL("hello world")
    EXIT
.size sym, . - sym
.size asm_main, . - asm_main
