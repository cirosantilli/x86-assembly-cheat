# Global structure

Legend: `X-Y: description`, where `X` is the minimum, and `Y` is the maximum number of bytes.

- 0-4: instruction prefixes
- 1-4: opcode
- 0-1: ModR/M
- 0-1: SIB
- 0-4: displacement
- 0-4: immediate

The most interesting bytes to start learning are the opcode and ModR/M.

## Opcode

Says which instruction is being run.

## ModR/M

Says where data is being moved to. Bits:

    0 1 2 3 4 5 6 7
    ^^^ ^^^^^ ^^^^^
    1   2     3

1.  MOD

    Determines how the next fields are interpreted.

    - 00: Indirect addressing mode.
    - 01: Same as 00 but a 8-bit displacement is added to the value before dereferencing.
    - 10: same as 01 but a 32-bit displacement is added to the value.
    - 11: Direct addressing mode. Move the value in the source register to the destination register. Reg and R/M byte will each refer to a register. 

2.  REG

    - 000 (0): EAX (AX if data size is 16 bits, AL if data size is 8 bits)
    - 001 (1): ECX/CX/CL
    - 010 (2): EDX/DX/DL
    - 011 (3): EBX/BX/BL
    - 100 (4): ESP/SP (AH if data size is defined as 8 bits)
    - 101 (5): EBP/BP (CH if data size is defined as 8 bits)
    - 110 (6): ESI/SI (DH if data size is defined as 8 bits)
    - 111 (7): EDI/DI (BH if data size is defined as 8 bits)

3.  R/M

## Prefixes

### 66

If given while on 16 bit mode, treat the memory as 32 bit.

If given while on 32 bit mode, treat the memory as 16 bit.
