; TODO: this file is being split up into smaller files
;
; TODO: split nasm concepts from IA-32 concepts.
;
; Main cheat on the x86 architecture and on NASM.

; # extern

    ; Same as C extern

    ; C compilers automatically link to libc, so all we need to use
    ; C stdlib functions when using the c driver is to declare them
    ; extern and then follow the c calling convention.

; # macro

    ; # include

        ; Same as C #include: copy pastes file data.

            %include "lib/asm_io.inc"

        ; TODO split macros used for the tests,
        ; from those used for testing how macros work.

        ; http://www.nasm.us/doc/nasmdoc4.html

    ; # Define macros

        ; # Inner macro labels

            ; Labels inside macros prefixed by `%%` are special:
            ; for each macro invocation they generate a new unique label,
            ; which is not visible on the object files.

            ; This allows macros to behave like functions.

            ; TODO example

    ; # Built-in macros

    ; # Comments

        ; Single line with semicolon `;`

        ; Multi-line:

        ; TODO `%comment` was added but then removed?

            ;%comment
                ;Any thing.
            ;%endcomment

; # section

    ; Creates ELF sections.

    ; Each section name can be used many times:
    ; NASM just concatenates all of those that have the same name on the output.

; # segment

    ; Synonym for `section`. Don't use it.

; # data section

; # .data

    ; Initialized data.

    ; TODO ELF standard section.
DATA

        db0 db 0x10
        db0_2 db 0x10, 0x20
        dw0 dw 0x1000
        dd0 dd 0x1000_0000
        dq0 dq 0x1000_0000_2000_0000

        dd0dd0 dd dd0

    ; ERROR The larger ones do not accept numeric constants. TODO how to use them then?

        ;dt0 dt 0x0
        ;do0 do 0x0
        ;dy0 dy 0x0
        ;dz0 dz 0x0

    ; # Literals

        ; TODO move to main and assert them all.
        ; Only leave on eof each data type here.

        ; # integer literals

            b1 db 110101b  ; byte initialized to binary 110101 (53 in decimal)
            b2 db 12h      ; byte initialized to hex 12 (18 in decimal)
            b3 db 17o      ; byte initialized to octal 17 (15 in decimal)
            b4 db "A"      ; byte initialized to ASCII code for A (65)

            ;b5 db A0h     ; ERROR: num cannot start with letter
            b5 db 0x0A0

            d0 dd 1A92h    ; double word initialized to hex 1A92
            d1 dd 1A92h    ; double word initialized to hex 1A92

        ; # float literals

            ; Direct float literals can only be used with `dd` family instructions.

            ; Immediates in the text section must use `__floatXX__()`.

            f0 dd 0.0       ; float
            ; ERROR: no binary float notation.
            ;f0    dd 0.0b
            f1  dd 1.0 ; float
            fm1 dd -1.0 ; float
            f1d1 dd 1.5  ; float
            f1d01 dd 1.25 ; float
            f10 dd 2.0 ; float
            f100 dd 4.0 ; float

        ; # Array literals

            ; Cannot be put directly into the code, as they:

            ; - would take multiple instructions to load
            ; - would occupy memory many times is used many times

                bs4 db 0, 1, 2, 3
                bs4_2 db 0, 0, 0, 0
                bs10 times 10 db 0
                bs20 times 10 db 0
                    times 10 db 1

        ; # String literals

            ; Unlike the c stdlib convention, they do not to end in '\0'.

            ; If you want to use them, you need to either:

            ; - add the `0` for libc string methods
            ; - pass the size to libc mem methods, or direct system calls

            ;"abcd\n":

            bs5 db "a", "b", "c", 'd', 0

            ; # strlen(s)

                ; MUST FOLLOW bs5 immediately
                ; because `$` is the cur adress

                bs5_len  equ $ - bs5

            ; Same
            bs5_2 db 'aaaa', 0
            ; Null terminated
            bs4n db 'abc', 0

            prompt_int db "enter int: ", 0
            filepath db './_out/out.tmp', 0

