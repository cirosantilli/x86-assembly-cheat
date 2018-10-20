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

#include "lib/common_gas.h"

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
        ASSERT_EQ($1, %eax)

        /* But escaping it still works. */
        .macro STRING_ARG_BACKSLASH x
            mov \x, %eax
        .endm
        mov $0, %eax
        STRING_ARG $1
        ASSERT_EQ($1, %eax)

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
    # %

    # Percent

        Appears to work only on arguments passed or their default values.
    */

            .macro PERCENT x
                mov $\x, %eax
            .endm
            mov $0, %eax
            PERCENT %1+1
            ASSERT_EQ($2, %eax)

            .macro PERCENT_DEFAULT x=%1+1
                mov $\x, %eax
            .endm
            mov $0, %eax
            PERCENT_DEFAULT 1
            ASSERT_EQ($1, %eax)
            PERCENT_DEFAULT
            ASSERT_EQ($2, %eax)

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
            ASSERT_EQ($1, %eax)

            .macro PERCENT_ESCAPE_DEFAULT x=<%ebx>
                mov \x, %eax
            .endm
            mov $0, %eax
            mov $1, %ebx
            PERCENT_ESCAPE_DEFAULT
            ASSERT_EQ($1, %eax)

        /*
        One alternative if we are sure that the argument is a register,
        is to put the percent inside the macro:
        */

            .macro PERCENT_ESCAPE_REG x
                mov %x, %eax
            .endm
            mov $0, %eax
            mov $1, %ebx
            PERCENT_ESCAPE_REG ebx
            ASSERT_EQ($1, %eax)

        /* But this has the downside that we cannot pass immediates like `$1` anymore */

            /*PERCENT_ESCAPE_REG $1*/

        /* TODO application? */

    .noaltmacro

EXIT
