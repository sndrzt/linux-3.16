#!/usr/bin/env bash
if [[ $(cat /etc/issue) != *"Ubuntu 14.04.4"* ]]; then echo "Only support Ubuntu 14.04.4"; fi
sudo apt-get install -y automake libtool zlib1g-dev libsdl1.2-dev flex bison gcc-arm-linux-gnueabihf gcc-arm-linux-gnueabi libncurses5-dev git tig htop
#wget http://download.qemu.org/qemu-2.0.0.tar.bz2
#rm -rf qemu-2.0.0;
tar xf qemu-2.0.0.tar.bz2 && pushd qemu-2.0.0/ && ./configure && make && sudo make install && popd
wget --no-check-certificate https://busybox.net/downloads/busybox-1.3.0.tar.bz2
tar xf busybox-1.3.0.tar.bz2 && cd busy-box-1.3.0 && make menuconfig && ARCH=arm EXTRADIR=${PWD}/extra CROSS_COMPILE=arm-linux-gnueabi- make
export ARCH=arm
export EXTRADIR=${PWD}/extra
export CROSS_COMPILE=arm-linux-gnueabi-
make vexpress_defconfig
make zImage -j8
make modules -j8
make dtbs
cp arch/arm/boot/zImage extra/
cp arch/arm/boot/dts/*ca9.dtb extra/
cp .config extra/
