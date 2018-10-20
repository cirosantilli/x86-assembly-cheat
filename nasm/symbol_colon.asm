; The colon after a simbol name is optional in NASM.
;
; http://stackoverflow.com/questions/8006365/is-there-a-difference-between-using-or-not-a-colon-after-symbol-name-definitions

%include "lib/common_nasm.inc"

DATA
    ; With colon.
    x: db 1
    ; Without colon.
    y db 2
ENTRY
    mov eax, 0
    mov al, [x]
    ASSERT_EQ eax, 1
    mov al, [y]
    ASSERT_EQ eax, 2
EXIT
