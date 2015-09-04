# objcopy

## Extract content from a section

<http://stackoverflow.com/questions/3925075/how-do-you-extract-only-the-contents-of-an-elf-section>

## Separate debug information from executable

<http://stackoverflow.com/questions/866721/how-to-generate-gcc-debug-symbol-outside-the-build-target>

    objcopy --only-keep-debug "${from}" "${to}"
    strip --strip-debug --strip-unneeded "${from}"
    objcopy --add-gnu-debuglink="${to}" "${from}"
