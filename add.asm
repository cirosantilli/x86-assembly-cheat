; # add
;
; Let's use the venerable add instruction as an intro to
; some important language examples.

%include "lib/common_nasm.inc"

DATA
    myint dd 0x1234_5678

ENTRY
    ; Immediate and register.
    ; eax = 1
    mov eax, 1
    ; eax += 2
    add eax, 2
    ; assert(eax == 3)
    ASSERT_EQ eax, 3

    ; Register and register.
    mov eax, 1
    mov ebx, 2
    add eax, ebx
    ASSERT_EQ eax, 3

    ; Memory and register.
    mov eax, [myint]
    ASSERT_EQ eax, 0x1234_5678

    ; Memory and immediate.
    add dword [myint], 1
    ASSERT_EQ [myint], 0x1234_5679, dword

    ; ERROR: second register must be same size
    ;add ax,al
    ;add ax,eax
EXIT
