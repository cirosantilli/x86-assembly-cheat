.text
.global _start
_start: 

    # This mov gets the 64-bit address truncated to 32-bits.
    # The CPU sign extends it.
    mov byte al, 0xFFFFFFFF80000000
    mov %al, output

    mov $1, %rax
    mov $1, %rdi
    mov $output, %rsi
    mov $1, %rdx
    syscall

    # TODO do another move with the full explicit 64-bit address.
    # Should give the same output.
    mov byte al, 0xFFFFFFFF80000000
    mov %al, output

    mov $1, %rax
    mov $1, %rdi
    mov $output, %rsi
    mov $1, %rdx
    syscall

    mov $60, %rax
    mov $0, %rdi
    syscall
.data
    output: 
        .ascii "a"
.data2
    input: 
        .ascii "b"

