CFLAGS=$(OSFLAGS) -O2 -Wall -D_FILE_OFFSET_BITS=64

include osdetect.mk

ifeq ($(OS_64BIT),1)
$(info --- Compiling for 64-bit arch ---)
CFLAGS += -m64
ifeq ($(OS),Mac)
SHABAL=shabal64-darwin
else
SHABAL=shabal64
endif
endif

ifeq ($(OS_32BIT),1)
$(warning --- Compiling for 32-bit arch --- (NOT RECOMMENDED, THIS WILL AFFECT YOUR MAXIMUM PLOT SIZE))
CFLAGS += -m32
SHABAL=shabal32
endif

$(info CFLAGS=$(CFLAGS))

ifeq ($(OS),Windows)
all:		optimize.exe
else
all:		plot optimize mine mine_pool_all mine_pool_share
endif

optimize.exe:	optimize.c
		x86_64-w64-mingw32-gcc-4.8 $(CFLAGS) -o $@ $^

plot:		plot.c $(SHABAL).o helper.o
		gcc $(CFLAGS) -o $@ $^ -lpthread

mine:		mine.c $(SHABAL).o helper.o
		gcc $(CFLAGS) -DSOLO -o $@ $^ -lpthread

mine_pool_all:	mine.c $(SHABAL).o helper.o
		gcc $(CFLAGS) -DURAY_POOL -o $@ $^ -lpthread

mine_pool_share:	mine.c $(SHABAL).o helper.o
		gcc $(CFLAGS) -DSHARE_POOL -o $@ $^ -lpthread

optimize:	optimize.c helper.o
		gcc $(CFLAGS) -o $@ $^

helper.o:	helper.c
		gcc $(CFLAGS) -c -o helper.o helper.c		

shabel64-darwin.o:	shabal64-darwin.s
		gcc -Wall -m64 -c -o $@ $^

shabal64.o:	shabal64.s
		gcc -Wall -m64 -c -o $@ $^

shabal32.o:	shabal32.s
		gcc -Wall -m32 -c -o $@ $^

clean:
		rm -f shabal64.o shabal32.o helper.o plot optimize mine mine_pool_all mine_pool_share optimize.exe

