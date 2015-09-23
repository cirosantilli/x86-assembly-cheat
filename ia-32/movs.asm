; # movs

    ; Copy one string into another.

%include "lib/asm_io.inc"

section .data

    bs4 db 0, 1, 2, 3
    bs4_2 db 0, 0, 0, 0

ENTRY

    mov edi, bs4_2
    mov esi, bs4
    mov byte [bs4], 0
    mov byte [bs4 + 1], 1

    cld
    movsb
    ASSERT_EQ [bs4_2], 0, byte
    mov eax, esi
    sub eax, bs4
    ASSERT_EQ 1
    mov eax, edi
    sub eax, bs4_2
    ASSERT_EQ 1

    std
    movsb
    ASSERT_EQ [bs4_2 + 1], 1, byte
    mov eax, esi
    sub eax, bs4
    ASSERT_EQ 0
    mov eax, edi
    sub eax, bs4_2
    ASSERT_EQ 0

    EXIT
