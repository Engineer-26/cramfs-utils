# Use the official Ubuntu base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /home/ubuntu/

# Update and upgrade the package lists, and install necessary packages
RUN apt update && apt upgrade -y && \
    apt install -y git build-essential libz-dev vim wget unzip

# Clone and build cramfs-tools
RUN git clone https://github.com/npitre/cramfs-tools && \
    cd cramfs-tools && \
    make && \
    cp cramfsck mkcramfs /usr/local/bin/ && \
    cd ..

# Clone, modify, and build cramfsswap
RUN git clone https://github.com/julijane/cramfsswap && \
    cd cramfsswap && \
    sed -i 's/gcc -Wall -g -O -o cramfsswap -lz cramfsswap.c/gcc -Wall -g -O -o cramfsswap cramfsswap.c -lz/' Makefile && \
    make && \
    cp cramfsswap /usr/local/bin/ && \
    cd ..

# Clone, modify, and build lzma-uncramfs
RUN git clone https://github.com/digiampietro/lzma-uncramfs && \
    cd lzma-uncramfs && \
    sed -i '1i#include <sys/sysmacros.h>' lzma-uncramfs.c && \
    make && \
    cp lzma-uncramfs /usr/local/bin/ && \
    cd ..

# Download, unzip, and build uncramfs, then remove the zip file
RUN wget -O uncramfs.zip https://gitlab.com/kalilinux/packages/firmware-mod-kit/-/archive/kali/master/firmware-mod-kit-kali-master.zip?path=src/uncramfs && \
    unzip uncramfs.zip && \
    mv firmware-mod-kit-kali-master-src-uncramfs/src/uncramfs/ . && \
    rm -rf firmware-mod-kit-kali-master-src-uncramfs/ && \
    rm uncramfs.zip && \
    cd uncramfs && \
    make && \
    cp uncramfs /usr/local/bin/ && \
    cd ..

# Set the default command to bash
CMD ["bash"]

