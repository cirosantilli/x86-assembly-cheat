; # mov

    ; Assign:

        ; mov X, Y

    ; Equals:

        ; X = Y

    ; mov also has other more exotic forms for control and debug registers.

%include "lib/common_nasm.inc"

ENTRY

    mov eax, 0
    mov eax, 1
    ASSERT_EQ eax, 1

    mov eax, 0
    mov ebx, 1
    mov eax, ebx
    ASSERT_EQ eax, 1

    ; Possible to move on itself, seems like a NOP and way to clear 32 high bits in x86-64:
    ; http://stackoverflow.com/questions/11910501/why-did-gcc-generate-mov-eax-eax-and-what-does-it-mean
    mov eax, eax

EXIT
