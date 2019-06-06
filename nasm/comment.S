# # Comments

    # Single line with semicolon `;`

    # Multi-line: TODO `%comment` was added but then removed?

        #%comment
            #Any thing.
        #%endcomment

#include <lkmc.h>

LKMC_PROLOGUE
    movl $1, %eax
    # mov eax, 2
    LKMC_ASSERT_EQ_32(%eax, $1)
LKMC_EPILOGUE
