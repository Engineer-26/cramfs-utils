# cramfs-utils
Dockerized cramfs utilities & extractors

# Why?
`cramfs`'s deprication in Ubuntu 18.04 made working with related tools very difficult. [Binwalk](link.needed) relies on those depricated tools and [unblob](link.needed)'s cramfs extractor is not quite up to par for some edge cases.

The `cramfs-utils` docker container allows for cramfs utilities to be run transparently on the host.
```
╭─   ~ ································································································ ✘ INT  17:16:21
╰─❯ cramfsck 
usage: cramfsck [-hv] [-x dir] file
 -h         print this help
 -x dir     extract into dir
 -v         be more verbose
 -c         continue on failure
 file       file to test

╭─   ~ ······································································································  17:16:24
╰─❯ mkcramfs 
usage: mkcramfs [-h] [-e edition] [-i file] [-n name] [-D file] dirname outfile
 -h         print this help
 -E         make all warnings errors (non-zero exit status)
 -e edition set edition number (part of fsid)
 -i file    insert a file image into the filesystem (requires >= 2.4.0)
 -n name    set name of cramfs filesystem
 -p         pad by 512 bytes for boot code
 -s         sort directory entries (old option, ignored)
 -v         be more verbose
 -x         use extended block pointers (requires >= 4.15)
 -X         allow XIP of ELF files (imply -x)
 -z         make explicit holes (requires >= 2.3.39)
 -D         Use the named FILE as a device table file
 -q         squash permissions (make everything owned by root)
 -B         force big-endian filesystem creation
 -L         force little-endian filesystem creation
 dirname    root of the filesystem to be compressed
 outfile    output file

╭─   ~ ······································································································  17:16:27
╰─❯ cramfsswap 
Usage: cramfsswap <in> <out>

╭─   ~ ······································································································  17:16:31
╰─❯ lzma-uncramfs
lzma-uncramfs v0.7rg by Andrew Stitcher, lzma for openrg  by V. Di Giampietro (v@ler.io)
Usage: 'lzma-uncramfs [-d devfilename] [-m modefilename] dirname infile'
 where <dirname> is the root for the
 uncompressed (output) filesystem.

╭─   ~ ······································································································  17:16:36
╰─❯ uncramfs
uncramfs v0.7 by Andrew Stitcher
Usage: 'uncramfs [-d devfilename] [-m modefilename] dirname infile'
 where <dirname> is the root for the
 uncompressed (output) filesystem.
```

## Containerized tools
  * `cramfsck`
  * `mkcramfs`
  * `cramfsswap`
  * `lzma-uncramfs`
  * `uncramfs`

## Installation
1. Install and setup docker
2. `git clone https://github.com/Engineer-26/cramfs-utils`
3. `cd cramfs-utils && docker build -t cramfs-utils .`

## Setup
Add the following to your `~/.zshrc` or `~/.bashrc`:
```
cramfsswap() {
    docker run --rm -v $(pwd):/home/ubuntu cramfs-utils cramfsswap "$@"
}

cramfsck() {
    docker run --rm -v $(pwd):/home/ubuntu cramfs-utils cramfsck "$@"
}

mkcramfs() {
    docker run --rm -v $(pwd):/home/ubuntu cramfs-utils mkcramfs "$@"
}

lzma-uncramfs() {
    docker run --rm -v $(pwd):/home/ubuntu cramfs-utils lzma-uncramfs "$@"
}

uncramfs() {
    docker run --rm -v $(pwd):/home/ubuntu cramfs-utils uncramfs "$@"
}
```

## Credits
* https://github.com/npitre/cramfs-tools
* https://github.com/julijane/cramfsswap
* https://github.com/digiampietro/lzma-uncramfs
* https://gitlab.com/kalilinux/packages/firmware-mod-kit/-/archive/kali/master/firmware-mod-kit-kali-master.zip?path=src/uncramfs
