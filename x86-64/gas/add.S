#include "lib/common_gas.h"

ENTRY
    mov $0xFFFFFFFF, %rax
    add $1, %rax
    /* mov is one of the very few instructions that can encode imm64.
     * In particular, cmp which ASSERT_EQ uses cannot, so we have to
     * mov into rbx first.
     */
    mov $0x100000000, %rbx
    ASSERT_EQ(%rax, %rbx)
EXIT
