# ldd

List required shared libraries of an executable and if they can be found.

`binutils` package.

Is a convenient subset of `readelf -d`

    ldd a.elf

Possible outputs:

- `Not a dynamic executable`
- `liba.1.so => /lib/liba.1.so`
- `liba.1.so => not found`

## Environment

You can also add to path with environment variables.

Don't rely on this method for production.

    export LD_LIBRARY_PATH='/path/to/link'
