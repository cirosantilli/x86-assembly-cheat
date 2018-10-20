; # Registers

    ; TODO split this down further.

    ; Intel puts the registers in the following groups:

    ; - General-purpose registers
    ; - Segment registers
    ; - EFLAGS (program status and control) register

%include "lib/common_nasm.inc"

ENTRY

    ; # General purpose registers

        ; There are 8:

            mov eax, 0xFFFF_FFFF
            mov ebx, 0xFFFF_FFFF
            mov ecx, 0xFFFF_FFFF
            mov edx, 0xFFFF_FFFF
            mov esi, 0xFFFF_FFFF
            mov edi, 0xFFFF_FFFF
            ; SEGFAULT
            ; We could compile and run the following,
            ; but that would segfault us later
            ; since those are used on calling conventions:
            ;mov ebp, 0xFFFF_FFFF
            ;mov esp, 0xFFFF_FFFF

        ; In theory, those can be used freely for many computations such as sums, subtractions, etc.

        ; However, many instructions make extensive use
        ; of certain of those registers such as `ESP` which keeps track of the stack.

        ; Therefore, you should rely primarily on `eax`, `ebx`, `ecx` and `edx`
        ; as actually being general purpose, and even for those you should check often
        ; if each operation will not take resd0/output from them without you knowing it.

        ; x86_64 adds 8 byte long versions of the IA32 registers
        ; and 8 more plain new 8 byte registers: r8 to r16.

        ; #ax

        ; #dx

        ; #cx

        ; #bx

            ; Although they are called "general purpose", that is a lie
            ; since they are still treated magically by a few operations.

            ; `abcd` is just a coincidence: the letters are actually
            ; mnemonics for their special side effects:

            ; - AX = accumulator
            ; - DX = double word accumulator
            ; - CX = counter
            ; - BX = base register

            ; This is also reflected by the way that those registers are encoded,
            ; which uses the order `acdb` instead of `abcd`.

        ; # Register parts

            ; - Yl
            ; - Yh
            ; - Yx
            ; - eYx

            ; The parts of the register can be visualized as:

                ; | 1    | 2    | 3    | 4    |
                ; |---------------------------|
                ; | eax                       |
                ; |             | ax          |
                ; |             | ah   | al   |

            ; Many instructions do different things
            ; depending on the size of the register passed.

                mov eax, 0x0102_0304
                mov ebx, 0x0000_0004
                ASSERT_EQ al, bl
                ASSERT_NEQ ax, bx

                mov eax, 0x0102_0304
                mov ebx, 0x0000_0304
                ASSERT_EQ ax, bx
                ASSERT_NEQ eax, ebx

        ; # esi

        ; # edi

            ; http://stackoverflow.com/questions/1856320/purpose-of-esi-edi-registers

            ; Automatically incremented or decremented by the string instructions.

            ; - esi is the Source of string operations. Used by all string instructions.

            ; - edi is the Destination of string operations.

                ; Only used for string instruction that take two inputs, e.g.: movs (`memcpy`).

                ; Some string instructions always use a given register as output and don't touch edi.
                ; E.g. `lods` uses al, and does not touch `edi`.

            ; Increment and decrement are differentiated by the direction flag.

            ; Whenever you are not dealing with string instructions,
            ; those registers are useful for general purpose.

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

        ; # lahf

        ; # sahf

            ; Load and set the lower 8 bits of flags and AH register.

            ; Only works for those 8-lower bits.
EXIT
