; # Local labels

    ; http://www.nasm.us/doc/nasmdoc3.html#section-3.9

    ; Labels that start with a period get the previous label prepended to them,
    ; which may give them uniqueness.

    ; Those are still present on the output `.o` however.

    ; GAS has a related convention which hides `.L` prefixed labels
    ; completely from the output `.o`.

%include "lib/asm_io.inc"

ENTRY
    ; TODO examples.
    EXIT
