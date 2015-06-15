# C from assembly

Call C from assembly.

This is not portable because ANSI C does not specify the ABI.

Things which may vary include:

- calling conventions
- method names. E.g. Watcom uses `puts_` instead of `puts`

The only way to deal with that is by treating each implementation differently with macros.
