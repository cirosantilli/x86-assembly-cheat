# Intel manual format

How the Intel manual documents the instruction encodings.

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

### CPUID feature flag

Which version of CPU support the feature as reported by CPUID.

### Compat / Leg Mode

- valid
- invalid: can be encoded, but generates an exception
- N.E.: not encodable

### 64-bit mode

- V: Supported.
- I: Not supported.
- N.E.: instruction syntax is not encodable in 64-bit mode (it may represent part of a sequence of valid instructions in other modes).
- N.P.: REX prefix does not affect the legacy instruction in 64-bit mode.
- N.I.: opcode is treated as a new instruction in 64-bit mode.
- N.S.: requires an address override prefix in 64-bit mode and is not supported. Using an address override prefix in 64-bit mode may result in model-specific execution behavior
