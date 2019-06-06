# Signed division:
#
#     eax = edx:eax / SRC
#     edx = edx:eax % SRC
#
# div can be used to calculate modulus, but GCC does not use it becaues it is slow, 
# and choses alternative techniques instead instead:
# http://stackoverflow.com/questions/4361979/how-does-the-gcc-implementation-of-module-work-and-why-does-it-not-use-the

#include <lkmc.h>

LKMC_PROLOGUE
    movl $5, %eax
    movl $0, %edx
    movl $2, %ecx
    divl %ecx
    LKMC_ASSERT_EQ_32(%eax, $2)
    LKMC_ASSERT_EQ_32(%edx, $1)

    # 8 bit
    movl $0, %eax
    movw $0x101, %ax
    movb $2, %cl
    divb %cl
    LKMC_ASSERT_EQ_32(%eax, $0x180)

    # 16 bit
    movl $0, %eax
    movl $0, %edx
    movw $1, %ax
    movw $1, %dx
    movw $2, %cx
    divw %cx
    LKMC_ASSERT_EQ_32(%eax, $0x8000)
    LKMC_ASSERT_EQ_32(%edx, $1)

    # 32 bit
    movl $1, %eax
    movl $1, %edx
    movl $2, %ecx
    divl %ecx
    LKMC_ASSERT_EQ_32(%eax, $0x80000000)
    LKMC_ASSERT_EQ_32(%edx, $1)

    # # Division by zero

    # # Division overflow

        # If either

        # - divisor == 0
        # - result > output register size

        # A divide error exception occurs.
        # It then gets handled by the interrupt service 0.

        # Both 0 division and overflow are treated exactly the same!

        # Linux treats this by sending a signal to the process and killing it.

        # Minimal 16-bit example of handling the interrupt:
        # https://github.com/cirosantilli/x86-bare-metal-examples/blob/9e58c1dc656dab54aa69daa38f84eb8c0aa6151e/idt_zero_divide.S

            # Output does not fit into edx.
            #mov eax, 0
            #mov edx, 1
            #mov ecx, 1
            #div ecx

            # Division by zero.
            #mov eax, 1
            #mov edx, 0
            #mov ecx, 0
            #div ecx

        # There is no immediate version:
        # http://stackoverflow.com/questions/4529260/mul-instruction-doesnt-support-an-immediate-value

LKMC_EPILOGUE
