; # Segment registers

; # CS register

; # DS register

; # ES register

; # FS register

; # GS register

; # SS register

    ; They cannot be tested easily in userland.

    ; Simple test using them in real mode:
    ; https://github.com/cirosantilli/x86-bare-metal-examples/blob/01a5e64efaac653429ee24e502f611fea7850abb/segment_registers_real_mode.S

    ; TODO what are their initial values in Linux?

%include "lib/common_nasm.inc"

ENTRY
    PRINT_STRING_LITERAL 'CS'
    PRINT_INT cs

    PRINT_STRING_LITERAL 'DS'
    PRINT_INT ds

    PRINT_STRING_LITERAL 'ES'
    PRINT_INT es

    PRINT_STRING_LITERAL 'FS'
    PRINT_INT fs

    PRINT_STRING_LITERAL 'GS'
    PRINT_INT gs

    PRINT_STRING_LITERAL 'SS'
    PRINT_INT ss

    ; SEGFAULT: can't write to them in user mode:
    ;mov eax, 0
    ;mov ss, eax

EXIT
