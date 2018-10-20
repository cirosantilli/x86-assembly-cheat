/*
# cbtw

    Intel `cbw`.

    One of the few instructions whose names differ a lot:
    https://sourceware.org/binutils/docs/as/i386_002dMnemonics.html

    http://stackoverflow.com/questions/6555094/what-does-cltq-do-in-assembly
*/

#include "lib/common_gas.h"

ENTRY
    mov $0, %eax
    mov $1, %al
    cbw
    ASSERT_EQ($1, %eax)

    mov $0, %eax
    mov $-1, %al
    cbw
    ASSERT_EQ($0xFFFF, %eax)

EXIT
