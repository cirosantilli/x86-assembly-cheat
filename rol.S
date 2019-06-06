# # rol

# # ror

# # Rotate

    # The bit that exists enters from the other side.

    # No corresponding C intruction.

#include <lkmc.h>

LKMC_PROLOGUE
        movl $0x81,%eax

        # axl = 03h, CF = 1
        rolb $1,%al
        ASSERT_FLAG jc
        LKMC_ASSERT_EQ_32(%al, $3)

        # axl = 04h, CF = 0
        rolb $1,%al
        LKMC_ASSERT_EQ_32(%al, $6)
        ASSERT_FLAG jnc

        # axl = 03h, CF = 0
        rorb $2,%al
        ASSERT_FLAG jc
        LKMC_ASSERT_EQ_32(%al, $0x81)

        # axl = 81h, CF = 1
        rorb $1,%al
        ASSERT_FLAG jc
        LKMC_ASSERT_EQ_32(%al, $0x0C0)

    # Rotate with cf inserted

        movl $0x81,%eax
        clc

        rclb $1,%al
        LKMC_ASSERT_EQ_32(%al, $2)
        ASSERT_FLAG jc

        rclb $1,%al
        LKMC_ASSERT_EQ_32(%al, $5)
        ASSERT_FLAG jnc

        rcrb $2,%al
        LKMC_ASSERT_EQ_32(%al, $0x81)
        ASSERT_FLAG jnc

        rcrb $1,%al
        LKMC_ASSERT_EQ_32(%al, $0x40)
        ASSERT_FLAG jc

LKMC_EPILOGUE
