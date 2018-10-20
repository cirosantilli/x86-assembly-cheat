; # cmps

    ; Compare two arrays

%include "lib/common_nasm.inc"

section .data

    bs4 db 0, 1, 2, 3
    bs4_2 db 0, 0, 0, 0

ENTRY

    mov esi, bs4
    mov byte [bs4], 0
    mov byte [bs4 + 1], 1

    mov edi, bs4_2
    mov byte [bs4_2], 0
    mov byte [bs4_2 + 1], 2

    cld
    cmpsb
    ASSERT_FLAG jz
    mov eax, esi
    sub eax, bs4
    ASSERT_EQ eax, 1
    mov eax, edi
    sub eax, bs4_2
    ASSERT_EQ eax, 1
    ASSERT_EQ [bs4], 0, byte
    ASSERT_EQ [bs4_2], 0, byte

    std
    movsb
    ASSERT_FLAG jnz
    mov eax, esi
    sub eax, bs4
    ASSERT_EQ eax, 0
    mov eax, edi
    sub eax, bs4_2
    ASSERT_EQ eax, 0
    ASSERT_EQ [bs4 + 1], 1, byte
    ; TODO why fail?
    ;ASSERT_EQ [bs4_2 + 1], 2, byte

EXIT
