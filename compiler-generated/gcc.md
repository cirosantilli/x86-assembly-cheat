# GCC

Tested with: GCC 4.8.

## Optimizations

Without any flags, GCC will do several minor optimizations that make the code hard to read for beginners. Don't be afraid :-)

Common ones:

- `lea`: `add` and `mov`
- `xor eax, eax`: `mov $0`
- function inlining
- RIP addressing as it is shorter

## Label names

<http://stackoverflow.com/a/30212164/895245>

## Optimizations

-   `RBP` optimized out `-fomit-frame-pointer`

-   operate on the correct register for the return value

        int f(i, j) { return i + j; }

    is doable in a single `lea`.
