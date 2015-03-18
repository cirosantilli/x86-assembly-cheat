.data

    s:
        .ascii	"hello world\n"
        len = . - s

.global _start

_start:

    # sys_write:

        movl	$4,     %eax	#sys_write
        movl	$1,     %ebx	#file handle (stdout)
        movl	$s,     %ecx	#pointer to message
        movl	$len,   %edx	#message length
        int	    $0x80		    #call kernel

    # sys_exit:

        movl	$1, %eax	#sys_exit
        movl	$0, %ebx	#exit status
        int		$0x80
