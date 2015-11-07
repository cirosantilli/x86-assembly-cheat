; # Symbol colon

    ; http://stackoverflow.com/questions/8006365/is-there-a-difference-between-using-or-not-a-colon-after-symbol-name-definitions

    ; Optional

%include "lib/asm_io.inc"

DATA
    x: db 1
    y db 2
ENTRY
    mov eax, 0
    mov al, [x]
    ASSERT_EQ(1)
    mov al, [y]
    ASSERT_EQ(2)
    EXIT
