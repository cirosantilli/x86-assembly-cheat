; Unsigned multiply.
;
; After:
;
;     mul SRC
;
; For 16 bits and up:
;
;     DX:AX = AX * SRC;
;
; And for 8 bits:
;
;     AX = AL * SRC;
;
; No immediate form, although imul has one:
; http://stackoverflow.com/questions/20499141/is-it-possible-to-multiply-by-and-immediate-with-mul-in-x86-assembly/33202309#33202309

%include "lib/common_nasm.inc"

DATA
    x: dd 0x12341234

ENTRY
    mov eax, 2
    mov ebx, 2
    mul ebx
    ASSERT_EQ eax, 4
    ASSERT_EQ ebx, 2

    ; 8 bit
    mov eax, 0
    mov al, 2
    mov bl, 0x80
    mov dl, 0
    mul bl
    ASSERT_EQ eax, 0x100

    ; 16 bit
    mov eax, 0
    mov edx, 0
    mov ax, 2
    mov bx, 0x8000
    mov dx, 0
    mul bx
    ASSERT_EQ eax, 0
    mov ax, dx
    ASSERT_EQ eax, 1

    ; 32 bit
    mov eax, 2
    mov ebx, 0x80000000
    mov edx, 0
    mul ebx
    ASSERT_EQ eax, 0
    ASSERT_EQ edx, 1

    ; Memory version
    mov eax, 2
    mul dword [x]
    ASSERT_EQ eax, 0x24682468

EXIT
