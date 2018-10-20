; # scas

    ; Compare array and a.

%include "lib/common_nasm.inc"

section .data

    bs4 db 0, 1, 2, 3
    bs4_2 db 0, 0, 0, 0

ENTRY

    mov edi, bs4
    mov byte [bs4], 0
    mov byte [bs4 + 1], 1

    cld
    mov al, 0
    scasb
    ASSERT_FLAG jz
    mov eax, edi
    sub eax, bs4
    ASSERT_EQ eax, 1

    std
    mov al, 2
    scasb
    ASSERT_FLAG jnz
    mov eax, edi
    sub eax, bs4
    ASSERT_EQ eax, 0

EXIT
