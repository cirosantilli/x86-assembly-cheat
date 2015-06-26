; # bswap

    ; Little endian <=> big endian.

%include "lib/asm_io.inc"

ENTRY

    mov eax, 0x12345678
    bswap eax
    ASSERT_EQ 0x78563412

    EXIT
