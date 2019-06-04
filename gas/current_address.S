/*
# Current address

# dot

# .

    http://stackoverflow.com/questions/8987767/is-there-a-symbol-that-represents-the-current-address-in-gnu-gas-assembly
*/

#include "lib/common_gas.h"

/* x points to its own address. */
x: .long .
LKMC_PROLOGUE
    mov x, %eax
    mov $x, %ebx
    LKMC_ASSERT_EQ(%eax, %ebx)
LKMC_EPILOGUE
