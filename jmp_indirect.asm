; jmp can take a memory location, dereference it, and jump to that location.
;
; Using tables of such jump destinations can be used to implement switch in constant time.

%include "lib/common_nasm.inc"

RODATA

    table dd label, label2

ENTRY

    jmp [table]
    ASSERT_FAIL
    label:
    jmp [table + 4]
    ASSERT_FAIL
    label2:

EXIT
