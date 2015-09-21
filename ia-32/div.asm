; # DIV

    ; Signed division: edx:eax /= div

    ; # Modulo

        ; div can be used to calculate modulus, but GCC does not use it becaues it is slow,
        ; and choses alternative techniques instead instead:
        ; http://stackoverflow.com/questions/4361979/how-does-the-gcc-implementation-of-module-work-and-why-does-it-not-use-the

%include "lib/asm_io.inc"

ENTRY
    mov eax, 5
    mov edx, 0
    mov ecx, 2
    div ecx
    ASSERT_EQ 2
    ASSERT_EQ edx, 1

    ; 8 bit
    mov eax, 0
    mov ax, 0x101
    mov cl, 2
    div cl
    ASSERT_EQ 0x180

    ; 16 bit
    mov eax, 0
    mov edx, 0
    mov ax, 1
    mov dx, 1
    mov cx, 2
    div cx
    ASSERT_EQ 0x8000
    ASSERT_EQ edx, 1

    ; 32 bit
    mov eax, 1
    mov edx, 1
    mov ecx, 2
    div ecx
    ASSERT_EQ 0x80000000
    ASSERT_EQ edx, 1

    ; ERROR: output must fit into dword:
    ;mov eax, 1
    ;mov edx, 2
    ;mov ecx, 2
    ;div ecx

    ; TODO division by zero?

    ; No immediate version:
    ; http://stackoverflow.com/questions/4529260/mul-instruction-doesnt-support-an-immediate-value

    EXIT
