; # equ

    ; http://stackoverflow.com/a/33148242/895245

%include "lib/asm_io.inc"

DATA
    global x
    x: equ 1 + 1
    y: dd 1 + 1
ENTRY
    mov eax, x
    ASSERT_EQ(2)
    mov eax, [y]
    ASSERT_EQ(2)
    EXIT
