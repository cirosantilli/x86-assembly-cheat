; Subtraction.

%include "lib/asm_io.inc"

ENTRY
    mov eax, 1
    sub eax, 1
    ASSERT_EQ 0
    EXIT
