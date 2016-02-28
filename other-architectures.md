# Other Popular architectures

This tutorial focuses only on the x86 architecture families.

Here are some other popular architectures which you should have in mind as well:

## ARM

<https://en.wikipedia.org/wiki/ARM_architecture>

Great majority of mobile phones.

Low power consumption.

armv7 is a version of arm that added floating point operations: <http://stackoverflow.com/questions/7080525/why-use-armeabi-v7a-code-over-armeabi-code>

## PowerPC

<https://en.wikipedia.org/wiki/PowerPC>

Created by IBM, Motorola and Apple.

But IBM and Motorola are dying, Apple moved to Intel in 2005 for power efficiency, Xbox One and PlayStation 4 moved to x86-64 in 2013.

Used on Nintendo GameCube (2001) up to Wii U (2012), PlayStation 3 and Xbox 360.

Was meant to be the ultimate RISC beats Intel and Windows coalition, but it failed.

## SPARC

<https://en.wikipedia.org/wiki/SPARC>

Created by Sun for its operating system Solaris. Now owned and used by Oracle. Not used much by anyone else.

## MIPS

<http://en.wikipedia.org/wiki/MIPS_instruction_set>

<http://www.androidauthority.com/nintendo-64-android-l-microcontrollers-story-mips-538596/>

Used mostly on embedded systems, and notably video game consoles: Nintendo 64, Sony PlayStation, PlayStation 2.

RISC. Was really hot in 80s, bought by SGI.

Nintendo 64. Supported by Android.

---

Linux runs on all of the above and more: just do a `ls arch` to see the full list.

TODO Windows and Mac OS? Likely they support only x86 on desktop, and have separate ARM portable versions that share some codebase.
