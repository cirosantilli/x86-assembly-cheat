/* # GAS add
 *
 * Generic GAS basics go here!
 */

#include "lib/common_gas.h"

.data
    myint: .long 0x12345678

LKMC_PROLOGUE
    /* Immediates and registers. */
    mov $1, %eax
    add $2, %eax
    LKMC_ASSERT_EQ(%eax, $3)

    /* Memory. */
    mov myint, %eax
    LKMC_ASSERT_EQ(%eax, $0x12345678)

    /* Pointer. */
    mov $myint, %eax
    movl $0x11112222, (%eax)
    ASSERT_EQ_SIZE($0x11112222, myint, l)
LKMC_EPILOGUE
