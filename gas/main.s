# gas syntax cheat

# focus is on differences from nasm

# sources:

# - <http://www.ibm.com/developerworks/library/l-gas-nasm/>: gas vs nasm
# - <http://sourceware.org/binutils/docs/as/>: gas doc

.data

    i:
        .int 0

    s:
        .ascii	"abcd\n"
        len = . - s

.text

    .global _start

    _start:

        # sys_write:

            movl	$4,     %eax
            movl	$1,     %ebx
            movl	$s,     %ecx
            movl	$len,   %edx
            int	    $0x80

        # ram memory:

            movl    $1, (i)
            movl    (i), %eax

        # sys_exit:

            movl	$1, %eax	#sys_exit
            movl	$0, %ebx	#exit code
            int		$0x80
