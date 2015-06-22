; # setXX

    ; Set a byte if a given condition holds.

    ; Conditions names are like the ones for the `Jcc` instructions,
    ; althogh there are less possible suffixes.

%include "lib/asm_io.inc"

ENTRY

    mov al, 0

    stc
    setc al
    ASSERT_EQ 1

    clc
    setc al
    ASSERT_EQ 0

    ; ERROR: only for 8 bit registers or memory.
    ;setc eax

    EXIT
