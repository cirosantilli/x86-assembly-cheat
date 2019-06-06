# # add
#
# Let's use the venerable add instruction as an intro to
# some important language examples.

#include <lkmc.h>

DATA
    myint dd 0x1234_5678

LKMC_PROLOGUE
    # Immediate and register.
    # eax = 1
    movl $1, %eax
    # eax += 2
    addl $2, %eax
    # assert(eax == 3)
    LKMC_ASSERT_EQ_32(%eax, $3)

    # Register and register.
    movl $1, %eax
    movl $2, %ebx
    addl %ebx, %eax
    LKMC_ASSERT_EQ_32(%eax, $3)

    # Memory and register.
    movl myint, %eax
    LKMC_ASSERT_EQ_32(%eax, $0x1234_5678)

    # Memory and immediate.
    addl $1, myint
    LKMC_ASSERT_EQ_32 [myint], 0x1234_5679, dword

    # ERROR: second register must be same size
    #add ax, al
    #add ax, eax
LKMC_EPILOGUE
