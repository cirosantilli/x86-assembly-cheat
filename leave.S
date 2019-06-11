# # leave

    # `leave` is equivalent to:

        #mov esp, ebp
        #pop ebp

    # Which implies in the delocation of 2 dwords:

#include <lkmc.h>

LKMC_PROLOGUE

    mov %esp, %eax
    enter $0, $8
    subl %esp, %eax
    LKMC_ASSERT_EQ_32(%eax, $12)

    # Modify 1st local var.
    mov $1, -4(%ebp)
    # Modify 2nd local var.
    mov $2, -8(%ebp)

    leave

LKMC_EPILOGUE
