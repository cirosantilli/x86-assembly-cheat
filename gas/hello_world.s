.data

	s:
		.ascii	"hello world\n"
		len = . - s

.global _start

_start:

#sys_write
  #write to stdout

	movl	$len, %edx	#message length
	movl	$s, %ecx	#pointer to message
	movl	$1, %ebx		#file handle (stdout)
	movl	$4, %eax		#sys_write
	int	    $0x80		  #call kernel

#sys_exit

	movl	$0, %ebx		#exit code
	movl	$1, %eax		#sys_exit
	int		$0x80
