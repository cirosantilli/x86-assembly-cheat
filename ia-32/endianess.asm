/*
x86 is little endian.

http://stackoverflow.com/questions/5185551/why-is-x86-little-endian
*/

%include "lib/asm_io.inc"

section .data
    x dw 0x0102
ENTRY
    ASSERT_EQ [x], 2, byte
    EXIT
