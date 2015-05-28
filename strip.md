# strip

Remove parts object executables like specific symbols or debugging information.

## Default

By default, `strip` , removes the entire `.symtab`.

## g

Remove debug information:

    strip -g a.out
