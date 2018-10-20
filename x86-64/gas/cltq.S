/* Same as intel cdqe: http://stackoverflow.com/questions/6555094/what-does-cltq-do-in-assembly/31114310#31114310 */

#include "lib/common_gas.h"

ENTRY
    /* Negative sign extend. */
    mov $0x1234567800000000, %rax
    mov $0x80000000, %eax
    cltq
    mov $0xFFFFFFFF80000000, %rbx
    ASSERT_EQ(%rax, %rbx)

    /* Positive sign extend. */
    mov $0x1234567800000000, %rax
    mov $0x40000000, %eax
    cltq
    mov $0x0000000040000000, %rbx
    ASSERT_EQ(%rax, %rbx)

    /* GAS also accepts the Intel syntax. */
    mov $0x1234567800000000, %rax
    mov $0x80000000, %eax
    cdqe
    mov $0xFFFFFFFF80000000, %rbx
    ASSERT_EQ(%rax, %rbx)

EXIT
