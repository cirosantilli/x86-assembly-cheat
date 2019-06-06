.text
.global _start
_start: 

    # This mov gets the 64-bit address truncated to 32-bits.
    # The CPU sign extends it.
    mov byte al, 0xFFFFFFFF80000000
    movb %al, output

    movq $1, %rax
    movq $1, %rdi
    movq $output, %rsi
    movq $1, %rdx
    syscall

    # TODO do another move with the full explicit 64-bit address.
    # Should give the same output.
    mov byte al, 0xFFFFFFFF80000000
    movb %al, output

    movq $1, %rax
    movq $1, %rdi
    movq $output, %rsi
    movq $1, %rdx
    syscall

    movq $60, %rax
    movq $0, %rdi
    syscall
.data
    output: 
        .ascii "a"
.data2
    input: 
        .ascii "b"

