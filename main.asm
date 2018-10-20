; TODO: this file is being split up into smaller files
;
; TODO: split nasm concepts from IA-32 concepts.
;
; Main cheat on the x86 architecture and on NASM.

%include "lib/common_nasm.inc"

; # extern

    ; Same as C extern

    ; C compilers automatically link to libc, so all we need to use
    ; C stdlib functions when using the c driver is to declare them
    ; extern and then follow the c calling convention.

; # macro

    ; # Define macros

        ; # Inner macro labels

            ; Labels inside macros prefixed by `%%` are special:
            ; for each macro invocation they generate a new unique label,
            ; which is not visible on the object files.

            ; This allows macros to behave like functions.

            ; TODO example

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
                ; because `$` is the cur address

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

    ; # Functions

        ; A function is an unconditional branch, but in addition must know:

        ; 1. what address to return to
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

            ; - `call` pushes address of next instruction to stack and jumps to lbl.

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

            ; # far call

            ; # far ret

                ; Both call and ret have a form that jumps across segments.

                ; It is analogous to far jumps, and can only be done in ring 0.

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
; ecx contains the address to return to
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
