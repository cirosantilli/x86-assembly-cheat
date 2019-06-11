# # push

# # pop

    # For-newb explanation and rationale:
    # http://stackoverflow.com/questions/4584089/what-is-the-function-of-push-pop-registers-in-x86-assembly/33583134#33583134

    # # How many bytes are pushed

        # Hard to determine. Read the manual.

        # It is usually always 4 for 32-bits, and smaller operands are zero extended.

        # It also depends on:

        # - 0x66 prefix
        # - flags of the code segment descriptor (not accessible from userland)

        # `push byte` is only an error checked version of `push`:
        # http://stackoverflow.com/questions/718105/how-to-translate-nasm-push-byte-to-gas-syntax/33614224#33614224
        # But `push word` does add the 0x66 prefix.

        # Impossible to push a single byte:
        # http://stackoverflow.com/questions/2586591/why-is-it-not-possible-to-push-a-byte-onto-a-stack-on-pentium-ia-32

#include <lkmc.h>

LKMC_PROLOGUE

    mov %esp, %eax
    pushl $1
    subl %esp, %eax
    LKMC_ASSERT_EQ_32(%eax, $4)
    mov (%esp), %eax
    LKMC_ASSERT_EQ_32(%eax, $1)

    mov %esp, %eax
    pushb $2
    subl %esp, %eax
    LKMC_ASSERT_EQ_32(%eax, $4)
    mov (%esp), %eax
    LKMC_ASSERT_EQ_32(%eax, $2)

    popl %eax
    LKMC_ASSERT_EQ_32(%eax, $2)

    popl %eax
    LKMC_ASSERT_EQ_32(%eax, $1)

    # Manual equivalent.

    subl $8, %esp
    mov $2, (%esp)
    mov $1, 4(%esp)

    mov (%esp), %eax
    LKMC_ASSERT_EQ_32(%eax, $2)
    mov 4(%esp), %eax
    LKMC_ASSERT_EQ_32(%eax, $1)
    addl $8, %esp

LKMC_EPILOGUE
