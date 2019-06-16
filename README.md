# x86 Assembly Cheat

This repo is moving to: https://github.com/cirosantilli/linux-kernel-module-cheat#userland-assembly

No major new features are intended to be added here.

Notable advantages of LKMC repository include:

- a single unified cross arch setup for ARM and x86_64, with cross arch concepts all nicely factored out
- gem5 support. This is because we have integration of QEMU / gem5 / Buildroot setups already done there
- parallel testing. Mostly because the build system there is Python, which is more flexible.
- other stuff I can't remember right now. That setup just has a ton of features, and will continue to get more and more ;-)

The bulk of this repo was written a long time ago, and so it is semi crappy.

In particular, the use of NASM was a bad choice from before I understood that GCC uses GNU GAS assembly by default. I intend to just migrate NASM examples to GAS, and let NASM die: if you really, want NASM, please checkout just before the migration. NASM devs are cool, but GCC wins.

However, the LKMC infrastructure is already working and completely superior, all that is left if to migrate some missing key concept examples there.

Then all will be left here will bulk instructions, which I will migrate little by little when I'm bored. But this is a trivial mechanical process, and we can never cover all of x86 anyways ;-)

## Old README

[![Build Status](https://travis-ci.org/cirosantilli/x86-assembly-cheat.svg?branch=master)](https://travis-ci.org/cirosantilli/x86-assembly-cheat)

x86 IA-32 and x86-64 userland minimal examples tutorial. Hundreds of runnable asserts. Nice GDB setup. IO done with libc, so OS portable in theory. NASM and GAS covered. Tested in Ubuntu 18.04. Containers (ELF), linking, calling conventions. System land cheat at: <https://github.com/cirosantilli/x86-bare-metal-examples>, ARM cheat at: <https://github.com/cirosantilli/arm-assembly-cheat>

1.  [**Getting started**](getting-started.md)
1.  IA-32
    1.  Base concepts
        1.  [Registers](registers.asm)
            1.  [Segment registers](segment_registers.asm)
        1.  [Addressing](addressing.asm)
        1.  [Endianess](endianess.asm)
    1.  Instructions
        1.  mov family
            1.  [movzx](movzx.asm)
            1.  [movsx](movsx.asm)
            1.  [cmovcc](cmovcc.asm)
            1.  [xchg](xchg.asm)
            1.  [lea](lea.asm)
        1.  Arithmetic
            1.  [cdq](cdq.asm)
            1.  [cwde](cwde.asm)
        1.  [Stack instructions](stack-instrucastions.md)
            1.  [enter](enter.asm)
            1.  [leave](leave.asm)
            1.  [pusha](pusha.asm)
            1.  [pushf](pushf.asm)
        1.  [String instructions](string-instructions.md)
            1.  [rep](rep.asm)
            1.  [cmps](cmps.asm)
            1.  [lods](lods.asm)
            1.  [movs](movs.asm)
            1.  [scas](scas.asm)
            1.  [stos](stos.asm)
        1.  [Floating point](floating-point.md)
            1.  [FPU](fpu.md)
                1.  FPU basic examples, start here
                    1.  [fadd](fadd.asm)
                    1.  [faddp](faddp.asm)
                    1.  [fadd_text_literal](fadd_text_literal.asm)
                1.  Bulk instructions
                    1.  [fabs](fsqrt.asm)
                    1.  [fchs](fchs.asm)
                    1.  [fild](fild.asm)
                    1.  [fld1](fld1.asm)
                    1.  [fldz](fldz.asm)
                    1.  [fscale](fscale.asm)
                    1.  [fsqrt](fsqrt.asm)
                    1.  [fxch](fxch.asm)
            1.  [SIMD](simd.asm)
                1.  [FMA](fma.md)
        1.  [Synchronization](synchronization.md)
            1.  [xadd](xadd.asm)
            1.  [cmpxchg](cmpxchg.asm)
            1.  [bts](bts.asm)
        1.  Misc
            1.  [popcnt](popcnt.asm)
            1.  [rdtsc](rdtsc.asm)
            1.  [nop](nop.asm)
            1.  [cpuid](cpuid.asm)
    1.  [Calling conventions](calling-conventions.md)
        1.  [cdecl](cdecl.md)
        1.  [cdecl examples](cdecl.asm)
        1.  [stdcall](stdcall.asm)
    1.  [Linux](linux/)
        1. [min](linux/min.asm)
        1. [hello_world](linux/hello_world.asm)
        1. [hello_world_min](linux/hello_world_min.asm)
        1. [stack_top.asm](linux/stack_top.asm)
        1. [C from assembly](linux/c-from-assembly/)
        1. [Custom entry](linux/custom-entry/)
        1. [Custom entry GCC](linux/custom-entry-gcc/)
    1.  Infrastructure
        1.  [hello_world.asm](hello_world.asm)
        1.  [lib_test](lib_test.asm)
1.  [x86-64](x86-64/)
    1.  x86_64 general principles
        1.  [cmp sign extend](x86-64/cmp-sign-extend.asm)
        1.  [mov zero extend](x86-64/mov-zero-extend.asm)
    1.  x86_64 instructions
        1.  [cdqe](x86-64/cdqe.asm)
        1.  [movabs](x86-64/movabs.asm)
    1.  [main](x86-64/main.asm)
    1.  [x86_64 Linux system calls](x86-64/linux)
    1.  [x86_64 calling convention](x86-64/calling-convention.md)
        1.  [x86_64 GAS](x86-64/gas)
            1.  [add](x86-64/gas/add.S)
            1.  [clqt](x86-64/gas/clqt.S)
            1.  [x86_64 GAS Linux](x86-64/gas/linux)
                1.  [x86_64 GAS Linux hello world](x86-64/gas/linux/hello_world.S)
    1.  Infrastructure
        1.  [min](x86-64/min.asm)
        1.  [lib_test](x86-64/lib_test.asm)
    1.  C from assembly
        1.  [x86_64 C from assembly hello](x86-64/linux/c-from-assembly/hello.asm)
        1.  [x86_64 printf](x86-64/linux/c-from-assembly/printf.asm)
    1.  [x86-64 inline assembly](x86-64/c)
        1.  [inc](x86-64/c/inc.c)
        1.  [scratch](x86-64/c/scratch.c)
        1.  [x86-64 inline assembly Linux](x86-64/c/linux)
            1.  [hello](x86-64/c/linux/hello.c)
            1.  [hello_regvar](x86-64/c/linux/hello_regvar.c)
1.  [Assemblers](assemblers.md)
    1.  [GAS](gas/)
        1.  Your first GAS examples
            1.  [gas](gas/add.S)
        1.  [GAS Linux hello world](gas/linux/hello.S)
        1.  [Immediate](gas/immediate.S)
        1.  [Addressing](gas/addressing.S)
        1.  [Char literal](gas/char_literal.S)
        1.  [x86_64 GAS](x86-64/gas/)
            1.  [lib_test](x86-64/gas/lib_test.S)
            1.  [cltq](x86-64/gas/cltq.S)
        1.  Symbol scope
            1.  [Local symbol](gas/local_symbol.S)
            1.  [Local label](gas/local_label.S)
        1.  [Current address](gas/current_address.S)
        1.  instructions
            1.  [cbtw](gas/cbtw.S)
            1.  [fadd](gas/fadd.S)
            1.  [movz](gas/movz.S)
            1.  [push](gas/push.S)
        1.  Directives
            1.  [.ascii](gas/ascii.S)
            1.  [.asciz](gas/asciz.S)
            1.  [.equ](gas/equ.S)
            1.  [.extern](gas/extern.md)
            1.  [.gasversion.](gas/gasversion.S)
            1.  [.global](gas/global.S)
            1.  [.print](gas/print.S)
            1.  [.type](gas/type.S)
        1.  [Preprocessor](gas/preprocessor.md)
            1.  [.macro](gas/macro.S)
                1.  [.altmacro](gas/altmacro.S)
            1.  [.irp](gas/irp.S)
            1.  [Comments](gas/comments.S)
        1.  Infrastructure
            1.  [Hello world](gas/hello_world.S)
            1.  [lib_test](gas/lib_test.S)
        1.  [Bibliography](gas/bibliogrpahy.md)
    1.  [NASM](nasm/)
        1.  [RAM](nasm/ram.asm)
            1.  [Symbol colon](nasm/symbol_colon.asm)
        1.  [local labels](nasm/local_labels.asm)
        1.  [equ](nasm/equ.asm)
        1.  [ptr](nasm/ptr.asm)
        1.  [current address](nasm/current_address.asm)
        1.  Preprocessor
            1.  [%define](nasm/define.asm)
            1.  [%if](nasm/if.asm)
            1.  [%include](nasm/include.asm)
            1.  [comments](nasm/comment.asm)
1.  Introduction
    1.  [How to learn](how-to-learn.md)
    1.  [Instruction sets](instruction-sets.md)
        1.  [Other architectures](other-architectures.md)
            1.  [ARM](https://github.com/cirosantilli/arm-assembly-cheat)
            1.  [Microcontrollers](microcontrollers.md)
        1.  [RISC vs CISC](risc-vs-cisc.md)
            1.  [Microcode](microcode.md)
        1.  [System vs application programming](system-vs-application-programming.md)
        1.  [Flynn's Taxonomy](flynns-taxonomy.md)
    1.  [Pros and cons of assembly](pros-and-cons-of-assembly.md)
    1.  [Intel processor history](intel-processor-history.md)
    1.  [Intel vs AT&T syntax](intel-vs-atet.md)
        1.  [intel2gas](intel2gas.md)
    1.  [Implementations](implementations.md)
    1.  [Extensions](extensions.md)
    1.  [CPU architecture](cpu-architecture.md)
        1.  [CPU Optimizations](cpu-optimizations.md)
        1.  [CPU bugs](cpu-bugs.md)
        1.  [Cache](cache.md)
        1.  [Instruction level parallelism](instruction-level-parallelism.md)
            1.  [Pipeline](pipeline.md)
            1.  [Branch prediction](branch-prediction.md)
            1.  [Superscalar](superscalar.md)
            1.  [VLIW](vliw.md)
            1.  [SIMT](simt.md)
        1.  [CPU benchmarks](cpu-benchmarks.md)
1.  [Containers](containers.md)
    1.  [ELF](elf.md)
        1.  [ELF Hello World Tutorial](http://www.cirosantilli.com/elf-hello-world)
1.  Dynamic libraries
    1.  [ld-linux.so](ld-linux-so.md)
        1.  [ldd](ldd.md)
1.  [Compiler generated](compiler-generated/)
1.  [Binutils](binutils.md)
    1.  [ld](ld.md)
        1.  [Linker scripts](linker-scripts/)
    1.  [readelf](readelf.md)
    1.  [objcopy](objcopy.md)
    1.  [objdump](objdump.md)
    1.  [size](size.md)
1.  Related tutorials
    1.  [x86 Instruction Encoding Tutorial](https://github.com/cirosantilli/x86-instruction-encoding-tutorial)
    1.  [C++ Cheat](https://github.com/cirosantilli/cpp-cheat)
1.  [Bibliography](bibliography.md)
