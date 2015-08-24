# Instruction set architectures (ISA)

List of operations the processor can do. Obviously ultra processor dependant.

- <http://en.wikipedia.org/wiki/Comparison_of_CPU_architectures>
- <http://en.wikipedia.org/wiki/Instruction_set>

## Popular architectures

Some of the major architectures are:

-   x86 family. See: [IA-32](ia32.md).

    Dominates the desktop market.

-   ARM

    Great majority of mobile phones.

    Low power consumption.

-   PowerPC

    Created by IBM, Motorola and Apple. But IBM and Motorola are dying, Apple moved to Intel in 2005, Xbox One and PlayStation 4 moved to x86-64 in 2013.

    Used on Nintendo GameCube (2001) up to Wii U (2012), PlayStation 3 and Xbox 360.

-   SPARC

    Created by Sun for its operating system Solaris. Now owned and used by Oracle. Not used much by anyone else.

-   <http://en.wikipedia.org/wiki/MIPS_instruction_set>

    Used mostly on embedded systems, and notably video game consoles: Nintendo 64, Sony PlayStation, PlayStation 2.

Linux supports all the above. TODO Windows and Mac OS? Likely they support only x86 on desktop, and have separate ARM portable versions.

## CISC vs RISC

### RISC

Reduced Instruction set.

Has few operations, but performs each one very fast.

#### One instruction set compiler

Takes it to the limit:

<https://en.wikipedia.org/wiki/One_instruction_set_computer>

Funny example implementation for C in x86 `mov`: <https://github.com/xoreaxeaxeax/movfuscator>

### CISC

Complex instruction set.

Lots of operations.

x86 is considered CISC, although it is known that the processor has a RISC core.

ARM is considered RISC.

### Microcode

### RISC core

Intel processors have a large front-end that decodes every instruction to a simpler internal undocumented and unaccessible instruction set.

The undocumented internal instructions are also known as microcode.

The internal microcode interpreter is known as the RISC core.

It also seems that microcode can be changed with firmware updates.

<http://stackoverflow.com/questions/4366837/what-is-intel-microcode>

<http://stackoverflow.com/questions/5806589/why-does-intel-hide-internal-risc-core-in-their-processors>

## Flynn's taxonomy

<http://en.wikipedia.org/wiki/Flynn%27s_taxonomy>

- SISD
- SIMD
- MIMD

## SIMD instructions

Single instruction, multiple data, for example, making 4 multiplications on a single CPU cycle.

More and more, SIMD instructions are being added on different processors.

For some time now Intel has been grouping those instructions under the `SSE` name.

See: <http://neilkemp.us/src/sse_tutorial/sse_tutorial.html>

## System programming vs application instructions

Most architectures provide two general sets of instructions:

-   system programming: instructions that only operating system writers will need.

    Application programs are generally forbidden from even using such instructions by security measures.

    This allows for example for process separation: preventing one process from seeing the other's memory, reducing the impact of bugs and malicious attacks.

-   application programming. Instructions that any program can use.

    Those will be usually packaged inside executable wrappers of some sort, e.g. ELF, which add required metadata to the instructions, e.g. where to find shared libraries.

It is common for manuals to separate those into separate chapters.
