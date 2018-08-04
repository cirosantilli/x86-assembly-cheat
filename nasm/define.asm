# define

%include "lib/common_nasm.inc"

ENTRY
    %define SIZE 10
    mov eax, SIZE
    ASSERT_EQ 10
    EXIT
