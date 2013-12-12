The purpose of this project is to simplify the build process of ADI systems.

However, there is no garantee that this works for anything else than
Blackfin 527, cpu rev 0.0

It contains the following submodules
* [sources/buildroot](https://github.com/soderstrom-rikard/adi-buildroot)
* [sources/toolchain](https://github.com/soderstrom-rikard/adi-toolchain)
* [sources/u-boot](https://github.com/soderstrom-rikard/adi-u-boot)


If you wish to clone the repo and get all submodules at the same time, do
```
   git clone --recursive https://github.com/soderstrom-rikard/adi-root
```

The following are two very good commands
```
   git tag --list
   git branch -a
```

To checkout a branch/tag do
```
   git checkout branch/tagname
```

For more info visit [blackfin.uclinux.org](blackfin.uclinux.org/doku.php)
