; Unconditional branch
;
; The jmp address has the following forms. Quoting Intel manual:
;
; > - Near jump - A jump to an instruction within the current code segment
; > (the segment currently pointed to by the CS register),
; > sometimes referred to as an intrasegment jump.
; >
; > - Short jump - A near jump where the jump range is limited to
; > –128 to +127 from the current EIP value.
; >
; > - Far jump - A jump to an instruction located in a different segment
; > than the current code segment but at the same privilege level,
; > sometimes referred to as an intersegment jump.
; >
; > - Task switch - A jump to an instruction located in a different task.
;
; Short jump example:
; https://github.com/cirosantilli/x86-bare-metal-examples/blob/6606a2647d44bc14e6fd695c0ea2b6b7a5f04ca3/reboot.S
;
; TODO:
;
; - only near jump and short jump are possible in userland.
; - NASM automatically decides between near and short, you cannot explicitly choose
; - task switch jump example

%include "lib/common_nasm.inc"

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
