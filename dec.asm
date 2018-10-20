; Decrement: i--.

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 1
    ; eax--
    dec eax
    ASSERT_EQ eax, 0
EXIT
