# # SHL

# # SHR

    # Unsigned shifts.

    # Application:

    # -   quick unsigned multiply and divide by powers of 2.

#include <lkmc.h>

LKMC_PROLOGUE
    mov $0x81, %eax

    shlb %al
    ASSERT_FLAG jc
    LKMC_ASSERT_EQ_32(%eax, $2)

    shlb %al
    LKMC_ASSERT_EQ_32(%eax, $4)
    ASSERT_FLAG jnc

    shrb %al
    LKMC_ASSERT_EQ_32(%eax, $2)
    ASSERT_FLAG jnc

    mov $2, %cl
    shrb %cl, %al
    ASSERT_FLAG jc
    LKMC_ASSERT_EQ_32(%eax, $0)

    #ERROR:
    #shift must be either const or in `cl`
    #mov bl, 2
    #shr ax, bl

LKMC_EPILOGUE
