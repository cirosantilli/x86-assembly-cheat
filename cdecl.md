# cdecl

TODO move in with the code.

De facto standard C calling convention used by GCC.

Does not have a formal standard, so different compilers may have incompatible versions of cdecl.

-   return address is put on the stack (usually via `call`/`ret` instructions)

-   arguments are passed on stack

    -   always pass `dword` arguments

        If you want to pass a single byte, first convert to dword

    -   arguments are put on stack in inverse order from declaration

        This allows for functions with arbitrary numbers of args such as `printf`:

        Like this the format string will always be on the same position (at the end).

    -   arguments are not popped before return.

        If you want to use their values, use ESP pointer

-   return value is put in:

    -   EAX if integer or pointer.

        If 64-bit, put in edx:eax.

    -   ST0 x87 register if floating point.

    -   for structures, there is some divergence between different compilers.

        For small structures, some compilers may choose to return the struct on multiple registers such as EAX and EDX.

        For larger structures which do not fit into registers, a common technique is for the compiler to automatically add a hidden pointer parameter to the function and automatically make the caller allocate memory and pass a pointer to that memory.

-   EAX, ECX and EDX may change after the call and must be saved by the caller if he wants to keep those.

    All other registers are guaranteed not to change after the call. They may be temporarily changed inside

-   the caller clears the argument heap

    This generates more code since programs usually make several for each definition,

    This allows for functions with variable number or arguments such as `printf`, because then only the caller knows how many args he put on the stack.

    PASCAL for example follows a function clear argument stack convention.
