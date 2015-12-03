; # Comments

    ; Single line with semicolon `;`

    ; Multi-line: TODO `%comment` was added but then removed?

        ;%comment
            ;Any thing.
        ;%endcomment

%include "lib/asm_io.inc"

ENTRY
    mov eax, 1
    ; mov eax, 2
    ASSERT_EQ(1)
    EXIT
