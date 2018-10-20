; # bswap

    ; Little endian <=> big endian.

%include "lib/common_nasm.inc"

ENTRY

    mov eax, 0x12345678
    bswap eax
    ASSERT_EQ eax, 0x78563412

EXIT
