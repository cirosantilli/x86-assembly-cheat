/*
# Current address

# dot

# .

    http://stackoverflow.com/questions/8987767/is-there-a-symbol-that-represents-the-current-address-in-gnu-gas-assembly
*/

#include "lib/common_gas.h"

/* x points to its own address. */
x: .long .
ENTRY
    mov x, %eax
    mov $x, %ebx
    ASSERT_EQ(%ebx, %eax)
EXIT
