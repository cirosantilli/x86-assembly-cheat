; # leave

    ; `leave` is equivalent to:

        ;mov esp, ebp
        ;pop ebp

    ; Which implies in the delocation of 2 dwords:

#include <lkmc.h>

LKMC_PROLOGUE

    mov eax, esp
    enter 8, 0
    sub eax, esp
    LKMC_ASSERT_EQ(%eax, $12)

    ; Modify 1st local var.
    mov dword [ebp - 4], 1
    ; Modify 2nd local var.
    mov dword [ebp - 8], 2

    leave

LKMC_EPILOGUE
