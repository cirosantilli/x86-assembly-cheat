; The colon after a simbol name is optional in NASM.
;
; http://stackoverflow.com/questions/8006365/is-there-a-difference-between-using-or-not-a-colon-after-symbol-name-definitions

%include "lib/asm_io.inc"

DATA
    ; With colon.
    x: db 1
    ; Without colon.
    y db 2
ENTRY
    mov eax, 0
    mov al, [x]
    ASSERT_EQ(1)
    mov al, [y]
    ASSERT_EQ(2)
    EXIT
