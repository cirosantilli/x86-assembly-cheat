/*
GAS syntax cheat.
*/

# TODO create a `.inc` to factor out the externs.

## macro

    .macro assert_eq a, b=%eax, size=l
        cmp\size \a, \b
        je macro_local\@
            call assert_fail
        macro_local\@:
    .endm

/*
    .altmacro
    .macro assert_eq a, b=%eax, size=l
        LOCAL ok
        cmp\size \a, \b
        je ok
            call assert_fail
        ok:
    .endm
*/

# TODO are externs needed? Compiles fine without.
.extern exit, print_string

.data

    /*.int and .float are only mnemonics for data size, they do not impose any compile size typechecking TODO confirm*/

    i:
        .int 0

    f:
        .float 0.0

    f1:
        .float 1.0

    ## Strings

        ## asci

                s:
                    .ascii  "abcd\n"
                    s_len = . - s

                s0:
                    .ascii  "abcd\0"
                    s_len = . - s

        /*
        ## asciz

            Like `.ascii` but adds null char to string

            Same as:

                .ascii "assert failed\n\x00"

                .ascii "assert failed\n\000"
        */

                sz:
                    .asciz  "abcd"
                    s_len = . - s

        /*
        For later use.
        */
        assert_pass_str:
            .asciz "\nALL ASSERTS PASSED\n"

.text

    .global asm_main
    asm_main:

        enter $0, $0

        ## RAM memory

            ## Indirect addressing

                # Of form:

                    # a(b, c, d)

                # is the same as Intel notation:

                    # [a + b * c + d]

                # Documented at:
                # https://sourceware.org/binutils/docs-2.18/as/i386_002dMemory.html#i386_002dMemory

            # basic usage:

                mov $0, %eax
                movl $1, (i)
                mov (i), %eax
                assert_eq $1

            # `(i)` is the same as `i`: if the label is the only thing
            # inside the parenthesis, those can be omited.

                movl $2, i
                mov i, %eax
                assert_eq $2

            # To get the actual adress instead of the data, use `$`:

                mov $i, %ebx       # ebx = &i
                mov (%ebx), %eax   # eax = *ebx
                assert_eq (i)

        ## float

                # fld1
                # fldl (f1)
                # fchs
                # fstpl (f)
                # movl (f), %eax

        /* # macro */

            /*
            # labels in macros

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
                ## altmacro

                    Enables the alternate macro mode from now on.

                    This adds extra capabilities to macros:

                    - LOCAL
                    - % string evaluation
                */

                    /*
                    ## LOCAL

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
                    ## % string evaluation

                        TODO how to use this?

                    */

                        /*
                        .altmacro
                        .macro percent_eval
                            mov %1+1, %eax
                        .endm
                        assert_eq $2
                        */

            /*
            ## \@

            ## @

            ## at sign

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
                assert_eq $1

            /*
            ## $

            ## Dollar sign

                Immediates:

                -  constants `$0x1F`
                - label addresses `$label`. Without dollar, it means the data itself!
            */


            /* # irp

                The macro below generates:

                    add $3, %eax
                    add $1, %eax
                    add $2, %eax
            */

                mov $0, %eax
                .irp i,3,1,2
                    add $\i, %eax
                .endr
                assert_eq $6

        mov $assert_pass_str, %eax
        call print_string

        leave
        movl $0, %eax
        ret

.data

    assert_fail_str: .asciz "\nASSERT FAILED\n"

.text

    /* Print error message and exit program with status 1 */
    assert_fail:

        mov $assert_fail_str, %eax
        call print_string

        /* call libc exit with exit status 1 */
        pushl $1
        call exit
