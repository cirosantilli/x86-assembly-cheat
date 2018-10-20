; # NOT

%include "lib/common_nasm.inc"

ENTRY
    mov al, 0x0F0
    not al
    ASSERT_EQ al, 0x0F
EXIT
