; # include

    ; Same as C #include: copy pastes file data.

    ; The common standard extension is `.inc`.

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 1
    %include "included.inc"
    ASSERT_EQ eax, 2
EXIT
