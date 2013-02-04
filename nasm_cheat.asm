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
  BS52 db 'abcd', 10
    ;same

section .bss
  ;unitialized data

  BU resb 1
    ;1 uninitialized byte
  WS10 resw 10
    ;reserves room for 10 words

section .text
	global _start

_start:

;instructions

  mov eax,0
    ;eax=0
  mov ebx,1
    ;ebx=1
  mov eax,ebx
    ;eax=ebx

  add eax,1
    ;eax=eax+1
  add eax,ebx
    ;eax=eax+ebx
  sub eax,1
    ;eax=eax-1

  inc eax
    ;eax++
  dec eax
    ;eax--

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

;system calls

  ;sys_write
	mov eax,4         ;sys_write
	mov ebx,1         ;file descriptor 1
	mov ecx,BS5       ;pointer to string
	mov edx,BS5L      ;string len
  int 80h         

  ;sys_exit
	mov eax,1        ; The system call for exit (sys_exit)
	mov ebx,0        ; Exit with return code of 0 (no error)
	int 80h
