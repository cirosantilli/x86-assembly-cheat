; See what `esp` is worth at initialization.
;
; Pass the output of this through `hd` to see it.
;
; Expected outcome: two ints, 4 bytes apart, close to 4Gb.
;
; A little less than 4Gb and random because of ASLR.
;
; The kernel sets esp to it when the program is started:
; this is how it communicates it to the application.
;
; This is specified by the AMD64 ABI.

%macro print_address 1
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    ; Little endian is easier for humans to read.
    bswap ecx
    mov [resd0], ecx
    mov ecx, resd0
    mov edx, 4
    int 80h
%endmacro

section .bss

    resd0 resd 1

section .text

    global _start
    _start:

        print_address _start

        print_address esp
        push 1
        print_address esp

        mov eax, 1
        mov ebx, 0
        int 0x80
