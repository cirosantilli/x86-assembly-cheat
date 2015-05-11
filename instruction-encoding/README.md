# Instruction encoding

This section will cover both:

- the actual binary encoding
- how the Intel manual specifies that encoding for each instruction

## Simple examples

### NOP

`0x90` is the simple form.

- Opcode: `90`
- Instruction: `NOP`
- Op / En: `NP`

But also has other multi-byte forms that can be used for alignment.

## Binary instruction organization

- instruction prefixes: 0-4 bytes
- opcode: 1-3 bytes
- ModR/M: 0-1 byte
- SIB: 0-1 byte
- displacement: 0-4 bytes
- immediate: 0-4 bytes

## Instruction documentation format

Each instruction description has the following fields:

- Opcode
- Instruction
- Op / En
- 64-Bit Mode
- Compat / Leg Mode
- `CPUID` feature flag
- Description

They are explained in section 3.1.

### Instruction

E.g.:

    XCHG EAX, r32

Means: takes 2 arguments:

- `EAX`: TODO
- `r32`: a 32-bit register

Other important values:

- `r/m32`: either a 32-bit register or RAM Memory
- `imm32`: value directly encoded on memory

## CPUID feature flag

Which version of CPU support the feature as reported by CPUID.

## Compat / Leg Mode

- valid
- invalid: can be encoded, but generates an exception
- N.E.: not encodable

## 64-bit mode

- V: Supported.
- I: Not supported.
- N.E.: instruction syntax is not encodable in 64-bit mode (it may represent part of a sequence of valid instructions in other modes).
- N.P.: REX prefix does not affect the legacy instruction in 64-bit mode.
- N.I.: opcode is treated as a new instruction in 64-bit mode.
- N.S.: requires an address override prefix in 64-bit mode and is not supported. Using an address override prefix in 64-bit mode may result in model-specific execution behavior

## Bibliography

-   [Intel 64 manual][] Volume 2

    - section 2.1: binary serialization
    - section 3.1: documentation format

-   <http://wiki.osdev.org/X86-64_Instruction_Encoding>

-   <http://www.c-jump.com/CIS77/CPU/x86/lecture.html>
