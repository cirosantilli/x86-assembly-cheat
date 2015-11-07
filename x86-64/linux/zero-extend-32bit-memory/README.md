# Zero extend 32-bit memory

TODO get working.

Attempt to answer:
http://stackoverflow.com/questions/33318342/when-is-it-better-for-an-assembler-to-use-sign-extended-relocation-like-r-x86-64

The goal is to make 2 memory accesses:

- one truncated sign extended to end in 1's
- one with the full address (`movabs`)

Current outcome: as soon as I put a single byte into `.data2`, segfault. Why? Linux does not want to play ball with the high address?
