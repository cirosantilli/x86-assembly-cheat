; Extern definitions and macros to be included source files.

extern  read_int, print_int, print_string
extern	read_char, print_char, print_nl
extern  sub_dump_regs, sub_dump_mem, sub_dump_math, sub_dump_stack

%macro 	dump_regs 1
	push	  dword %1
	call	  sub_dump_regs
%endmacro

; Usage: dump_mem label, start-address, # paragraphs
%macro  dump_mem 3
	push	 dword %1
	push	 dword %2
	push	 dword %3
	call	 sub_dump_mem
%endmacro

%macro	dump_math 1
	push	 dword %1
	call	 sub_dump_math
%endmacro

%macro  dump_stack 3
	push	 dword %3
        push     dword %2
	push	 dword %1
        call     sub_dump_stack
%endmacro
