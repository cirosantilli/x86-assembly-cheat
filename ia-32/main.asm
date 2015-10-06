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

        ; # Array literals

            ; Cannot be put directly into the code, as they:

            ; - would take multiple instructions to load
            ; - would occupy memory many times if used many times

                bs4 db 0, 1, 2, 3 ; TODO Unused
                bs4_2 db 0, 0, 0, 0 ; TODO Unused
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

                ; Automatically incremented by the string instructions.

                ; Whenever you are not dealing with string instructions,
                ; those registers are useful for general purpose.

                ; On real mode, they have other segment related properties.

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

    ; # RAM memory

        ; Adresses in RAM memory.

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
