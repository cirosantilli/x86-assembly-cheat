; Signed division:
;
;     eax = edx:eax / SRC
;     edx = edx:eax % SRC
;
; div can be used to calculate modulus, but GCC does not use it becaues it is slow,
; and choses alternative techniques instead instead:
; http://stackoverflow.com/questions/4361979/how-does-the-gcc-implementation-of-module-work-and-why-does-it-not-use-the

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 5
    mov edx, 0
    mov ecx, 2
    div ecx
    ASSERT_EQ eax, 2
    ASSERT_EQ edx, 1

    ; 8 bit
    mov eax, 0
    mov ax, 0x101
    mov cl, 2
    div cl
    ASSERT_EQ eax, 0x180

    ; 16 bit
    mov eax, 0
    mov edx, 0
    mov ax, 1
    mov dx, 1
    mov cx, 2
    div cx
    ASSERT_EQ eax, 0x8000
    ASSERT_EQ edx, 1

    ; 32 bit
    mov eax, 1
    mov edx, 1
    mov ecx, 2
    div ecx
    ASSERT_EQ eax, 0x80000000
    ASSERT_EQ edx, 1

    ; # Division by zero

    ; # Division overflow

        ; If either

        ; - divisor == 0
        ; - result > output register size

        ; A divide error exception occurs.
        ; It then gets handled by the interrupt service 0.

        ; Both 0 division and overflow are treated exactly the same!

        ; Linux treats this by sending a signal to the process and killing it.

        ; Minimal 16-bit example of handling the interrupt:
        ; https://github.com/cirosantilli/x86-bare-metal-examples/blob/9e58c1dc656dab54aa69daa38f84eb8c0aa6151e/idt_zero_divide.S

            ; Output does not fit into edx.
            ;mov eax, 0
            ;mov edx, 1
            ;mov ecx, 1
            ;div ecx

            ; Division by zero.
            ;mov eax, 1
            ;mov edx, 0
            ;mov ecx, 0
            ;div ecx

        ; There is no immediate version:
        ; http://stackoverflow.com/questions/4529260/mul-instruction-doesnt-support-an-immediate-value

EXIT
