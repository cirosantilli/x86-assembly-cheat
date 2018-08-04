.PHONY: all clean

all:
	$(NASM) -dELF_TYPE -o common$(OBJ_EXT) common.asm
	$(CC) $(CFLAGS) -o driver$(OBJ_EXT) -c driver.c

clean:
	rm -f *$(OBJ_EXT) *$(OUT_EXT)
