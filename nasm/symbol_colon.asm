; The colon after a simbol name is optional in NASM.
;
; http://stackoverflow.com/questions/8006365/is-there-a-difference-between-using-or-not-a-colon-after-symbol-name-definitions

#include <lkmc.h>

DATA
    ; With colon.
    x: db 1
    ; Without colon.
    y db 2
LKMC_PROLOGUE
    mov eax, 0
    mov al, [x]
    LKMC_ASSERT_EQ_32(%eax, $1)
    mov al, [y]
    LKMC_ASSERT_EQ_32(%eax, $2)
LKMC_EPILOGUE
