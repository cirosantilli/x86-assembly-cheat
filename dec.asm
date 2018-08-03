; Decrement: i--.

%include "lib/asm_io.inc"

ENTRY
    mov eax, 1
    ; eax--
    dec eax
    ASSERT_EQ 0
    EXIT
