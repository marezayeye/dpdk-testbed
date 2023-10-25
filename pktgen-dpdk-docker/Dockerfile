FROM archlinux/archlinux:base-devel
LABEL maintainer="marezayeye@gmail.com"

LABEL RUN docker run -it --privileged -v /sys/bus/pci/devices:/sys/bus/pci/devices -v /sys/kernel/mm/hugepages:/sys/kernel/mm/hugepages -v /sys/devices/system/node:/sys/devices/system/node -v /dev:/dev --name pktgen-dpdk -e NAME=pktgen-dpdk -e IMAGE=pktgen-dpdk pktgen-dpdk
# Updating and installing needed packages and build dependencies
ADD mirrorlist /etc/pacman.d/mirrorlist
RUN pacman -Syu --noconfirm
RUN pacman -S dpdk python git python-pyelftools pciutils meson ninja make gcc numactl libpcap linux-headers linux xz wget --noconfirm

# Setting WORKDIR and executing build scripts
WORKDIR /root
RUN mkdir scripts
ADD scripts/* /root/scripts
RUN wget http://fast.dpdk.org/rel/dpdk-23.07.tar.xz
RUN tar -xvf dpdk-23.07.tar.xz
# RUN cd scripts && cp build-dpdk.sh /root/dpdk-23.07/build-dpdk.sh
# RUN su && cd /root/dpdk-23.07 && sh ./build-dpdk.sh
RUN cd dpdk-23.07 && meson setup build && ninja -C build && ninja -C  build install 
RUN export RTE_SDK=/root/dpdk-23.07
RUN export PKTGEN=/root/Pktgen-DPDK
RUN export RTE_TARGET=build
RUN git clone https://github.com/marezayeye/Pktgen-DPDK
RUN export PKT_CONFIG_PATH=/root/dpdk-23.07/build/meson-private
# RUN pacman -S dpdk
RUN ldconfig
RUN cd /root/Pktgen-DPDK && git checkout marezayeye && make


# Defaults to a bash shell, you could put your DPDK-based application here.
CMD ["/bin/bash"]

