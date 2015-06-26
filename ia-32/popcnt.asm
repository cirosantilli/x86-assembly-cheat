; # POPCNT

; # Hamming distance

    ; Count the number of 1 bits.

%include "lib/asm_io.inc"

ENTRY
    mov ebx, 5
    popcnt eax, ebx
    ASSERT_EQ 2

    mov ebx, 9
    popcnt eax, ebx
    ASSERT_EQ 2

    EXIT
