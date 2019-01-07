; A hello world using printf from the C standard library
; via our helper macros.

%include "lib/common_nasm.inc"

ENTRY
    PRINT_STRING_LITERAL 'hello world'
EXIT
