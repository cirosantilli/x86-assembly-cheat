.PHONY: all clean

all:
	$(NASM) -o asm_io$(OBJ_EXT) asm_io.asm
	$(CC) $(CFLAGS) -o driver$(OBJ_EXT) -c driver.c

clean:
	rm -f *$(OBJ_EXT) *$(OUT_EXT)
