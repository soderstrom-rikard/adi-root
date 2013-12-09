The purpose of this project is to simplify the build process of ADI systems.

It contains the following submodules
* [[sources/buildroot|git://git.code.sf.net/p/adi-buildroot/code sources/buildroot]]
* [[sources/toolchain|git://git.code.sf.net/p/adi-toolchain/blackfin sources/toolchain]]
* [[sources/u-boot|git://git.code.sf.net/p/adi-u-boot/code sources/u-boot]]


If you wish to clone the repo and get all submodules at the same time, do
´´´
   git clone --recursive https://github.com/soderstrom-rikard/adi-root
´´´

Ones you have cloned with submodules you will find yourself at a specific revision in each submodule, in general this is not wanted.
So enter each submodule, and list available tags
´´´
   git tag --list
´´´

Usually the latest tag is the best choice, so check it out
´´´
   git checkout tagname
´´´

The buildroot submodule has two submodules of its own, so repeat the process for these aswell.

For more info visit blackfin.uclinux.org/doku.php

You might also want to apply the BF527-EZKIT.patch under patches to sources/buildroot/linux/linux-kernel,
otherwise you might run into problems executing the kernel (if your board is cpu rev 0,0)
