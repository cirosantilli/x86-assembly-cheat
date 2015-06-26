; # mul

    ; Unsigned multiply.


%include "lib/asm_io.inc"

ENTRY
    mov eax, 2
    mov ebx, 2
    mul ebx
    ASSERT_EQ 4
    ASSERT_EQ ebx, 2

    ; 8 bit
    mov eax, 0
    mov al, 2
    mov bl, 0x80
    mov dl, 0
    mul bl
    ASSERT_EQ 0x100

    ; 16 bit
    mov eax, 0
    mov edx, 0
    mov ax, 2
    mov bx, 0x8000
    mov dx, 0
    mul bx
    ASSERT_EQ 0
    mov ax, dx
    ASSERT_EQ 1

    ; 32 bit
    mov eax, 2
    mov ebx, 0x80000000
    mov edx, 0
    mul ebx
    ASSERT_EQ 0
    ASSERT_EQ edx, 1

    EXIT
