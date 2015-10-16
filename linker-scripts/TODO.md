# TODO

-   Factor out examples in this repository.

    The major pain point is:

    -   using the C standard library (through the ia-32 directory) requires GCC (TODO true?), which I cannot get to work without the default script
    -   not using the C library loses all portability so I'd have to reimplement a bunch of things

    One possible alternative is to limit ourselves to two system calls only: write and exit, and to unit testing from an external script.
