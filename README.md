# cramfs-utils
Dockerized cramfs utilities

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

lzma_uncramfs() {
    docker run --rm -v $(pwd):/home/ubuntu cramfs-utils lzma-uncramfs "$@"
}

uncramfs() {
    docker run --rm -v $(pwd):/home/ubuntu cramfs-utils uncramfs "$@"
}
```
