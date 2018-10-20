; # POPCNT

; # Hamming distance

    ; Count the number of 1 bits.

%include "lib/common_nasm.inc"

ENTRY
    mov ebx, 5
    popcnt eax, ebx
    ASSERT_EQ eax, 2

    mov ebx, 9
    popcnt eax, ebx
    ASSERT_EQ eax, 2

EXIT
