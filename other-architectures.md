# Other architectures

This tutorial focuses only on the x86 architecture families.

Here are some other popular architectures which you should have in mind as well:

## ARM

<https://en.wikipedia.org/wiki/ARM_architecture>

Great majority of mobile phones.

Low power consumption.

RISC.

armv7 is a version of arm that added floating point operations: <http://stackoverflow.com/questions/7080525/why-use-armeabi-v7a-code-over-armeabi-code>

### Open implementations

<https://en.wikipedia.org/wiki/Amber_%28processor_core%29> TODO how does it compare in performance / cost?

ARM has already sued people in the past for implementing ARM ISA: http://www.eetimes.com/author.asp?section_id=36&doc_id=1287452 so not open.

<http://semiengineering.com/an-alternative-to-x86-arm-architectures/>:

> Asanovic joked that the shortest unit of time is not the moment between a traffic light turning green in New York City and the cab driver behind the first vehicle blowing the horn; it’s someone announcing that they have created an open-source, ARM-compatible core and receiving a “cease and desist” letter from a law firm representing ARM.

## PowerPC

<https://en.wikipedia.org/wiki/PowerPC>

Created by IBM, Motorola and Apple.

But IBM and Motorola are dying, Apple moved to Intel in 2005 for power efficiency, Xbox One and PlayStation 4 moved to x86-64 in 2013.

Used on Nintendo GameCube (2001) up to Wii U (2012), PlayStation 3 and Xbox 360.

## MIPS

<http://en.wikipedia.org/wiki/MIPS_instruction_set>

RISC. Was really hot in 80s, bought by SGI. More recently bought by Imagination Technologies <https://en.wikipedia.org/wiki/Imagination_Technologies>.

Used mostly on embedded systems, and notably video game consoles: Nintendo 64, Sony PlayStation, PlayStation 2.

Officially supported on Android.

<http://www.androidauthority.com/nintendo-64-android-l-microcontrollers-story-mips-538596/>

### Open implementations

Seems closed?

Open implementation: <https://brej.org/yellow_star/> TODO legal?

## SPARC

<https://en.wikipedia.org/wiki/SPARC>

Created by Sun for its operating system Solaris. Now owned and used by Oracle. Not used much by anyone else.

Was meant to be the ultimate RISC beats Intel and Windows coalition, but it failed.

## SuperH

<https://en.wikipedia.org/wiki/SuperH>

Renesas.

Some patents expired: <https://youtu.be/lZGHbMS882w?t=281>

### j-core

Open implementation.

<http://j-core.org/>

<https://www.youtube.com/watch?v=lZGHbMS882w> Linux Foundation Events - Building a CPU from Scratch: jcore Design Walkthrough by Rob Landley & Jeff Dionne 

## LEON

<https://en.wikipedia.org/wiki/LEON>

Open architecture based on SPARC made by <https://en.wikipedia.org/wiki/European_Space_Agency>

## DLX

<https://en.wikipedia.org/wiki/DLX>

## Operating systems

Linux runs on tons of major archs: just do a `ls arch` to see the full list.

TODO Windows and Mac OS? Likely they support only x86 on desktop, and have separate ARM portable versions that share some codebase.

- <http://superuser.com/questions/1062487/did-windows-ever-support-any-hardware-architectures-other-than-x86>
