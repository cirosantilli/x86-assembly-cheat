; # JMP

    ; Unconditional branch

%include "lib/asm_io.inc"

ENTRY

    ; max +-128 bytes away
    ; short: displacement uses 1 byte only
    jmp short jmp_short_label
    ASSERT_FAIL
    jmp_short_label:

    ; Segmentation fault?
    ;jmp word jmp_word_label
    ;jmp_word_label:

    ; near: 4 bytes displacement
    jmp near jmp_label
    ASSERT_FAIL
    jmp_label:

    ; Allows to move outside code segment.
    ; Not allowed in ELF.
    ;jmp far jmp_far_label
    ;jmp_far_label:

    mov eax, $ + 7
    jmp eax
    ; jmp to the adress in eax
    ;mov eax, $ : 5 bytes
    ;jmp eax    : 2 bytes

    ; Seg fault: stops in the middle of next instruction
    ;mov eax, $ + 8
    ;jmp eax

    EXIT
