; # equ

    ; http://stackoverflow.com/a/33148242/895245

%include "lib/common_nasm.inc"

DATA
    global x
    x: equ 1 + 1
    y: dd 1 + 1
ENTRY
    mov eax, x
    ASSERT_EQ eax, 2
    mov eax, [y]
    ASSERT_EQ eax, 2
EXIT
