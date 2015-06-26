; # NOT

%include "lib/asm_io.inc"

ENTRY
    mov al, 0x0F0
    not al
    ASSERT_EQ al, 0x0F
    EXIT
