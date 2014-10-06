CFLAGS=-D_FILE_OFFSET_BITS=64

linux64:	plot optimize mine mine_pool_all mine_pool_share

linux32:	plot32 optimize32 mine32 mine_pool_all32 mine_pool_share32

win64:		optimize.exe

all:		linux64 linux32

dist:		linux64 linux32 win64
		rm -f bin/* shabal64.o shabal32.o dcct_miner.tgz
		mv plot optimize mine mine_pool_all plot32 optimize32 mine32 mine_pool_all32 mine_pool_share mine_pool_share32 optimize.exe bin
		cp mine_uray.sh mine_dev_v1.sh mine_dev_v2.sh bin
		tar -czf dcct_miner.tgz *

optimize.exe:	optimize.c
		x86_64-w64-mingw32-gcc-4.8 -D_FILE_OFFSET_BITS=64 -Wall -m64 -O2 -o optimize.exe optimize.c

plot:		plot.c shabal64.o helper64.o
		gcc -Wall -m64 -O2 -o plot plot.c shabal64.o helper64.o -lpthread

mine:		mine.c shabal64.o helper64.o
		gcc -Wall -m64 -O2 -DSOLO -o mine mine.c shabal64.o helper64.o -lpthread

mine_pool_all:	mine.c shabal64.o helper64.o
		gcc -Wall -m64 -O2 -DURAY_POOL -o mine_pool_all mine.c shabal64.o helper64.o -lpthread

mine_pool_share:	mine.c shabal64.o helper64.o
		gcc -Wall -m64 -O2 -DSHARE_POOL -o mine_pool_share mine.c shabal64.o helper64.o -lpthread

optimize:	optimize.c helper64.o
		gcc -Wall -m64 -O2 -o optimize optimize.c helper64.o

plot32:		plot.c shabal32.o helper32.o
		gcc -Wall -m32 -O2 -o plot32 plot.c shabal32.o helper32.o -lpthread

mine32:		mine.c shabal32.o helper32.o
		gcc -Wall -m32 -O2 -DSOLO -o mine32 mine.c shabal32.o helper32.o -lpthread 

mine_pool_all32:	mine.c shabal32.o helper32.o
		gcc -Wall -m32 -O2 -DURAY_POOL -o mine_pool_all32 mine.c shabal32.o helper32.o -lpthread 

mine_pool_share32:	mine.c shabal32.o helper32.o
		gcc -Wall -m32 -O2 -DSHARE_POOL -o mine_pool_share32 mine.c shabal32.o helper32.o -lpthread 

optimize32:	optimize.c helper32.o
		gcc -Wall -m32 -O2 -o optimize32 optimize.c helper32.o

helper64.o:	helper.c
		gcc -Wall -m64 -c -O2 -o helper64.o helper.c		

helper32.o:	helper.c
		gcc -Wall -m32 -c -O2 -o helper32.o helper.c		

shabal64.o:	shabal64.s
		gcc -Wall -m64 -c -o shabal64.o shabal64.s

shabal32.o:	shabal32.s
		gcc -Wall -m32 -c -o shabal32.o shabal32.s

clean:
		rm -f shabal64.o shabal32.o helper64.o helper32.o plot plot32 optimize optimize32 mine mine32 mine_pool_all mine_pool_all32 mine_pool_share mine_pool_share32 helper32.o helper64.o optimize.exe dcct_miner.tgz
