FROM archlinux/archlinux:base-devel
LABEL maintainer="marezayeye@gmail.com"

LABEL RUN docker run -it --privileged -v /sys/bus/pci/devices:/sys/bus/pci/devices -v /sys/kernel/mm/hugepages:/sys/kernel/mm/hugepages -v /sys/devices/system/node:/sys/devices/system/node -v /dev:/dev --name NAME -e NAME=NAME -e IMAGE=IMAGE IMAGE"
# Updating and installing needed packages and build dependencies
RUN pacman -Syu --noconfirm
RUN pacman -S python git python-pyelftools pciutils meson ninja make gcc numactl libpcap linux-headers linux xz-utils wget --noconfirm

# Setting WORKDIR and executing build scripts
WORKDIR /root
COPY ./build_dpdk.sh /root/build_dpdk.sh
COPY ./dpdk-profile.sh /etc/profile.d/
RUN /root/build_dpdk.sh

# Defaults to a bash shell, you could put your DPDK-based application here.
CMD ["/bin/bash"]

