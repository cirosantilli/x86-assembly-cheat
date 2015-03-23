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

-   SPARC

    Created by Sun for its operating system Solaris. Now owned and used by Oracle. Not used much by anyone else.

-   PowerPC

    Created by IBM, Motorola and Apple. But IBM and Motorola are dying, and Apple moved to Intel in 2005.

Linux supports all the above. TODO Windows and Mac OS? Likely they support only x86 on desktop, and have separate ARM portable versions.

## CISC vs RISC

### RISC

Reduced Instruction set.

Has few operations, but performs each one very fast.

### CISC

Complex instruction set.

Lots of operations.

It is the case of the x86 family.

## Flynn's taxonomy

<http://en.wikipedia.org/wiki/Flynn%27s_taxonomy>

- SISD
- SIMD
- MIMD

## SIMD instructions

Single instruction, multiple data, for example, making 4 multiplications on a single CPU cycle.

More and more, SIMD instructions are being added on different processors.

For some time now Intel has been grouping those instructions under the `SSE` name.

see: <http://neilkemp.us/src/sse_tutorial/sse_tutorial.html>

