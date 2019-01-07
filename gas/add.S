/* # GAS add
 *
 * Generic GAS basics go here!
 */

#include "lib/common_gas.h"

.data
    myint: .long 0x12345678

ENTRY
    /* Immediates and registers. */
    mov $1, %eax
    add $2, %eax
    ASSERT_EQ($3, %eax)

    /* Memory. */
    mov myint, %eax
    ASSERT_EQ($0x12345678, %eax)

    /* Pointer. */
    mov $myint, %eax
    movl $0x11112222, (%eax)
    ASSERT_EQ_SIZE($0x11112222, myint, l)
EXIT
