; # NOP

    ; No OPeration.

    ; Does nothing except take up one processor cycle.

    ; Application: http://stackoverflow.com/questions/234906/whats-the-purpose-of-the-nop-opcode

%include "lib/asm_io.inc"

ENTRY
    nop
    nop
    EXIT
