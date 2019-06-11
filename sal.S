# # SAL

# # SAR

# # Arithmetic shift

# # Signed shift

    # Mnemonics: Shift Arithmetic Left and Right

    # Application: signed multiply and divide by powers of 2.

    # Keeps correct sign, and carries rest.

    # Does not exist in C, for which signed shift is undetermined behavior.
    # But does exist in Java via the `>>>` operator.

    # C compilers do use it however.

#include <lkmc.h>

LKMC_PROLOGUE
    mov $-1, %eax
    # eax = -2, CF = 1
    sall %eax
    ASSERT_FLAG jc
    LKMC_ASSERT_EQ_32 eax, -2

    #ax < 0, CF = 0
    sarl %eax
    LKMC_ASSERT_EQ_32 eax, -1

    # Cannot replace div for negative odd numbers directly
    # as it rounds do -infinity, while div rounds to 0. TODO check.
    sarl %eax
    LKMC_ASSERT_EQ_32 eax, -1

LKMC_EPILOGUE
