# x86-64

This section highlights differences from x86: learn that first.

x86_64 is a bit architecture, originally by AMD, and later implemented with great (but not complete) compatibility Intel.

Intel calls their implementation "Intel 64" but it used "IA-32e" and "EM64T" before, AMD says AMD64, Apple x86-64 and x86_64, and Microsoft and Oracle x64. Notice the great naming uniformity.

Do not confuse with IA-64, which is the old name for the Itanium architecture, a completely different architecture developed by Intel, which largely lost to the x86-64 alternative that AMD first proposed.

## x86-64 vs IA-32

x86-64 has a compatibility mode which allows running IA32 code directly on it.

In 64-bit mode, outside of compatibility mode, most instructions are analogous, but a few have been removed.

The major difference added in x86-64 is the possibility of making 8 byte operations instead of 4.

Most operations still exist and are analogous but some have changed or been removed. But if you turn on compatibility mode, it works with IA32 code.

Lots of new registers were added in particular `r9` - `r16` and extra XMM.

SSE and SSE2 are required in x86-64. This is why, for example, the AMD64 calling convention can use XMM registers to pass floats.

RIP addressing mode.

## Incompatibilities between Intel and AMD

<http://stackoverflow.com/questions/29833938/what-is-the-compatible-subset-of-intels-and-amds-x86-64-implementations>

<https://en.wikipedia.org/wiki/X86-64#Differences_between_AMD64_and_Intel_64>

Mostly on the systems programming instructions, not application.
