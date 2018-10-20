/*
# macro

    Avoid it, use `cpp` instead which is more powerful.
*/

#include "lib/common_gas.h"

ENTRY

    /*
    # Labels in macros

        If you are going to use a macro with a label inside it many times
        you need some way of ensuring that this label will be unique
        for each macro invocation.
    */

        /* # \@ technique. Not 100% safe, but good enough. */

            .macro LOCAL_AT
                jmp _local_\@_ok
                    call assert_fail
                _local_\@_ok:
            .endm

            LOCAL_AT
            LOCAL_AT

        /* The best technique is to use LOCAL from .altmacro. */

    /*
    Unlike the C preprocessor, GAS macros don't treat string literals
    magically and expand inside them as well.
    */

        .macro STRING_EXPAND x
            .ascii "\x"
        .endm
        mov s, %al
        ASSERT_EQ($0x61, %al)

EXIT

.data
    s:
        STRING_EXPAND a
