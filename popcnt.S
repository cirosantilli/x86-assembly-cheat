# # POPCNT

# # Hamming distance

    # Count the number of 1 bits.

#include <lkmc.h>

LKMC_PROLOGUE
    mov $5, %ebx
    popcnt eax, ebx
    LKMC_ASSERT_EQ_32(%eax, $2)

    mov $9, %ebx
    popcnt eax, ebx
    LKMC_ASSERT_EQ_32(%eax, $2)

LKMC_EPILOGUE
