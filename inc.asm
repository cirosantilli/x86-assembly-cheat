; Increment, i++.

%include "lib/asm_io.inc"

ENTRY
    mov eax, 0
    ; eax++
    inc eax
    ASSERT_EQ 1
    EXIT
