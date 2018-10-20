; # movs

    ; Copy one string into another.

    ; Input pointed by esi, output by edi.

%include "lib/common_nasm.inc"

section .data

    src db 0, 1
    dest db 2, 3

ENTRY

    mov esi, src
    mov edi, dest

    cld
    movsb
    ASSERT_EQ [dest], 0, byte
    mov eax, esi
    sub eax, src
    ASSERT_EQ eax, 1
    mov eax, edi
    sub eax, dest
    ASSERT_EQ eax, 1

    std
    movsb
    ASSERT_EQ [dest + 1], 1, byte
    mov eax, esi
    sub eax, src
    ASSERT_EQ eax, 0
    mov eax, edi
    sub eax, dest
    ASSERT_EQ eax, 0

EXIT
