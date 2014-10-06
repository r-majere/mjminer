mjminer
=======

A fork of dcct_miner for Burst coin with additional features such as Mac OS support.
Contact email: majereray@gmail.com
majere at bitcointalk.org

Author of original dcct_miner:
Markus Tervooren <info@bchain.info>
BURST-R5LP-KEL9-UYLG-GFG6T

With code written by Uray Meiviar <uraymeiviar@gmail.com>
BURST-8E8K-WQ2F-ZDZ5-FQWHX

Implementation of Shabal is taken from:
http://www.shabal.com/?p=198

How to use it
=============

Download and unpack it:
wget https://bchain.info/dcct_miner.tgz
tar -xvzf dcct_miner.tgz

Then compile it:
make

or if you use 32-bit Linux:
make linux32

If you really can't compile it use the ones in "bin".

Now you have 3 tools:

The C plotfile generator

This tool creates plotfiles. In simple mode use it like this:
Code:
./plot -k <public key> -d /path/to/storage

This will fill the entire disk with a single plot file using a random start nonce, 80% of available memory and max. threads.

Or specify:
Code:
./plot -k <public key> -s 100000 -n 500G -m 10G -t 3

for starting nonce 100000, 500GB plot size, 10GB memory usage and 3 threads.

The plot optimizer utility

The new version is a LOT faster!

If you created your plots with a small stagger size, processing them takes a long time. You might miss your deadline if its found too late!
The utility optimizes your already created files making them a lot faster to read.

How to use it?

Code:
./optimize plots/1234567890_0_100000_1000

Or process your whole plot directory:

Code:
./optimize plots/*

You can limit the memory usage, for example to 1GB:

Code:
./optimize -m 1G plots/*

It will replace your plot files with optimized ones.

This does not work for incomplete plotfiles.

The miner

You want to use your plotfiles to generate coins, this is where the miner is used.

For solo mining put your passphrase in a file called "passphrases.txt". It supports only one passphrase and uses the files first line.
Avoid spaces before/after your passphrase.

Then start the miner:

Code:
./mine <node ip> [<plot dir> <plot dir> ..]

For example:

Code:
./mine 127.0.0.1 /mnt/disk1/plots /home/user/plots /mnt/usb1/plots

Each directory is read by a separate thread. If you use multiple HDD's try to use one directory per HDD, this is fastest.

The miner creates some nice output:
Code:
2872 MB read/11488 GB total/deadline 50134s (49664s left)
New block 8674, basetarget 9388869
2872 MB read/11488 GB total/deadline 21573s (21476s left)
New block 8675, basetarget 9260523
2872 MB read/11488 GB total/deadline 3040s (2823s left)
New block 8676, basetarget 9461804
2872 MB read/11488 GB total/deadline 1122s (1018s left)
New block 8677, basetarget 9502439

When seconds left approach zero, you likely found a block.

Make sure to synchronize your clock! (ntpdate ...)

The miner also supports pool mining:
For uray's pool use:

Code:
./mine_uray.sh [<plot directory>]

For dev's pools (share based)

Code:
./mine_dev_v1.sh [<plot directory>]

or 

Code:
./mine_dev_v2.sh [<plot directory>]


