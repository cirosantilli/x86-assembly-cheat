; # include

    ; Same as C #include: copy pastes file data.

    ; The common standard extension is `.inc`.

#include <lkmc.h>

LKMC_PROLOGUE
    mov eax, 1
    %include "included.inc"
    LKMC_ASSERT_EQ(%eax, $2)
LKMC_EPILOGUE
