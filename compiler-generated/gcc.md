# GCC

## Optimizations

Without any flags, GCC will do several minor optimizations that make the code hard to read for beginners. Don't be afraid :-)

Common ones:

- `lea`: `add` and `mov`
- `xor eax, eax`: `mov $0`
- function inlining
- RIP addressing as it is shorter

## Label names

<http://stackoverflow.com/a/30212164/895245>
