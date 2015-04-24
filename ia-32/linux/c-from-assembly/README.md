# C from assembly

TODO broken. Exit status 36.

Call C from assembly.

This is not portable because ANSI C does not specify the ABI.

Things which may vary include:

- calling conventions
- method names. E.g. Watcom uses `puts_` instead of `puts`
