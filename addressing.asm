; # Addressing

; # Indirect addressing

; # Effective address

; # Addressing modes

    ; This considers how memory addresses can be specified to read from or write to memory.

    ; x86 allows encoding address operations of the following form on a single instruction:

        ; s:[a + b*c + d]

    ; Where the instruction encoding allows for:

    ; - `a`: any 8 or 32-bit general purpose register
    ; - `b`: any 32-bit general purpose register except `ESP`
    ; - `c`: 1, 2, 4 or 8 (encoded in 2 SIB bits)
    ; - `d`: an immediate constant
    ; - `s`: a segment register. Cannot be tested simply from userland, so we won't talk about them here. See:
    ;        https://github.com/cirosantilli/x86-bare-metal-examples/blob/6606a2647d44bc14e6fd695c0ea2b6b7a5f04ca3/segment_registers_real_mode.S

    ; Major application of this complicated schema: manipulation of an array of structs:

    ; - `a`: start of the array in memory.
    ; - `b`: index of the element. Register because it varies as we loop through the array.
    ; - `c`: size of each element. Known at compile time. TODO what gets compiled if >8 ?
    ; - `d`: field of the array to be accessed. Known at compile time, so an immediate.

    ; Several sets of a, b, c and d can be omitted. To really understand what is going on,
    ; you should learn how those instructions are encoded.


%include "lib/common_nasm.inc"

ENTRY
    ; The simplest way to try them out is with `lea`.

    ; Full form (except no segment, DS used by default):

        mov eax, 1
        mov ebx, 3
        lea eax, [eax + 2*ebx + 4]
        ASSERT_EQ eax, 11

    ; NASM is quite flexible about the ordering of operands:

        mov eax, 1
        mov ebx, 3
        lea eax, [4 + eax + 2*ebx]
        ASSERT_EQ eax, 11

    ; but avoid that and use the `[a + b*c + d]` form proposed,
    ; as that is the simplest one to interpret as array of struct + field access.

    ; # Magic multipliers

        ; NASM can also do pure magic like:

            mov eax, 1
            lea eax, [3*eax]
            ASSERT_EQ eax, 3

        ; Which compiles to:

            mov eax, 1
            lea eax, [eax + 2*eax]
            ASSERT_EQ eax, 3

        ; since `b` must be a power of 2.
        ; This is documented at: http://www.nasm.us/doc/nasmdoc3.html#section-3.3

        ; This can lead us up to 9:

            mov eax, 1
            lea eax, [9*eax]
            ASSERT_EQ eax, 9

        ; Which compiles to [eax + eax*8].

        ; But the following are not possible:

            ;lea eax, [6*eax]
            ;lea eax, [7*eax]
            ;lea eax, [10*eax]

    ; TODO Possible to use 8-bit or 16-bit registers?

        mov ax, 0
        mov bx, 1
        lea ax, [bx]
        ASSERT_EQ ax, 1

        ; TODO why is this invalid while the above works?
        ;lea bx, [ax]

        ; Invalid.
        ;lea bl, [al]
        ;lea al, [bl]

EXIT
