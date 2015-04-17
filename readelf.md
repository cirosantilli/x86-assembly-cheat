# readelf

Get information stored inside executable files in a human readable way.

See all information:

    readelf -a a.out

TODO understand all the information, and therefore the entire elf format.

To show only specific informations:

- `-s`: symtable (defined stuff) of elf, `.o` or `.so`
- `-d`: dependencies of an executable (symbols and shared libs)
