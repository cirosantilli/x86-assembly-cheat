; # SETcc

    ; Set version of CMOVcc

%include "lib/asm_io.inc"

ENTRY

    mov eax, 0

    stc
    setc al
    ASSERT_EQ 1

    clc
    setc al
    ASSERT_EQ 0

    ; ERROR: only for 8 bit registers or memory.
    ;setc eax

    EXIT
