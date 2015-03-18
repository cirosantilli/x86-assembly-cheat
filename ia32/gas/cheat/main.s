/*
TODO broken.

GAS syntax cheat.

Focus is on differences from nasm, so for a more complete cheat on x86 assmebly,
look for nams cheats.

#sources

    - <http://www.ibm.com/developerworks/library/l-gas-nasm/>:

        gas differences from nasm. Great intro if you already know nasm.

    - <http://sourceware.org/binutils/docs/as/>:

        gas doc. Part of binutils.

#comments

    Multiline comments are like C comments.

    Single line comments vary with language.

    For x86, they are `#` and **not** `;`!

#registers

    Registers are prefixed by a percent sign `%`. Ex:

        movl %eax, %ebx

#integer constants

    Contants are prefixed by a dollar sign `$`. Ex:

        movl $1, %eax

#order

    Operator order is different from intel syntax:

    For example, the following moves `eax` to `ebx`:

        movl %eax %ebx

    Which is kind of logical because it is in the order in which we say it: "move eax to ebx"
    however is different from the usual c `=` operator which would be something like

        ebx = eax

#instruction lengths

    Suffixes are added to instrucions to specify length:

    - b = byte (8 bit)
    - s = short (16 bit integer) or single (32-bit floating point)
    - w = word (16 bit)
    - l = long (32 bit integer or 64-bit floating point)
    - q = quad (64 bit)
    - t = ten bytes (80-bit floating point)

    These are separate words in NASM.
    TODO can those be specified in macros? in NASM yes because they are separate words

#directives

    Stuff that starts with a dot `.` and does not specify machine instructions directly
    but rather gives information to GAS.

    - .text: text segment
    - .data: data segment
    - .global: data segment
    - .globl: same as global
    - .loc: debuging info
    - .align:
    - .zero:
    - .macro: macros

##cfi directives

    Call frame information.

    Appear all over gcc generated code for C sources.

    <http://stackoverflow.com/questions/2529185/what-are-cfi-directives-in-gnu-assembler-gas-used-for>
*/

##macro

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

.extern exit, puts

.data

    /*.int and .float are only mnemonics for data size, they do not impose any compile size typechecking TODO confirm*/

    i:
        .int 0

    f:
        .float 0.0

    f1:
        .float 1.0

    ##strings

        ##asci

                s:
                    .ascii	"abcd\n"
                    s_len = . - s

                s0:
                    .ascii	"abcd\0"
                    s_len = . - s

    	/*
		##asciz

            Like `.ascii` but adds null char to string

            Same as:

                .ascii "assert failed\n\x00"

                .ascii "assert failed\n\000"
    	*/

                sz:
                    .asciz	"abcd"
                    s_len = . - s

.text

    .global asm_main

    asm_main:

		enter $0, $0

        ##ram memory

            #Values:

                mov $0, %eax
                movl $1, (i)
                mov (i), %eax
                assert_eq $1

            #Adresses are prefixed by `$`:

                mov $i, %ebx       #ebx = &i
                mov (%ebx), %eax   #eax = *ebx
                assert_eq (i)

        ##float

                #fld1
                #fldl (f1)
                #fchs
                #fstpl (f)
                #movl (f), %eax

        /* #macro */

            /*
            #labels in macros

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
                ##altmacro

                    Enables the alternate macro mode from now on.

                    This adds extra capabilities to macros:

                    - LOCAL
                    - % string evaluation
                */

                    /*
                    ##LOCAL

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
                    ##% string evaluation

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
            #\@

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

            /* #irp

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

        movl $0, %eax
		leave
		ret

.data

    assert_fail_str: .asciz "\nASSERT FAILED\n"

.text

	/* Print error message and exit program with status 1 */
	assert_fail:

		pushl $assert_fail_str
		call puts

		/* call libc exit with exit status 1 */
		pushl $1
		call exit
