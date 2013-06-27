/*
gas syntax cheat

focus is on differences from nasm, so for a more complete cheat on x86 assmebly,
look for nams cheats

# sources

- <http://www.ibm.com/developerworks/library/l-gas-nasm/>:

    gas differences from nasm. Great intro if you already know nasm.

- <http://sourceware.org/binutils/docs/as/>:

    gas doc. Part of binutils.

# registers

registers are prefixed by a percent sign `%`. Ex:

    movl %eax, %ebx

# integer constants

contants are prefixed by a dollar sign `$`. Ex:

    movl $1, %eax

# order

operator order is different from intel syntax:

For example, the following moves `eax` to `ebx`:

    movl %eax %ebx

which is kind of logical because it is in the order in which we say it: "move eax to ebx"
however is different from the usual c `=` operator which would be something like

    ebx = eax

# instruction lengths

suffixes are added to instrucions to specify length:

- b = byte (8 bit)
- s = short (16 bit integer) or single (32-bit floating point)
- w = word (16 bit)
- l = long (32 bit integer or 64-bit floating point)
- q = quad (64 bit)
- t = ten bytes (80-bit floating point)

these are separate words in nasm TODO can those be specified in macros? in nasm yes because they are separate words
*/

.extern exit, puts

/*
.macro assert_eq
    pushf
    cmp %3 %1, %2
    je %%ok             ;inner label, visible only from the inside
        call assert_fail
    %%ok:
    popf
%endmacro
.endm
*/

.data

    /*.int and .float are only mnemonics for data size, they do not impose any compile size typechecking TODO confirm*/

    i:
        .int 0

    f:
        .float 0.0

    f1:
        .float 1.0

    s:
        .ascii	"abcd\n"
        s_len = . - s

    assert_fail_str:

    	.asciz "assert failed\n"

    	/*

		#asciz

		like `.ascii` but adds null char to string

		same as:

    		.ascii "assert failed\n\x00"

    		.ascii "assert failed\n\000"
    	*/

.text

    .global asm_main

    asm_main:

		pusha
		enter $0, $0

        # ram memory:

            movl    $1, (i)
            movl    (i), %eax
            inc     %eax

        # float:

#            fld1
#            fldl (f1)
#            fchs
#            fstpl (f)
#            movl (f), %eax
#

		#TODO this segfaults, why??
		pushl assert_fail_str
		call puts

		#TODO stop seg faults. The problem is here: if there was a system exist before the return, no problem:

			#pushl $1
			#call exit

		movl 0, %eax
		leave
		popa
		ret

	/* print error message and exit program with status 1 */
	assert_fail:

		pushl assert_fail_str
		call puts

		/* call libc exit with exit status 1 */
		pushl $1
		call exit
