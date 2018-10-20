/* https://stackoverflow.com/questions/6555094/what-does-cltq-do-in-assembly/31114310#31114310 */

#include "lib/common_gas.h"

ENTRY
    /* cwtl: same as Intel cwde */
    mov $0x12345678, %eax
    mov $0x8000, %ax
    cwtl
    ASSERT_EQ($0xFFFF8000, %eax)

    /* cbtw: same as Intel cbw */
    mov $0x12345678, %eax
    mov $0x80, %al
    cbtw
    ASSERT_EQ($0x1234FF80, %eax)

EXIT
