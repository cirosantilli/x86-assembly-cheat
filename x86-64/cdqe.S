# Double to quad sign extend.
#
# http://stackoverflow.com/questions/6555094/what-does-cltq-do-in-assembly/31114310#31114310

#include <lkmc.h>

LKMC_PROLOGUE
    # Negative sign extend.
    mov $0x12345678_00000000, %rax
    mov $0x80000000, %eax
    cdqe
    mov $0xFFFFFFFF_80000000, %rbx
    LKMC_ASSERT_EQ(%rax, %rbx)

    # Positive sign extend.
    mov $0x12345678_00000000, %rax
    mov $0x40000000, %eax
    cdqe
    mov $0x00000000_40000000, %rbx
    LKMC_ASSERT_EQ(%rax, %rbx)

LKMC_EPILOGUE
