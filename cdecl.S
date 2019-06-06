# # cdecl

#include <lkmc.h>

LKMC_PROLOGUE

    # Recursive factorial.

        pushl $5
        call factorial_rec_cdecl
        # We must clean up the argument stack ourselves.
        # This allows for varargs like `printf`.
        addl $4, %esp
        LKMC_ASSERT_EQ_32(%eax, $120)

        pushl $1
        call factorial_rec_cdecl
        addl $4, %esp
        LKMC_ASSERT_EQ_32(%eax, $1)

    # Non-recursive factorial.

        pushl $5
        call factorial_norec_cdecl
        addl $4, %esp
        LKMC_ASSERT_EQ_32(%eax, $120)

        pushl $1
        call factorial_norec_cdecl
        addl $4, %esp
        LKMC_ASSERT_EQ_32(%eax, $1)

LKMC_EPILOGUE

# Recursive factorial. cdecl calling convention.
factorial_rec_cdecl: 
    enter $0, $0
    # -  `[ebp - 4]` the first local variable
    # -  `[ebp]` is the address to return to pushed by `call`
    # -  `[ebp + 4]` is the old `esp` pushed by `enter` before more local variables are pushed
    # -  `[ebp + 8]` first argument passed. For this to be true for any number of arguments, 
    #    they must be pushed right-to-left.
    # -  `[ebp + 12]` second argument passed
    cmpl $1, 8(%ebp)
    je factorial_rec_cdecl_base
        movl 8(%ebp), %ebx
        decl %ebx
        pushl %ebx
        call factorial_rec_cdecl
        addl $4, %esp
        mull 8(%ebp)
    jmp factorial_rec_cdecl_return
    factorial_rec_cdecl_base: 
        movl $1, %eax
    factorial_rec_cdecl_return: 
    leave
    ret

# Non_recursive factorial. cdecl calling convention.
factorial_norec_cdecl: 
    # No need for `enter` since we are non-recursive.
    # This does not affect in any way the ccecl calling convertion:
    # enter and leave are invisible from the outside.
    movl 4(%esp), %ecx
    movl $1, %eax
    factorial_norec_cdecl_loop: 
        mull %ecx
    loop factorial_norec_cdecl_loop
    ret
