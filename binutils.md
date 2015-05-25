# binutils

GNU set of utilities to compile and view and modify compiled code.

Official site: <http://sourceware.org/binutils/>.

As stated there, the two main utilities are `ld`, the GNU linker, and `as` the gnu assembler.

Binutils is a dependency of GCC: GCC deals with the high level to assembler source translation, and Binutils does the rest.

Also contains GDB.

## Source tree

    git clone git://sourceware.org/git/binutils-gdb.git
    cd binutils-gdb
    git checkout binutils-2_25
    cd ..
    mkdir binutils-gdb-build
    cd binutils-gdb-build
    ../binutils-gdb/configure --with-sysroot=/
    make
    sudo make install

Why `--sysroot` is needed <https://sourceware.org/ml/binutils/2007-02/msg00274.html>. Why not make it the default?!
