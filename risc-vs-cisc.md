# RISC vs CISC

The distinction between RISC and CISC is not a precise one, only a subjective quantitative description.

## RISC

Reduced Instruction set.

Has few operations, but performs each one very fast.

### One instruction set compiler

Takes it to the limit:

<https://en.wikipedia.org/wiki/One_instruction_set_computer>

Funny example implementation for C in x86 `mov`: <https://github.com/xoreaxeaxeax/movfuscator>

## CISC

Complex instruction set.

Lots of operations.

x86 is considered CISC, although it is known that the processor has a RISC core.

ARM is considered RISC.

## RISC core

The distinction between RISC and CISC is further blurred by the fact that Intel X86, widely condiered CISC is actually composed of:

- a complex instruction decoder, which transforms complex input instructions into a simpler subset called microcode
- a RISC core which understands the microcode and actually runs it
