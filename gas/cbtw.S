/*
# cbtw

    Intel `cbw`.

    One of the few instructions whose names differ a lot:
    https://sourceware.org/binutils/docs/as/i386_002dMnemonics.html

    http://stackoverflow.com/questions/6555094/what-does-cltq-do-in-assembly
*/

#include "lib/common_gas.h"

LKMC_PROLOGUE
    mov $0, %eax
    mov $1, %al
    cbw
    LKMC_ASSERT_EQ_32(%eax, $1)

    mov $0, %eax
    mov $-1, %al
    cbw
    LKMC_ASSERT_EQ_32(%eax, $0xFFFF)

LKMC_EPILOGUE
