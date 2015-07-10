# C from assembly

Call the C standard library from assembly.

This is not OS portable because ANSI C does not specify the ABI.

Things which may vary include:

- calling conventions
- method names. E.g. Watcom uses `puts_` instead of `puts`

The only way to deal with that is by treating each implementation differently with macros.

The following methods are covered:

- `main/`: `main` function in assembly
- `start/`: `_start` function in assembly, and link with `ld`
- `start-gcc/`: `_start` function in assembly, and link with `gcc`
