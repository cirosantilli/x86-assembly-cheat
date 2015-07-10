; http://stackoverflow.com/questions/6555094/what-does-cltq-do-in-assembly/31114310#31114310

%include "lib/asm_io.inc"

ENTRY
    mov rax, 0x1234567812345678
    mov eax, 1
    cdqe
    ASSERT_EQ 1

    mov rax, 0x1234567812345678
    mov eax, -1
    cdqe
    ASSERT_EQ -1

    EXIT
