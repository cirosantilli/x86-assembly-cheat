; # lods

    ; Load into a and move `esi`.

%include "lib/asm_io.inc"

section .data

    bs4 db 0, 1, 2, 3
    bs4_2 db 0, 0, 0, 0

ENTRY

    mov esi, bs4
    mov byte [bs4], 0
    mov byte [bs4 + 1], 1

    cld
    ; Increase ESI
    lodsb
    ASSERT_EQ al, 0
    mov eax, esi
    sub eax, bs4
    ASSERT_EQ 1

    std
    ; Decrease ESI
    lodsb
    ASSERT_EQ al, 1
    mov eax, esi
    sub eax, bs4
    ASSERT_EQ 0

    EXIT
