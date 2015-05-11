# x86-64

# x86_64

# x64

# AMD64

64 bit architecture, originally by AMD, and later implemented with great (but not complete) compatibility Intel.

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

## Long mode

<https://en.wikipedia.org/wiki/Long_mode>

Contains two sub-modes: 64-bit and compatibility.

64-bit is the major mode of operation, compatibility mode emulates IA-32.

The other mode is legacy mode, which as the name implies, should not be used on new programs.

### Compatibility mode

Controlled by the `CS.L` bit of the segment descriptor.

It appears that it is possible for user programs to modify that during execution: <http://stackoverflow.com/questions/12716419/can-you-enter-x64-32-bit-long-compatibility-sub-mode-outside-of-kernel-mode>

<http://stackoverflow.com/questions/27868394/switch-from-64-bit-long-mode-to-32-bit-compatibility-mode-on-x64>
