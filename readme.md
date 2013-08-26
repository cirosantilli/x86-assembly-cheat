Assembler scripts and cheatsheets.

Topics not covered here:

- OS specific such as linux sytem calls

	search for those under their own plaftorm (ex: a linux repo)

- compiler specific topics which cannot be done in a portable way
	such as inline assembly ( assembly in the middle of c code )

	look for this info under extensions for each compiler.

The focus for now is x86, but I'd love to get my hands on some
other architecture ot try it out.

#sources

- <http://www.tldp.org/HOWTO/Assembly-HOWTO/index.html>

- <http://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture>

- programming from the ground up

    <http://download.savannah.gnu.org/releases/pgubook/>

    linux gas, for complete programming beginners

- pc assembly language

    <http://www.drpaulcarter.com/pcasm/>

    nasm

#pros and cons

<www.tldp.org/HOWTO/Assembly-HOWTO/x120.html>

##pros

###speed

- use instructions that are so cpu specific and useful for your needs
that compilers don't implement

- use instructions in a way that is smarter than any compiler is likely to do

Note however that it gets harder and harder to make code more efficient using assembler
because compilers are smarter and smarter.

###do the impossible

Access low level hardware which is so hardware specific it is not implemented in standard C.

##cons

###os/processor dependant

You write for a single CPU architecture only.

###hard to read/write

Other things are much more likely to speed up your code
if that's what you want, namely:

- better algorithms
- better cache usage

and only then, using assembly may stand a change to speeding thing up.

#instruction set architectures (ISA)

List of operations the processor can do. Obvioustly ultra processor dependant.

<http://en.wikipedia.org/wiki/Comparison_of_CPU_architectures>

##common architectures

Some of the major architectures are:

- x86 family
- arm

    great majority of mobile phones

    low power consumption

- sparc

##CISC vs RISC

###RISC

Reduced Instruction set

a minimum of operations

performs each one very fast

###CISC

Complex instruction set

lots of operations

it is the case of the x86 family

##flynn's taxonomy

<http://en.wikipedia.org/wiki/Flynn%27s_taxonomy>

- SISD
- SIMD
- MIMD

##SIMD instructions

sincle instruction, multiple data, for example,
making 4 multiplications on a single cpu cycle

more and more, SIMD instructions are being added on different processors

for some time now intel has been grouping those instructions under the `SSE` name

see: <http://neilkemp.us/src/sse_tutorial/sse_tutorial.html>

#assemblers

Programs that transform text in computer code.

##nasm

Netwide assembler (what netwide means, I don't know TODO).

One of the most popular for linux.

Open source.

Intel like syntax.

Input formats:

- `.asm`, intel like syntax

Output formats:

- elf
- pe
- mach-o

##gas

Gnu assembler.

Executable name: `as`.

gcc backend. point up to learning its syntax:
allows you to to understand gcc generated code!

at&t based syntax.

Outputs to lots of different architectures:

- i386
- sparc
- arm

and more.

nasm manual says it is inconvenient to write by hand,
maybe because is is meant to be a gcc backend.

###gcc

gcc can be used as a frontend for gas:

    gcc -S a.c -o a.s
    gcc -masm=att -S a.c -o a.s
    gcc -masm=intel -S a.c -o a.s

##masm

microsoft

x86

##tasm

borland

stands for `turbo` assembler lol, why not `basm` =) ?

windows only
