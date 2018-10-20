; # Local labels

    ; http://www.nasm.us/doc/nasmdoc3.html#section-3.9

    ; Labels that start with a period `.` get the previous non-local label
    ; prepended to them, which may give them uniqueness.

    ; Those are still present on the output `.o` however.

    ; GAS has a related convention which hides `.L` prefixed labels
    ; completely from the output `.o`.

%include "lib/common_nasm.inc"

ENTRY
outside_label:

    ; This should be not done in practice,
    ; but shows how it works under the hood.
    jmp outside_label.inside_label
    ASSERT_FAIL
.inside_label:

    ; This is what you should do in practice.
    ; Labels also get appended when used as arguments.
    jmp .inside_label2
    ASSERT_FAIL
.inside_label2:

EXIT
