mjminer 1.1
=======

A fork of dcct_miner for Burst coin. Supports Mac OS X 10.9+ and Linux.

2014/10/07 - Merged with MDCCT, adding SSE4 / AVX2. Speed gain ~2x if enabled.  

To enable, use -x switch:  
```
-x 0  - original algo
-x 1  - SSE4
-x 2  - AVX2
```

Compilation on Linux & MacOS
============================

```sh
git clone https://github.com/r-majere/mjminer.git
cd mjminer
make
```

mjminer will try to automatically detect OS type and arch when compiling.

If compilation fails due to AVX2, try
make AVX2=0
This will completely disable AVX2 support.

How to use it
=============

Usage: ./plot -k KEY [-x CORE] [-d DIRECTORY] [-s STARTNONCE] [-n NONCES] [-m STAGGERSIZE] [-t THREADS]
Where -x:
	0 - default core
	1 - SSE4 core
	2 - AVX2 core

Refer to original thread at bitcointalk for more information:

https://bitcointalk.org/index.php?topic=731923.msg8879760#msg8879760

Just remember to enable SSE2 or AVX2 by using -x [mode] key.

Contacts
---

mjminer's author:  
Email: majereray@gmail.com  
majere at bitcointalk.org

MDCCT author: Niksa Franceschi <niksa.franceschi@gmail.com>  
Burst for donations: BURST-RQW7-3HNW-627D-3GAEV

Author of original dcct_miner:  
Markus Tervooren <info@bchain.info>  
BURST-R5LP-KEL9-UYLG-GFG6T

Modifed using BurstSoftware code: https://github.com/BurstTools/BurstSoftware  
by Cerr Janror <cerr.janror@gmail.com>  
Burst: BURST-LNVN-5M4L-S9KP-H5AAC  

With code written by Uray Meiviar <uraymeiviar@gmail.com>  
BURST-8E8K-WQ2F-ZDZ5-FQWHX

Implementation of Shabal is taken from:  
http://www.shabal.com/?p=198

Whom to donate
=============

BURST-RQW7-3HNW-627D-3GAEV
BURST-R5LP-KEL9-UYLG-GFG6T  
BURST-LNVN-5M4L-S9KP-H5AAC  
BURST-8E8K-WQ2F-ZDZ5-FQWHX  


