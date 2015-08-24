# strip

Remove every non-crucial information on of an executable file in-place:

    strip a.out

This includes symbols and debugging information.

Note that GCC keeps symbols around even at `-g0`, so at least you can do stuff like:

    break function

in GDB. Without symbols, you can't even do that, and debugging becomes way harder. Such executables are mostly obfuscated viruses, and you will need pro tools to understand them quickly, like IDA Pro: <http://reverseengineering.stackexchange.com/questions/1935/how-to-handle-stripped-binaries-with-gdb-no-source-no-symbols-and-gdb-only-sho>, <http://reverseengineering.stackexchange.com/questions/1817/is-there-any-disassembler-to-rival-ida-pro>

## Default

By default, `strip` , removes the entire `.symtab`.

## g

Remove debug information:

    strip -g a.out
