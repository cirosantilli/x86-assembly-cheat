# Intel processor history

Intel is highly backwards compatible and hugely influential, so understanding their processor history helps to understand terms and concepts which are still relevant.

## Intel 4004

<https://en.wikipedia.org/wiki/Intel_4004>

The first commercial integrated CPU in the world. Huge breakthrough.

## Intel 8080

1974, 8 bit, 2MHz. Hit a price / performance point that kick-started the PC revolution: Apple, Microsoft, etc.

Before it, computers were huge machines for large corporations only.

## Intel 8086

1976, 16 bit, very popular, base to x86 IA.

TODO why `86`?

## Intel 80386

aka i386

1985, 32 bit word register

## Intel 8087

1980

External floating point co-processor for the 8086.

In other words: this is not a CPU, but something external to the CPU, which the CPU could interface with.

Included inside CPUs starting from the 80436

x87 often used to describe the floating point operations inside the processors

Instructions include:

- `FSQRT`
- `FSIN`

## Intel 80486

1989

Includes floating point unity inside of it

## Intel Core

Generic Intel branding since 2007.

## i3

## i5

## i7

Generic branding by Intel since 2010.

They just mean low, mid and high end, nothing else is implied, not even the number of cores.

A much more meaningful way to group the processors is by the architecture, e.g. Ivy Bridge, Haswell, etc.

Each architecture is also referred to a generation, which started counting with the Nehalem, so for example Ivy Bridge is the 3rd generation.

To be really precise, you have to talk about the model ID for each processor Those are of the form:

    iA-BXXXL

for example:

    i5-3210M

where:

- `A`: is a letter `i3`, `i5`, `i7` low, mid and high level marker
- `B`: is usually the generation, e.g. 3 for Ivy Bridge.
- `XXX`: further specifies the model
- `L`: zero or more letters that further specify the type of the CPU, e.g. `M` is often used for mobile targeted CPUs

## SIMD instructions

Single instruction operating on Multiple Data at the same time.

Intel has released many iterations:

- MMX: 1997
- SSE:
- SSE2:
- SSE3:
- SSSE3:
- SSSE3:
- SSE4:
- AVX: 2011
