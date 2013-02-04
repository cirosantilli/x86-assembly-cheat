.data					# section declaration

s:
	.ascii	"abcd\n"	# our dear string
	len = . - s		# length of our dear string

.global _start	# loader. They conventionally recognize _start as their
                # entry point. Use ld -e foo to override the default.

_start:

#sys_write
  #write to stdout

	movl	$len,%edx	#message length
	movl	$s,%ecx	#pointer to message
	movl	$1,%ebx		#file handle (stdout)
	movl	$4,%eax		#sys_write
	int	  $0x80		  #call kernel

#sys_exit

	movl	$0,%ebx		#exit code
	movl	$1,%eax		#sys_exit
	int   $0x80
