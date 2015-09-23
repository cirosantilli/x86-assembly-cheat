; # Addressing

; # Indirect addressing

; # Effective address

; # Addressing modes

    ; This considers how memory addresses can be specified to read from or write to memory.

    ; x86 allows encoding address operations of the following form on a single instruction:

        ; s:[a + b*c + d]

    ; Where the instruction encoding allows for:

    ; - `a`: any general purpose register
    ; - `b`: any general purpose register except `ESP`
    ; - `c`: 1, 2, 4 or 8
    ; - `d`: an immediate constant
    ; - `s`: a segment register. Cannot be tested simply from userland, so we won't talk about them here. See:
    ;        https://github.com/cirosantilli/x86-bare-metal-examples/blob/6606a2647d44bc14e6fd695c0ea2b6b7a5f04ca3/segment_registers_real_mode.S

    ; https://en.wikipedia.org/wiki/X86#Addressing_modes

    ; Major application of this complicated schema: manipulation of an array of structs:

    ; - `a`: start of the array in memory.
    ; - `b`: index of the element. Register because it varies as we loop through the array.
    ; - `c`: size of each element. Known at compile time. TODO what gets compiled if >8 ?
    ; - `d`: field of the array to be accessed. Known at compile time, so an immediate.

    ; http://stackoverflow.com/questions/1658294/whats-the-purpose-of-the-lea-instruction

    ; Several sets of a, b, c and d can be omitted. To really understand what is going on,
    ; you should learn how those instructions are encoded.


%include "lib/asm_io.inc"

ENTRY
    ; The simplest way to try them out is with `lea`.

    ; Full form:

        mov eax, 1
        mov ebx, 3
        lea eax, [eax + 2*ebx + 4]
        ASSERT_EQ 11

    ; NASM is quite flexible about the ordering of operands:

        mov eax, 1
        mov ebx, 3
        lea eax, [4 + eax + 2*ebx]
        ASSERT_EQ 11

    ; but avoid that and use the `[a + b*c + d]` form proposed,
    ; as that is the simplest one to interpret as array of struct + field access.

    ; NASM can also do pure magic like:

        mov eax, 1
        lea eax, [3*eax]
        ASSERT_EQ 3

    ; Which compiles to:

        mov eax, 1
        lea eax, [eax + 2*eax]
        ASSERT_EQ 3

    ; since `b` must be a power of 2.
    ; This is documented at: http://www.nasm.us/doc/nasmdoc3.html#section-3.3

    ; # Segment register form

        ; It is also possible to specify the segment register to use with:

            ; [ed:a + b*c + d]

        ; TODO expand on that. See also:
        ; http://stackoverflow.com/questions/18736663/what-does-the-colon-mean-in-x86-assembly-gas-syntax-as-in-dsbx

    EXIT
