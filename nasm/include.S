# # include

    # Same as C #include: copy pastes file data.

    # The common standard extension is `.inc`.

#include <lkmc.h>

LKMC_PROLOGUE
    mov $1, %eax
    #include "included.inc"
    LKMC_ASSERT_EQ_32(%eax, $2)
LKMC_EPILOGUE