section .rodata

    ; WARNING: uninitialized space declared in non-BSS section `.rodata': zeroing.
    ;rodata_resd resd 1

    rodata_dd dd 1

section .mycustomsection

    mycustomsection_dd dd 1

; # bss section

    ; Uninitialized data.

    ; TODO ELF standard section? Guaranteed to be 0 initialized?
section .bss

    ; # resb

    ; # resb

    ; # resw

    ; # resd

    ; # resq

    ; # rest

    ; # reso

    ; # resy

    ; # resz

        resb0 resb 1
        resw0 resw 1
        resd0 resd 1
        resd1 resd 1
        resq0 resq 1
        rest0 rest 1
        reso0 reso 1
        reso1 reso 1
        resy0 resy 1
        ; NASM 2.11
        ;resz0 resz 1

ENTRY

    ; # pseudo-instructions

        ; *Not* assembly instructions,
        ; but NASM instructions that insert bytes directly into the output file.

        ; Their syntax just happens look like instructions (insane IMHO).

        ; - `db` family
        ; - `resb` family
        ; - `incbin`
        ; - `times`
        ; - `equ`

    ; # db

    ; # dw

    ; # dd

        ; Pseudo-instructions that insert bytes directly on the output and give them a label.

        ; This just happens to be exactly how ELF encodes `.data` section data.

            ASSERT_EQ [db0], 0x10, byte
            ASSERT_EQ [db0_2], 0x2010, word
            ASSERT_EQ [dw0], 0x1000, word
            ASSERT_EQ [dd0], 0x1000_0000, dword

        ; TODO why inverted? Endianess?

            ASSERT_EQ [dq0], 0x2000_0000, dword
            ASSERT_EQ [dq0 + 4], 0x1000_0000, dword

        ; We could not do a `qword` `cmp` here because we are in 32-bit mode.

        ; # db in .text

            ; Insert two 0x90 bytes in the output:
            ; they are both NOP instructions, so it's fine.

            ; We could code everything like that if we wanted :-)
            ; But then coding with `printf '\01'` would be more direct.

                db 0x90
                db 0x90

    ; # section

        ; # rodata

            ASSERT_EQ [rodata_dd], 1, dword

            ; SEGFAULT
            ;mov dword [rodata_dd], 2

        ; # Custom sections

            ASSERT_EQ [mycustomsection_dd], 1, dword

            ; SEGFAULT
            ;mov dword [mycustomsection_dd], 2

    ; # Detect architecture at compile time

        ; Not possible:
        ; http://stackoverflow.com/questions/24124484/how-to-detect-architecture-in-nasm-so-that-i-could-have-one-source-code-for-both

        ; But you can use `__OUTPUT_FORMAT__` to get the value of `-f`.

    ; # Registers

        ; Intel puts the registers in the following groups:

        ; - General-purpose registers
        ; - Segment registers
        ; - EFLAGS (program status and control) register

        ; # General purpose reigisters

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

                ; Automatically incremented by the string instructions.

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

            ; Finally, no more programming languages getting in our way with definite assignment.

            ; - http://stackoverflow.com/questions/1802783/initial-state-of-program-registers-and-stack-on-linux-arm
            ; - http://stackoverflow.com/questions/9147455/what-is-default-register-state-when-program-launches-asm-linux

            ; Mentioned on major ABI specs, e.g. AMD64: http://www.x86-64.org/documentation/abi-0.99.pdf

        ; # Segment registers

        ; # SS register

        ; # DS register

        ; # CS register

            ; Those cannot be tested easily in userland.

            ; We will just print them here.

            ; http://reverseengineering.stackexchange.com/questions/2006/how-are-the-segment-registers-fs-gs-cs-ss-ds-es-used-in-linux

                PRINT_STRING_LITERAL 'CS'
                PRINT_INT cs

                PRINT_STRING_LITERAL 'DS'
                PRINT_INT ds

                PRINT_STRING_LITERAL 'CS'
                PRINT_INT ss

                PRINT_INT 66666

            ; SEGFAULT: can't write to them in user mode.

                ;mov eax, 0
                ;mov ss, eax

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

            ; # pushf

            ; # pushfd

            ; # pushfq

            ; # popf

                ; Like pusha and popa, but for flags:

                ; - push/pop FLAGS
                ; - pushd/popd EFLAGS

                    clc
                    mov eax, esp
                    pushf
                    sub eax, esp
                    ; Needs 2 bytes, stack min 1 dword.
                    ASSERT_EQ 4

                    stc
                    popf
                    ASSERT_FLAG jnc

                    clc
                    pushfd
                    stc
                    popfd
                    ASSERT_FLAG jnc

    ; # RAM memory

        ; Adresses in RAM memory.

        ; -   if they are in the `.data` segment then you can modify them, so they are variables

            ; You cannot jump to them, since the OS only allows us to execute
            ; stuff inside the `.text` segment.

        ; -  if they are in the `.text` segment then the OS may not allow you to modify them.

            ; Anyways, you don't want to do that since `.text` if for your functions and that
            ; would modify the code of your functions.

            ; If they are on the `.text` segment your OS will allow you to execute them,
            ; which is why you can jump to those instructions.

        ; Basic example:

            mov al, [resb0]  ;al = resb0
            ASSERT_EQ al, [resb0]

        ; Address manipulation:

            mov ebx, resb0 ; ebx = &resb0
            mov al, [ebx] ; al = *eax
            ASSERT_EQ al, [resb0]

            mov byte [resb0], 0 ; resb0 = 0
            cmp byte [resb0], 0
            ASSERT_FLAG jz

            mov eax, [d0] ; copy double word at d0 into EAX
            add eax, [d0] ; EAX = EAX + double word at d0
            add [d0], eax ; double word at d0 += EAX
            mov al, [d0]  ; copy first byte of double word at d0 into AL

        ; # Indirect addressing

        ; # Effective address

        ; # Addressing modes

            ; x86 allows encoding address operations of the following form on a single instruction:

                ; [a + b*c + d]

            ; Where the instruction encoding allows for:

            ; - `a`: any general purpose register
            ; - `b`: any general purpose register except `ESP`
            ; - `c`: 1, 2, 4 or 8
            ; - `d`: an immediate constant

            ; https://en.wikipedia.org/wiki/X86#Addressing_modes

            ; Major application: manipulation of an array of structs:

            ; - `a`: start of the array in memory
            ; - `b`: index of the element
            ; - `c`: size of each element. Known at compile time. TODO what gets compiled if >8 ?
            ; - `d`: field of the array to be accessed. It is known at compile time, thus the constant.

            ; http://stackoverflow.com/questions/1658294/whats-the-purpose-of-the-lea-instruction

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

            ; which compiles like:

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

        ; # Instruction size

        ; # byte

        ; # word

        ; # dword

            ; When operations involve registers it is not necessary to specify
            ; the number of bytes to move around since that can be deduced from the
            ; register form: `eax` = 4 bytes, `ea` == 2 bytes, etc.

            ; But when moving or comparing literals to RAM
            ; it is mandatory to specify the number of bytes to move.

            ; The following size specifiers exist:

            ; - byte: 1 bytes
            ; - word: 2 bytes
            ; - dword: 4 bytes

        ; # qword

            ; 8 bytes.

            ; Only possible in 64-bit.

        ; # bword

        ; # wword

            ; No uniformity: it's `byte` and `word` instead.

        ; # tword

        ; # oword

        ; # yword

        ; # zword

            ; TODO do they exist?

            ; - tword: 10 bytes
            ; - oword: 16 bytes
            ; - yword: 32 bytes
            ; - zword: 64 bytes

        ; # $

            ; Adress of current instruction.

                PRINT_INT $
                PRINT_INT $
                mov eax, $ + 1

            ; Instruction lengths

                mov ebx, $
                mov eax, $
                sub eax, ebx
                call print_int
                ;5
                    ;1 byte for the instruction
                    ;4 bytes for the expanded '$' (4 byte address)

                mov ebx, $
                call print_ebx_call_ret
                mov eax, $
                sub eax, ebx
                call print_int

                mov ebx, $
                mov edx, ecx
                mov eax, $
                sub eax, ebx
                call print_int
                ;7
                    ;mov edx, ecx  :  2 bytes + 5 for the mov ebx, $

                mov ebx, $
                sub edx, ecx
                mov eax, $
                sub eax, ebx
                call print_int
                ;7
                    ;sub edx, ecx : 2 bytes

                mov ebx, $
                mov dl, 0
                mov eax, $
                sub eax, ebx
                call print_int
                ;7
                    ;sub edx, 0
                    ;2 bytes
                    ;1 for mov edx
                    ;2 for the 0 (dl contains 2 bytes)

                mov ebx, $
                jmp short jmp_short_len_lbl
                jmp_short_len_lbl:
                mov eax, $
                sub eax, ebx
                call print_int
                ;7

                mov ebx, $
                jmp jmp_len_lbl
                jmp_len_lbl:
                mov eax, $
                sub eax, ebx
                call print_int
                ;7
                    ;TODO
                    ;why not 8?
                    ;compiler automatically sees this?

                mov ebx, $
                mov dx, 0
                mov eax, $
                sub eax, ebx
                call print_int
                ;9
                    ;TODO
                    ;why not 8 ?
                    ;1 mov dx + 2 0

                mov ebx, $
                mov edx, 0
                mov eax, $
                sub eax, ebx
                call print_int
                    ;10
                        ;sub edx, 0
                        ;5 bytes
                            ;1 for mov edx
                            ;4 for the 0 (edx contains 4 bytes)

    ; # String instructions

    ; # Array instructions

        ; Instructions that deal with multiple bytes.

        ; # rep prefix

            ; Repeats a given instruction until something happens.

            ; Greate for array operations.

            ; Can only be used on certain operations:

            ; - REP prefix can be added to the INS, OUTS, MOVS, LODS, and STOS
            ; - REPE, REPNE, REPZ, and REPNZ can be added to the CMPS and SCAS

            ; C insight: this is why memcpy and memcmp may be faster than for loops
            ; it is easier for compiler to use these faster string commands.

            ; But note that as of 2015, gcc compiles string structions to call the stdlib,
            ; which is highly optimized, and may use SIMD.

            ; # rep

                ; Repeat string instruction ecx times

                ; Variants: `rep(n|)[ze]`

                ; # memcpy

                    cld
                    mov edi, bs4
                    mov ecx, 2
                    mov eax, 0
                    rep stosb
                    ASSERT_EQ [bs4], 0, byte
                    ASSERT_EQ [bs4+1], 0, byte
                    mov eax, edi
                    sub eax, bs4
                    ASSERT_EQ 2
                    ASSERT_EQ ecx, 0

                ; # memcmp

                    ; TODO

                ; # memchr

                    cld

                    mov esi, bs4
                    mov byte [bs4], 0
                    mov byte [bs4 + 1], 1

                    mov edi, bs4_2
                    mov byte [bs4_2], 0
                    mov byte [bs4_2 + 1], 1

                    mov ecx, 2
                    repz cmpsb
                    ASSERT_FLAG jz
                    ASSERT_EQ ecx, 0

                    mov ecx, 2
                    mov byte [bs4_2 + 1], 2
                    repz cmpsb
                    ASSERT_FLAG jnz
                    ASSERT_EQ ecx, 1

        ; # lods

            ; Load into a and move `esi`.

                mov esi, bs4
                mov byte [bs4], 0
                mov byte [bs4 + 1], 1

                cld
                ; Increase ESI
                lodsb
                ASSERT_EQ al, 0
                mov eax, esi
                sub eax, bs4
                ASSERT_EQ 1

                std
                ; Decrease ESI
                lodsb
                ASSERT_EQ al, 1
                mov eax, esi
                sub eax, bs4
                ASSERT_EQ 0

                ; TODO: Shouldn't be necessary, but some badly written func afterwards is not clearing this value?
                cld

        ; # stos

            ; Store from `a` and move `edi`

                mov edi, bs4

                cld
                mov bl, 1
                mov al, bl
                stosb
                ASSERT_EQ [bs4], bl
                mov eax, edi
                sub eax, bs4
                ASSERT_EQ 1

                std
                mov bl, 2
                mov al, bl
                stosb
                ASSERT_EQ [bs4 + 1], bl
                mov eax, edi
                sub eax, bs4
                ASSERT_EQ 0

                cld

        ; # movs

            ; Copy one string into another.

                mov edi, bs4_2
                mov esi, bs4
                mov byte [bs4], 0
                mov byte [bs4 + 1], 1

                cld
                movsb
                ASSERT_EQ [bs4_2], 0, byte
                mov eax, esi
                sub eax, bs4
                ASSERT_EQ 1
                mov eax, edi
                sub eax, bs4_2
                ASSERT_EQ 1

                std
                movsb
                ASSERT_EQ [bs4_2 + 1], 1, byte
                mov eax, esi
                sub eax, bs4
                ASSERT_EQ 0
                mov eax, edi
                sub eax, bs4_2
                ASSERT_EQ 0

                cld

        ; # scas

            ; Compare array and a.

                mov edi, bs4
                mov byte [bs4], 0
                mov byte [bs4 + 1], 1

                cld
                mov al, 0
                scasb
                ASSERT_FLAG jz
                mov eax, edi
                sub eax, bs4
                ASSERT_EQ 1

                std
                mov al, 2
                scasb
                ASSERT_FLAG jnz
                mov eax, edi
                sub eax, bs4
                ASSERT_EQ 0

                cld

        ; # cmps

            ; Compare two arrays

                mov esi, bs4
                mov byte [bs4], 0
                mov byte [bs4 + 1], 1

                mov edi, bs4_2
                mov byte [bs4_2], 0
                mov byte [bs4_2 + 1], 2

                cld
                cmpsb
                ASSERT_FLAG jz
                mov eax, esi
                sub eax, bs4
                ASSERT_EQ 1
                mov eax, edi
                sub eax, bs4_2
                ASSERT_EQ 1
                ASSERT_EQ [bs4], 0, byte
                ASSERT_EQ [bs4_2], 0, byte

                std
                movsb
                ASSERT_FLAG jnz
                mov eax, esi
                sub eax, bs4
                ASSERT_EQ 0
                mov eax, edi
                sub eax, bs4_2
                ASSERT_EQ 0
                ASSERT_EQ [bs4 + 1], 1, byte
                ; TODO why fail?
                ;ASSERT_EQ [bs4_2 + 1], 2, byte

                cld

    ; # stack

        ; x86 gives instructions which allow for manipulating memory as a stack.

        ; This is useful allocate memory statically.

        ; It is also an important part of function calling conventions such as the C calling convention.

        ; # pusha

        ; # popa

            ; Push and restore the following registers using the stack:
            ; EAX, ECX, EDX, EBX, ESP, EBP, ESI, EDI

            ; This is important for example in the C calling convention,
            ; where certain registers must not be changed by functions.

                mov ebx, 0
                mov ecx, 0

                mov eax, esp
                pusha
                sub eax, esp
                ; 8x 4 bytes
                ASSERT_EQ 32

                mov ebx, 1
                mov ecx, 1
                popa
                ASSERT_EQ ebx, 0
                ASSERT_EQ ecx, 0

        ; # Stack manipulation intstructions

            ; Useful for functions when they must allow for recursion.

            ; The idea that when you enter a function you store the top of the stack in `ebp`
            ; and do no change `ebp` inside the function, only when leaving it.

            ; This way, the first variable will always be at ebp - 4,u
            ; even if you allocate more data on stack for local variables, moving `esp`

            ; If this were not done, allocating data would move `esp`, and the position of arguments
            ; would depend on how much data was allocated, much more complicated to implement.

            ; Then, when you leave the function, you restore `esp` ebp, deallocating the local memory.

        ; # enter

            ; `enter A, B` is basically equivalent to:

                ;push ebp
                ;mov ebp, esp
                ;sub esp, A

            ; Which implies an allocation of:

            ; - one dword to remember `ebp`
            ; - `A` dwords for local function variables,

            ; Enter is almost never used by GCC as it is slower than `push`:
            ; http://stackoverflow.com/questions/5959890/enter-vs-push-ebp-mov-ebp-esp-sub-esp-imm-and-leave-vs-mov-esp-ebp

            ; `leave` is used however

            ; B is very rarely not 0 in compiler output.
            ; http://stackoverflow.com/questions/26323215/do-any-languages-compilers-utilize-the-x86-enter-instruction-with-a-nonzero-ne

        ; # leave

            ; `leave` is equivalent to:

                ;mov esp, ebp
                ;pop ebp

            ; Which implies in the delocation of 2 dwords:

                mov eax, esp
                enter 8, 0
                sub eax, esp
                ASSERT_EQ 12

                ; Modify 1st local var.
                mov dword [ebp - 4], 1
                ; Modify 2nd local var.
                mov dword [ebp - 8], 2

                leave

    ; # Branching instructions

        ; # Functions

            ; A function is an unconditional branch, but in addition must know:

            ; 1. what adress to return to
            ; 2. how to pass arguments to the func
            ; 3. how to get the return value

            ; These are called the `calling conventions`,
            ; and they may vary with language and implementation.

            ; # Suboptimal calling conventions

                ;this shows how one could go about designing calling conventions,
                ;only to understand that the call ret way is the best

                ; # Simple calling convention

                    ; You could use a calling convention like this
                    ; but this is too inconvenient:

                        ; mov ebx, 1
                        ; mov ecx, $ + 7
                        ; jmp print_ebx_simple_cc

                    ; which would have resd0 1 and would return to the address inside ecx
                    ; however this is inconvenient because:

                    ; 1. the max number of args is limited by the number of registers
                    ; 2. you have to manually calculate which address to return to

                ; # with stack

                    ; Using the stack is the way to go for function calling

                    ; You could do:

                         ; push 1
                         ; push $ + 7
                         ; jmp print_ebx_stack

                    ; and expect the function to take arguments from the stack
                    ; and the address to return to from the stack

                    ; However this is still inconvenient because you have to manually calculate
                    ; the address to come back to.

            ; # call

            ; # ret

                ; Since calling functions is so common,
                ; there are two custom instructions just for that: `call` and `ret`

                ; - `call` pushes adress of next instruction to stack and jumps to lbl.

                    ; As the name suggests, it is used outside of the functions to call them.

                ; - `ret` pops the stack and jumps to the stored address. It therefore undoes `call`.

                ; Using them is the best way to call and return from functions,
                ; since you don't have to manually estimate address delta!

                ; Sample calls of simple calling conventions:

                    mov ebx, 19
                    call print_ebx_call_ret

                    mov  eax, bs4n
                    call print_string

                    mov  eax, 13
                    call print_int

                    ;mov  eax, prompt_int
                    ;call print_string
                    ;call read_int
                    ;mov  [resd0], eax
                    ;call print_int

    ; # floating point

        ; Before reading this, you should understand IEEE floating point formats.

        ; Modern x86 has two main ways of doing floating point operations:

        ; - FPU
        ; - SSE

        ; http://stackoverflow.com/questions/1844669/benefits-of-x87-over-sse

        ; Advantages of FPU:

        ; - present in old CPUs, while SSE2 is only required in x86-64
        ; - contains some instructions no present in SSE, e.g. trigonometric
        ; - higher precision: FPU holds 80 bit Intel extension,
            ; while SSE2 only does up to 64 bit operations despite having the 128-bit register

        ; In GCC, you can choose between them with `-mfpmath=`.

    ; # FPU unit

        ; Used to be a separate optional processor called the Floating Point Unit,
        ; later integrated into the CPU.

        ; # st0

        ; # stX

            ; Stack in which floating operations are carried out.

            ; `st[0-7]` is a stack

            ; `st0` is always the top of the stack.

            ; You can only communicate with `stX` from memory,
            ; not diretly from registers.

            ; For example, the following are errors:

                ;fld eax
                ;fld __float32__(1.5)

        ; # P suffix

            ; Many operation mnemonics have an optional `P` version that also pops the stack.

        ; # floating point literals in .text

        ; # __float32__

            ; To create a constant you need to use the `__float32__` macro.
            ; TODO why? http://stackoverflow.com/questions/29925432/nasm-why-must-float32-1-5-be-used-for-floating-point-literals-instead-of-j

                mov eax, __float32__(1.5)

        ; # double precision

            ; TODO how to use double precision?

        ; Load on floating point stack

            ; # fldz

                ; Float LoaD Zero

                ; st0 = 0

                    fldz
                    mov dword [resd0], __float32__(0.0)
                    fld dword [resd0]
                    fcomip st1
                    ASSERT_FLAG je
                    finit

            ; # fld1

                ; Float Load 1

                ; st0 = 1

                    fld1
                    mov dword [resd0], __float32__(1.0)
                    fld dword [resd0]
                    fcomip st1
                    ASSERT_FLAG je
                    finit

            ; # fldl2e

                ; log_2(e)

            ; # fldl2t

                ; log_2(10)

            ; # fldlg2

                ; log_10(2)

            ; # fldln2

                ; ln(2)

            ; # fldpi

                ; Pi

            ; # fild

                ; Integer Load.

                    fldz
                    mov dword [resd0], 0
                    fld dword [resd0]
                    fcomip st1
                    ASSERT_FLAG je
                    finit

        ; FPU Stack order operations

            ; # fxch

                ; Swap ST0 and another register.

                    fldz
                    fld1

                    fxch st1
                    fld dword [f0]
                    fcomip st1
                    ASSERT_FLAG je

                    fxch st1
                    fld dword [f1]
                    fcomip
                    ASSERT_FLAG je

                    finit

            ; # ffree and Pop.

                ; Remove from stack.

                    fldz
                    fld1
                    ffree st0
                    fld dword [f0]
                    fcomip st1
                    ASSERT_FLAG je
                    finit

                    fldz
                    fld1
                    ffree st1
                    fld dword [f1]
                    fcomip st1
                    ASSERT_FLAG je

        ; # fst

        ; # fstp

            ; Floating STore

            ; Floating STore and Pop.

            ; Move st0 to RAM.

                fldz
                fld dword [f0]
                fstp dword [resd0]
                mov eax, [f0]
                ASSERT_EQ [resd0]

        ; # fcomip

            ; pentium+

            ; Compare STX with ST0 and Pop ST0.

            ; Set integer compare flags.

                fld1
                fldz
                fcomip st1
                ASSERT_FLAG jb
                ; BAD: must use a b with fcomip
                ; TODO why?
                ;ASSERT_FLAG jl
                finit

                fldz
                fld1
                fcomip st1
                ASSERT_FLAG ja
                finit

            ; ERROR: can only compare two registers

                ;fcomip [f1]

        ; # Operations

            ; # fchs

                ; Change Sign.

                ; st0 *= -1

                    fld dword [f1]
                    fchs
                    fld dword[fm1]
                    fcomip st1
                    ASSERT_FLAG je
                    fchs
                    fld dword [f1]
                    ASSERT_FLAG je
                    finit

            ; # fabs

                ; st0 = |st0|

                    fld dword [fm1]
                    fabs
                    fld dword[f1]
                    fcomip st1
                    ASSERT_FLAG je
                    fld dword[f1]
                    fcomip st1
                    ASSERT_FLAG je
                    finit

            ; # fsqrt

                    fld dword [f100]

                    fsqrt
                    fld dword [f10]
                    fcomip st1
                    ASSERT_FLAG je

                    fsqrt
                    mov dword [resd0], __float32__(1.41)
                    fld dword [resd0]
                    fcomip st1
                    ASSERT_FLAG jbe

                    mov dword [resd0], __float32__(1.42)
                    fld dword [resd0]
                    fcomip st1
                    ASSERT_FLAG jae

            ; # fscale

                    fld dword [f1]
                    fld dword [f1]

                    fscale
                    fld dword [f10]
                    fcomip st1
                    ASSERT_FLAG je

                    fscale
                    fld dword [f100]
                    fcomip st1
                    ASSERT_FLAG je

            ;FSIN
            ;FCOS
            ;FSINCOS    ;calc both sin and cos
            ;FPATAN
            ;FPTAN

            ;FPREM      ;remainder
            ;FPREM1     ;remainder

            ;FRNDINT    ;rounds to integer depending on rounding mode

    ; # SIMD

        ; https://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-linux-docs/CellProgrammingTutorial/BasicsOfSIMDProgramming.html

        ; SIMD came in multiple stages: first MMX, then XMM, then SSE[1-4], then AVX.

        ; # SIMD Registers

            ; # MMX

                ; From the MMX extenion.

                ; TODO. Not very useful after SSE: splits 32 bits into multiple sections,
                ; but not any larger than EAX.

            ; # XMM

                ; # movss

                    ; Move Scalar Single precision 32 bits to or from memory.

                        mov dword [resd0], __float32__(0.1)
                        movss xmm0, [resd0]
                        movss xmm1, xmm0
                        movss [resd1], xmm1
                        ASSERT_EQ [resd0], __float32__(0.1), dword

                ; # movups

                    ; Move Unaligned Parallel Single-precision float

                    ; From SSE extensions.

                    ; 16 bytes.

                        MOV4 reso0, 0x0000_0000, 0x1000_0000, 0x2000_0000, 0x3000_0000

                        movups xmm0, [reso0]
                        ; Can also move between two xmm.
                        ; But in this case we can use movaps.
                        movaps xmm1, xmm0
                        movups [reso1], xmm1

                        ASSERT_EQ4 reso1, 0x0000_0000, 0x1000_0000, 0x2000_0000, 0x3000_0000

                    ; ERROR: invalid combination of opcode and operands.

                        ;movups xmm0, 0
                        ;mov xmm0, [reso0]

                    ; Can only move data between RAM and XMM, no literals.

                    ; movups must be used, mov does not work

                ; # movaps

                    ; Aligned.

                    ; May be faster.

                    ; If you attempt to use it on unaligned memory,
                    ; raises a general-protection exception (#GP).
                    ; Let's do that now. One of the following must be misaligned:

                        ;movaps xmm0, [reso0]
                        ;movaps xmm0, [reso0 + 1]

                    ; Linux gives a segmentation fault.

                    ; # aligned

                    ; # unaligned

                        ; TODO why is aligned faster?

                        ; TODO how to align?

                        ; http://stackoverflow.com/questions/381244/purpose-of-memory-alignment


                ; # MOVHPS - Move 64bits to upper bits of an SIMD register (high).

                ; # MOVLPS - Move 64bits to lowe bits of an SIMD register (low).

                ; # MOVHLPS - Move upper 64bits of source  register to the lower 64bits of destination register.

                ; # MOVLHPS - Move lower 64bits of source register  to the upper 64bits of destination register.

                ; # MOVMSKPS - Move sign bits of each of the 4 packed scalars to an x86 integer register.

            ; # AVX

                ; From AVX extensions.

                ; 32 bytes.

        ; # pcmpeqd

            ; Compare each double word of the registers for equality.

        ; # pmovmskb

        ; # VEX prefix

            ; TODO

        ; # packed

        ; # scalar

            ; http://stackoverflow.com/questions/16218665/simd-and-difference-between-packed-and-scalar-double-precision

            ; Many SIMD instructions have two versions: parallel and scalar.

            ; - scalar only acts on the first bytes, doing a single value operation.

                ; It likely exists to allow FPU replacement.

            ; - packed: the more interesting method, which operates on multiple data at once (4 floats or 2 doubles)

        ; # SSE2

            ; # paddq

                ; Packed Add Quadwords (integers).

                    MOV4 reso0, 0x0000_0000, 0x0000_0001, 0x0000_0002, 0x0000_0003
                    MOV4 reso1, 0x0000_0000, 0x1000_0000, 0x2000_0000, 0x3000_0000

                    movups xmm0, [reso0]
                    movups xmm1, [reso1]
                    paddq xmm0, xmm1
                    movups [reso0], xmm0

                    ASSERT_EQ4 reso0, 0x0000_0000, 0x1000_0001, 0x2000_0002, 0x3000_0003

            ; # addps

                ; Add Packed Single precision float.

                    MOV4 reso0, __float32__(0.0), __float32__(0.5), __float32__(0.25), __float32__(0.125)
                    MOV4 reso1, __float32__(0.0), __float32__(1.0), __float32__(2.0), __float32__(4.0)

                    movups xmm0, [reso0]
                    movups xmm1, [reso1]
                    addps xmm0, xmm1
                    movups [reso0], xmm0

                    ASSERT_EQ4 reso0, __float32__(0.0), __float32__(1.5), __float32__(2.25), __float32__(4.125)

            ; # cvttss2si

                ; Convert with Truncation Scalar Single-Precision FP Value to Dword Integer.

                ; Typecast float to int.

                    mov dword [resd0], __float32__(1.5)
                    movss xmm0, [resd0]
                    cvttss2si eax, xmm0
                    call print_int
                    ASSERT_EQ eax, 1

        ; # SSSE3

        ; # SSE4

    ; # Cryptography

        ; https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/x86/crypto?id=refs/tags/v4.0

        ; # AES

            ; https://en.wikipedia.org/wiki/AES_instruction_set

            ; Intel has extended x86 to add instructions to accelerate AES encryption since 2008,
            ; AMD followed. For this reason, the Linux kernel implements AES itself, which allows for hardware acceleration,
            ; and OpenSSL can use the API for it: https://en.wikipedia.org/wiki/AES_instruction_set.
            ; `/proc/cpuinfo` must have the `aes` `CPUID` flag.

            ; TODO example.

    ; # CRC32

    ; # Cyclic redundancy check

        ; http://en.wikipedia.org/wiki/Cyclic_redundancy_check

        ; Pretty specific stuff. Cool. Used by Ethernet for error checking.

    ; # lfence

        ; TODO something to do with out of order

    ; # hlt

        ; Halts, until interrupt or reset.

        ; Giving me seg fault, likely not enough permissions?

    EXIT

TEXT

; Print ebx \n
;
; eax is destroyed
;
; ecx contains the adress to return to
;
print_ebx_simple_cc:
    PRINT_INT ebx
    jmp ecx

; print ebx \n
;
; eax is destroyed
print_ebx_stack:
    PRINT_INT ebx
    pop eax
    jmp eax

; print ebx \n
;
; eax is destroyed
print_ebx_call_ret:
    PRINT_INT ebx
    ret
