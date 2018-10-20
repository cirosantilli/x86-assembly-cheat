; Test that we can use compiled functions of our library.
;
; Expected outcome: print 12345678 to stdout.

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 12345678
    call print_int
EXIT
