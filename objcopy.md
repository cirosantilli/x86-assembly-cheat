# objcopy TODO

## Separate debug information from executable

<http://stackoverflow.com/questions/866721/how-to-generate-gcc-debug-symbol-outside-the-build-target>

    objcopy --only-keep-debug "${from}" "${to}"
    strip --strip-debug --strip-unneeded "${from}"
    objcopy --add-gnu-debuglink="${to}" "${from}"
