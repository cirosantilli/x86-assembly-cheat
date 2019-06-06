# # equ

    # http://stackoverflow.com/a/33148242/895245

#include <lkmc.h>

DATA
    .global x
    x: equ 1 + 1
    y: dd 1 + 1
LKMC_PROLOGUE
    movl $x, %eax
    LKMC_ASSERT_EQ_32(%eax, $2)
    movl y,%eax
    LKMC_ASSERT_EQ_32(%eax, $2)
LKMC_EPILOGUE
