# Synchronization

TODO understand better and make multithreaded examples that fail.

TODO Other sync instructions:

- MFENCE
- LFENCE
- SFENCE

Likely should be done with inline assembly. TODO: is it possible to test those things here (see failures) e.g. under the Linux kernel, or do we need to go bare metal?

- http://stackoverflow.com/questions/4725676/how-does-x86-pause-instruction-work-in-spinlock-and-can-it-be-used-in-other-sc
- http://stackoverflow.com/questions/6935442/x86-spinlock-using-cmpxchg
- http://stackoverflow.com/questions/11959374/fastest-inline-assembly-spinlock
- http://wiki.osdev.org/Spinlock

## Lock prefix

- http://stackoverflow.com/questions/11065675/lock-prefix-of-intel-instruction-what-is-the-point-its-function-is-so-limited
- http://stackoverflow.com/questions/3339141/x86-lock-question-on-multi-core-cpus
- http://stackoverflow.com/questions/8891067/what-does-the-lock-instruction-mean-in-x86-assembly
- http://stackoverflow.com/questions/3343589/how-do-i-use-the-lock-asm-prefix-to-read-a-value

Can be used with: ADD, ADC, AND, BTC, BTR, BTS, CMPXCHG, CMPXCH8B, DEC, INC, NEG, NOT, OR, SBB, SUB, XOR, XADD, and XCHG
