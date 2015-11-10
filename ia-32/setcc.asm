; # setXX

    ; Set a byte if a given condition holds.

    ; Conditions names are like the ones for the `Jcc` instructions,
    ; althogh there are less possible suffixes.

    ; Compilers produce this instruction in branches if possible,
    ; as it avoid the cost of branch misprediction:
    ; https://software.intel.com/en-us/articles/branch-and-loop-reorganization-to-prevent-mispredicts
    ; CMOVcc achieves a similar effet.

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
