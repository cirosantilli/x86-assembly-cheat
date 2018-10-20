; Expected outcome: print 1234567812345678 to stdout.
%include "lib/common_nasm.inc"
ENTRY
    mov rdi, 1234567812345678
    call print_long
EXIT
