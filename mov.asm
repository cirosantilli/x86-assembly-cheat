; # mov
;
; Well, you likely want to be able to set variables!

%include "lib/common_nasm.inc"

DATA
    myint dd 0x1234_5678

ENTRY
    ; Immediate and register.
    ; eax = 0
    mov eax, 0
    ; eax = 1
    mov eax, 1
    ; assert(eax == 1)
    ASSERT_EQ eax, 1

    ; Register and register.
    mov eax, 0
    mov ebx, 1
    mov eax, ebx
    ASSERT_EQ eax, 1

    ; Memory and register.
    mov eax, [myint]
    ASSERT_EQ eax, 0x1234_5678

    ; Memory and immediate.
    mov dword [myint], 0x9ABC_DEF0
    ASSERT_EQ [myint], 0x9ABC_DEF0, dword

    ; Memory via pointer to address.
    ; eax = &myint
    mov eax, myint
    ; *eax = 0x1111_2222
    mov dword [eax], 0x1111_2222
    ASSERT_EQ [myint], 0x1111_2222, dword

    ; Possible to move on itself, seems like a NOP and way to clear 32 high bits in x86-64:
    ; http://stackoverflow.com/questions/11910501/why-did-gcc-generate-mov-eax-eax-and-what-does-it-mean
    mov eax, eax
EXIT
