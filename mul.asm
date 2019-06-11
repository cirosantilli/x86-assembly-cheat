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

#include <lkmc.h>

.data
    x: dd 0x12341234

LKMC_PROLOGUE
    mov eax, 2
    mov ebx, 2
    mul ebx
    LKMC_ASSERT_EQ_32(%eax, $4)
    LKMC_ASSERT_EQ_32(%ebx, $2)

    ; 8 bit
    mov eax, 0
    mov al, 2
    mov bl, 0x80
    mov dl, 0
    mul bl
    LKMC_ASSERT_EQ_32(%eax, $0x100)

    ; 16 bit
    mov eax, 0
    mov edx, 0
    mov ax, 2
    mov bx, 0x8000
    mov dx, 0
    mul bx
    LKMC_ASSERT_EQ_32(%eax, $0)
    mov ax, dx
    LKMC_ASSERT_EQ_32(%eax, $1)

    ; 32 bit
    mov eax, 2
    mov ebx, 0x80000000
    mov edx, 0
    mul ebx
    LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%edx, $1)

    ; Memory version
    mov eax, 2
    mul dword [x]
    LKMC_ASSERT_EQ_32(%eax, $0x24682468)

LKMC_EPILOGUE
