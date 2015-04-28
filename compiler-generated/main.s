	.file	"main.c"
	.text
	.p2align 4,,15
	.globl	memcmp_test
	.type	memcmp_test, @function
memcmp_test:
.LFB31:
	.cfi_startproc
	movslq	%edx, %rdx
	jmp	memcmp
	.cfi_endproc
.LFE31:
	.size	memcmp_test, .-memcmp_test
	.p2align 4,,15
	.globl	memcmp_test_fixed
	.type	memcmp_test_fixed, @function
memcmp_test_fixed:
.LFB32:
	.cfi_startproc
	movl	$2, %edx
	jmp	memcmp
	.cfi_endproc
.LFE32:
	.size	memcmp_test_fixed, .-memcmp_test_fixed
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB33:
	.cfi_startproc
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE33:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
