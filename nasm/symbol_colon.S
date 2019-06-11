# The colon after a simbol name is optional in NASM.
#
# http://stackoverflow.com/questions/8006365/is-there-a-difference-between-using-or-not-a-colon-after-symbol-name-definitions

#include <lkmc.h>

.data
    # With colon.
    x: .byte 1
    # Without colon.
    y db 2
LKMC_PROLOGUE
    mov $0, %eax
    mov x, %al
    LKMC_ASSERT_EQ_32(%eax, $1)
    mov y, %al
    LKMC_ASSERT_EQ_32(%eax, $2)
LKMC_EPILOGUE
