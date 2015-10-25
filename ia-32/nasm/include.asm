; # include

    ; Same as C #include: copy pastes file data.

    ; The common standard extension is `.inc`.

%include "lib/asm_io.inc"

ENTRY
    mov eax, 1
    %include "included.inc"
    ASSERT_EQ(2)
    EXIT


