; # POPCNT

; # Hamming distance

    ; Count the number of 1 bits.

#include <lkmc.h>

LKMC_PROLOGUE
    mov ebx, 5
    popcnt eax, ebx
    LKMC_ASSERT_EQ_32(%eax, $2)

    mov ebx, 9
    popcnt eax, ebx
    LKMC_ASSERT_EQ_32(%eax, $2)

LKMC_EPILOGUE
