CFLAGS=$(OSFLAGS) -O2 -Wall -D_FILE_OFFSET_BITS=64

include osdetect.mk

ifndef AVX2
AVX2=1
endif

ifeq ($(OS_64BIT),1)
$(info --- Compiling for 64-bit arch ---)
CFLAGS += -m64
SHABAL_SSE4=mshabal_sse4.o
  ifeq ($(AVX2),1)
SHABAL_AVX2=mshabal256_avx2.o
CFLAGS_AVX2=-DAVX2
  endif
  ifeq ($(OS),Mac)
SHABAL=shabal64-darwin.o
  else
SHABAL=shabal64.o
  endif
endif

ifeq ($(OS_32BIT),1)
$(warning --- Compiling for 32-bit arch --- (NOT RECOMMENDED, THIS WILL AFFECT YOUR MAXIMUM PLOT SIZE))
CFLAGS += -m32
SHABAL=shabal32.o
SHABAL_SSE4=mshabal_sse432.o
SHABAL_AVX2=
endif

$(info CFLAGS=$(CFLAGS))

ifeq ($(OS),Windows)
all:		optimize.exe
else
all:		plot optimize mine mine_pool_all mine_pool_share
endif

optimize.exe:	optimize.c
		x86_64-w64-mingw32-gcc-4.8 $(CFLAGS) -o $@ $^

plot:		plot.c $(SHABAL) $(SHABAL_SSE4) $(SHABAL_AVX2) helper.o
		gcc $(CFLAGS) -o $@ $^ -lpthread -std=gnu99 $(CFLAGS_AVX2)
mine:		mine.c $(SHABAL) helper.o
		gcc $(CFLAGS) -DSOLO -o $@ $^ -lpthread

mine_pool_all:	mine.c $(SHABAL) helper.o
		gcc $(CFLAGS) -DURAY_POOL -o $@ $^ -lpthread

mine_pool_share:	mine.c $(SHABAL) helper.o
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

mshabal_sse4.o: mshabal_sse4.c
		gcc -Wall -m64 -c -O2 -march=native -o mshabal_sse4.o mshabal_sse4.c

mshabal256_avx2.o: mshabal256_avx2.c
		gcc -Wall -m64 -c -O2 -march=native -mavx2 -o mshabal256_avx2.o mshabal256_avx2.c

mshabal_sse432.o: mshabal_sse4.c
		gcc -Wall -m32 -c -O2 -march=native -o mshabal_sse432.o mshabal_sse4.c

clean:
		rm -f mshabal_sse432.o mshabal_sse4.o mshabal256_avx2.o shabal64.o shabal64-darwin.o shabal32.o helper.o plot optimize mine mine_pool_all mine_pool_share optimize.exe

