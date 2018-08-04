.PHONY: all clean

all:
	$(NASM) -o common$(OBJ_EXT) common.asm
	$(CC) $(CFLAGS) -o driver$(OBJ_EXT) -c driver.c

clean:
	rm -f *$(OBJ_EXT) *$(OUT_EXT)
