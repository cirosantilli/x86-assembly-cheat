# Pros and cons of assembly

Assembly vs. higher level languages like C.

## Pros

### Speed

-   Use instructions that are so CPU specific and useful for your needs that compilers don't implement.

-   Use instructions in a way that is smarter than any compiler is likely to do.

Note however that it gets harder and harder to make code more efficient using assembler because compilers are smarter and smarter.

### Do the impossible

Access low level hardware which is so hardware specific it is not implemented in standard C.

## Cons

### OS/processor dependant

You write for a single CPU architecture only.

### Hard to read/write

Other things are much more likely to speed up your code if that's what you want, namely:

- better algorithms
- better cache usage

and only then, using assembly may stand a change to speeding thing up.
