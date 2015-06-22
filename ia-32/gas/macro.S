/*
# macro

    Avoid it, use `cpp` instead which is more powerful.
*/

#include "lib/asm_io_s.h"

ENTRY

    /*
    # Labels in macros

        If you are going to use a macro with a label inside it many time you need some way of 
        ensuring that this label will be unique for each macro invocation.
    */

        /* \@ technique. Not 100% safe, but good enough. */

            .macro local_at
                jmp _local_\@_ok
                    call assert_fail
                _local_\@_ok:
            .endm

            local_at
            local_at

        /*
        # altmacro

            Enables the alternate macro mode from now on.

            This adds extra capabilities to macros:

            - LOCAL
            - % string evaluation
        */

            /*
            # LOCAL

                Impossible to clash.

                Needs `.altmacro` to work.


                Can be turned off with `.noaltmacro`.

                Can also be set as a command line option `--alternate`.
            */

                .altmacro
                .macro local_keyword a="%eax"
                    LOCAL ok
                    mov $1, %eax
                    jmp ok
                        call assert_fail
                    ok:
                .endm

                local_keyword
                local_keyword

            /*
            # % string evaluation

                TODO how to use this?

            */

                /*
                .altmacro
                .macro percent_eval
                    mov %1+1, %eax
                .endm
                ASSERT_EQ($2)
                */

    /*
    # \@

    # @

    # at sign

        Stores the total number of any macro executed up to now.

        Can only be used inside macros.

        Application: create local labels inside macros.
    */

        .macro count
            mov $\@, %eax
        .endm

        count
        mov %eax, %ebx
        count
        sub %ebx, %eax
        ASSERT_EQ($1)

    EXIT
