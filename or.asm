; # OR

%include "lib/common_nasm.inc"

ENTRY
    mov ax, 0x00FF
    or  ax, 0x0F0F
    ASSERT_EQ ax, 0x0FFF
EXIT
