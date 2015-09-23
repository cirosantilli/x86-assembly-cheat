/*
# altmacro

    Enables the alternate macro mode from now on.

    Can also be set as a command line option `--alternate`.

    This adds extra capabilities to macros:

    - LOCAL
    - % string evaluation

# noaltmacro

    Turned off `.altmacro`.
*/

#include "lib/asm_io_s.h"

ENTRY

    .altmacro

    /*
    With altmacro, \ is not needed to expand the arguments.

    TODO undocumented?
    */

        .macro STRING_ARG x
            mov x, %eax
        .endm
        mov $0, %eax
        STRING_ARG $1
        ASSERT_EQ($1)

        /* But escaping it still works. */
        .macro STRING_ARG_BACKSLASH x
            mov \x, %eax
        .endm
        mov $0, %eax
        STRING_ARG $1
        ASSERT_EQ($1)

        /* TODO how to avoid expansion? */

    /*
    # LOCAL

        Generates local labels that are impossible to clash.
    */

        .macro LOCAL_KEYWORD a="%eax"
            LOCAL ok
            mov $1, %eax
            jmp ok
                call assert_fail
            ok:
        .endm

        LOCAL_KEYWORD
        LOCAL_KEYWORD

    /*
    # % evaluation

        Appears to work only on argumetns passed or their default values.
    */

        .macro PERCENT x
            mov $\x, %eax
        .endm
        mov $0, %eax
        PERCENT %1+1
        ASSERT_EQ($2)

        .macro PERCENT_DEFAULT x=%1+1
            mov $\x, %eax
        .endm
        mov $0, %eax
        PERCENT_DEFAULT 1
        ASSERT_EQ($1)
        PERCENT_DEFAULT
        ASSERT_EQ($2)

        /*
        This is a horrible feature as it makes it impossible to pass registers
        as arguments to altmacros without special escaping care...

        http://stackoverflow.com/questions/19776992/gas-altmacro-macro-with-a-percent-sign-in-a-default-parameter-fails-with-oper
        */

            .macro PERCENT_ESCAPE x
                mov \x, %eax
            .endm
            mov $0, %eax
            mov $1, %ebx
            PERCENT_ESCAPE <%ebx>
            ASSERT_EQ($1)

            .macro PERCENT_ESCAPE_DEFAULT x=<%ebx>
                mov \x, %eax
            .endm
            mov $0, %eax
            mov $1, %ebx
            PERCENT_ESCAPE_DEFAULT
            ASSERT_EQ($1)


        /* TODO application? */

    .noaltmacro

    EXIT
