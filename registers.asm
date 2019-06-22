; Intel puts the registers in the following groups:

; - General-purpose registers
; - Segment registers
; - EFLAGS (program status and control) register

%include "lib/common_nasm.inc"

ENTRY

    ; # General purpose registers

        ; # ebp

            ; Stack base.

            ; Why it exists:
            ; http://stackoverflow.com/questions/579262/what-is-the-purpose-of-the-ebp-frame-pointer-register

            ; - tell the debugger where the current frame starts
            ; - facilitate VLA and alloca

            ; Modified by `enter` and `leave`.

            ; You can almost never use it as a general purpose register because of that.

            ; It's usage on high level languages can be optimized away
            ; e.g. with `-fomit-frame-pointer` in GCC 4.8.

        ; # esp

            ; Stack Pointer.

            ; Notably modified by `push`, `pop`, `enter`, `leave`, `call` and `ret`.

            ; You can almost never use it as a general purpose register because of that.

        ; # eip

            ; Instruction Pointer.

            ; Address of the current instruction to be executed.

            ; Cannot be retrieved directly: `mov` cannot be encoded to output to EIP:
            ; http://stackoverflow.com/questions/599968/reading-program-counter-directly

            ; There are however indirect techniques, and NASM offers `$`.

        ; # pc

            ; Another name for the IP.

            ; https://en.wikipedia.org/wiki/Program_counter

    ; # Initial register state

        ; Finally, no more programming languages getting in our way with definite assignment:

        ; - http://stackoverflow.com/questions/1802783/initial-state-of-program-registers-and-stack-on-linux-arm
        ; - http://stackoverflow.com/questions/9147455/what-is-default-register-state-when-program-launches-asm-linux

        ; Mentioned on major ABI specs, e.g. AMD64: http://www.x86-64.org/documentation/abi-0.99.pdf

    ; # Flag registers and instructions

        ; Most flag are identified by one letter, and commonly denoted `XF` for "flag X".

        ; Flags may be set or reset explicitly by dedicated instructions,
        ; and also as side effects of other instructions, e.g. `cmp` for ZF and CF.

        ; The flags are:

        ; - Type: Name (Identifier)
        ; - X: ID Flag (ID)
        ; - X: Virtual Interrupt Pending (VIP)
        ; - X: Virtual Interrupt Flag (VIF)
        ; - X: Alignment Check / Access Control (AC)
        ; - X: Virtual-8086 Mode (VM)
        ; - X: Resume Flag (RF)
        ; - X: Nested Task (NT)
        ; - X: I/O Privilege Level (IOPL)
        ; - S: Overflow Flag (OF)
        ; - C: Direction Flag (DF)
        ; - X: Interrupt Enable Flag (IF)
        ; - X: Trap Flag (TF)
        ; - S: Sign Flag (SF)
        ; - S: Zero Flag (ZF)
        ; - S: Auxiliary Carry Flag (AF)
        ; - S: Parity Flag (PF)
        ; - S: Carry Flag (CF)

        ; The types are:

        ; - `S`: Status Flag. Has no side effects.
        ; - `C`: Control Flag. Has side effects.
        ; - `X`: System Flag. Should not be modified from applications, only OS.

        ; The bit number of each flag is fixed.

        ; All the non-used are reserved for future use.

        ; # FLAGS

            ; 16-bit register that contains bit flags.

            ; Same as the lower bits of EFLAGS, which was added later.

        ; # EFLAGS

            ; 32-bit register that contains bit flags. TODO: added in x86-64?

            ; Lower 32 bits of RFLAGS.

        ; # RFLAGS

            ; 64-bit register that contains bit flags. Added in x86-64.

            ; TODO check: none of the new flags are used so far.

        ; # How to read and write flags

            ; http://stackoverflow.com/questions/1406783/flags-registers-can-we-read-or-write-them-directly

            ; - for a few flags: `jxx`
            ; - for the 8 lower bits: `lahf` and `sahf`
            ; - for all others: `pushf` and `popf`

        ; # Individual flag instructions

            ; Some, but not all, individual flags have dedicated instructions to operate on them.

            ; # stc

            ; # sti

            ; # std

                ; Set flag X (set it to 1).

            ; # clc

            ; # cli

            ; # cld

                ; Clear flag X (set it to 0).

            ; # cmc

                ; Complement flag X (boolean negation).

                ; This is the only flag that has the complement instruction.

            stc
            ASSERT_FLAG jc
            clc
            ASSERT_FLAG jnc
            cmc
            ASSERT_FLAG jc
            cmc
            ASSERT_FLAG jnc
EXIT
