# Signed multiply.
#
# Has many more forms than the unsigned version, 
# including immediate and up to three arguments.

#include <lkmc.h>

LKMC_PROLOGUE
    # eax = ebx * 3
    movl $0, %eax
    movl $2, %ebx
    imull $3, %ebx, %eax
    LKMC_ASSERT_EQ_32(%eax, $6)

    # eax = eax * eax
    movl $2, %eax
    movl $3, %ebx
    imull %ebx
    LKMC_ASSERT_EQ_32(%eax, $6)
    LKMC_ASSERT_EQ_32(%ebx, $3)

    # eax = eax * eax
    movl $-2, %eax
    imull %eax
    LKMC_ASSERT_EQ_32(%eax, $4)

    # eax = eax * 3
    movl $2, %eax
    imull $3, %eax
    LKMC_ASSERT_EQ_32(%eax, $6)

LKMC_EPILOGUE
