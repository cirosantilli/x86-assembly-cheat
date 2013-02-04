%include "lib/asm_io.inc"
  ;#include

section .data
  ;initialized data

  B0 db 0        ;byte labeled B0 with initial value 0
  B1: db 110101b  ;byte initialized to binary 110101 (53 in decimal)
  B2 db 12h      ;byte initialized to hex 12 (18 in decimal)
  B3 db 17o      ;byte initialized to octal 17 (15 in decimal)
  B4 db "A"      ;byte initialized to ASCII code for A (65)

  W0 dw 1000     ;word labeled W0 with initial value 1000
  D0 dd 1A92h    ;double word initialized to hex 1A92

;arrays
  BS4  db 0, 1, 2, 3
    ; defines 4 bytes
  B10 times 10 db 0
    ; equivalent to 10 (db 0)’s

;strings
  BS5 db "a", "b", "c", 'd', 10
    ; "abcd\n"
	BS5L  equ $-BS5
	  ;strlen(s)
  BS5_2 db 'abcd', 10
    ;same
  BS4N db 'abc', 0
    ;null terminated

  prompt_int db "enter int: ", 0

section .bss
  ;unitialized data

  BU resb 1
    ;1 uninitialized byte
  WS10 resw 10
    ;reserves room for 10 words

  input resd 1

section .text
  ;instructions

	;global _start
	  ;no c interfacing
	global asm_main
	  ;c interfacing

asm_main:

  enter 0,0
  pusha

  ;registers
    inc eax
    inc ax
    inc al
    inc ah
    inc ebx
    inc ecx
    inc edx

  ;flags
  ;{
    ;carry
      stc
        ;CF = 1
      clc
        ;CF = 0
      cmc
        ;complement CF
      jc jclabel
      jclabel:
      jnc jnclabel
      jnclabel:
  ;}

  ;instructions

    mov eax,0
      ;eax=0
    mov eax,ebx
      ;eax=ebx
    ;mov eax,bx
      ;eax=ebx

    ;movzx
      ;mov and zero extend
      ;works for unsigned numbers

      movzx eax, ax
        ;eax=00ax
      movzx ebx, al
        ;ebx=000al
      movzx ax, al
        ;ax=0al
      ;movzx al, al
        ;ERROR
        ;same size
        ;first register must be larger
      ;movzx eax, 0
        ;ERROR
        ;must be a register

    ;movsx
      ;mov and sign extend
      ;in 2s complement, just extend sign bit
      ;there are many anterior commands that do this
      ;for specific sizes, created before 32 bit registers

      movsx eax, ax
      movsx ebx, al
      movsx ax, al

    add eax,1
      ;eax=eax+1
    add eax,ebx
      ;eax=eax+ebx
    add eax,"a"
      ;ascii
    ;add ax,al
    ;add ax,eax
      ;ERROR
      ;second register must be same size
    ;add eax,"ab"
      ;ERROR

    ;extended sum
      add eax, ecx
      adc edx, ebx ;edx += (ebx + carry)
        ;edx:eax += ebx:ecx

    sub eax,1
      ;eax=eax-1

    ;extended subtract
      sub eax,ecx
      sbb edx,ebx ;edx -= (ebx + carry)
        ;edx:eax -= ebx:ecx

    inc eax
      ;eax++
    dec eax
      ;eax--


    mov eax,2
    imul eax
      ;edx:eax = eax * eax
    imul eax,2
      ;eax *= 2
    imul eax,ebx,2
      ;eax = ebx * 2
    ;imul eax,2,2
      ;ERROR
      ;second must be register

    cdq
      ;sign extend edx from eax
    mov ecx,100
    idiv ecx
      ;eax = quotient edx:eax / ecx
      ;edx = remainder edx:eax / ecx

  ;labels
    ;RAM memory
    mov al, [B0]  ;copy byte at B0 into AL
    mov eax, B0   ;EAX = address of byte at B0
    mov [B0], ah  ;copy AH into byte at B0

    mov eax, [D0] ;copy double word at D0 into EAX
    add eax, [D0] ;EAX = EAX + double word at D0
    add [D0], eax ;double word at D0 += EAX
    mov al, [D0]  ;copy first byte of double word at D0 into AL

    ;mov [D0], 1
      ;ERROR
      ;should overwrite how many bytes of D0?
    mov dword [D0], 1

  ;directives
    ;do not translate directy into cpu

  %define SIZE 10
    ;#define  SIZE 10
    mov eax,SIZE

  ;linux system calls

    ;sys_write
      mov eax,4         ;sys_write
      mov ebx,1         ;file descriptor 1
      mov ecx,BS5       ;pointer to string
      mov edx,BS5L      ;string len
      int 80h         

    ;sys_exit
      ;mov eax,1        ;sys_exit
      ;mov ebx,0        ;exit status
      ;int 80h

  ;c interfacing

    mov  eax, BS4N
    call print_string       ;printf("%s")
    call print_nl           ;puts("")

    mov  eax,13
    call print_int          ;printf("%d")

    ;mov  eax, prompt_int
    ;call print_string
    ;call read_int
    ;mov  [input], eax
    ;call print_int
    ;call print_nl          ;scanf("%d")

    popa
    mov eax,0
    leave
    ret
