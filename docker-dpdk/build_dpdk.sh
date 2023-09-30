#!/bin/bash

#
# Build DPDK and pktgen inside a container
# MAINTAINER:  marezayeye@gmail.com

# Define Global Variables

DPDKFILE=dpdk-23.07.tar.xz
URL=http://fast.dpdk.org/rel/$DPDKFILE
BASEDIR=/root
VERSION=23.07
PACKAGE=dpdk
DPDKROOT=$BASEDIR/$PACKAGE-$VERSION
CONFIG=x86_64-native-linuxapp-gcc


# Download/Build DPDK
cd $BASEDIR
wget $URL
tar -xvf "$DPDKTAR"
cd $DPDKROOT
meson setup build
cd build
ninja
meson install
ldconfig

source /etc/profile.d/dpdk-profile.sh

 Download/Build pktgen-dpdk
URL=git://dpdk.org/apps/pktgen-dpdk
BASEDIR=/root
PACKAGE=pktgen-dpdk
PKTGENROOT=$BASEDIR/$PACKAGE
cd $BASEDIR
git clone $URL

# Silence compiler info message

sed -i '/Wwrite-strings$/ s/$/ -Wno-unused-but-set-variable/' $DPDKROOT/mk/toolchain/gcc/rte.vars.mk
cd $PKTGENROOT
make
