# Hello DPDK world
## Build DPDK
Build DPDK from a fresh installed Archlinux (VM) system.

Updating System and installing needed dependencies
```shell
sudo pacman -Syu --noconfirm
sudo pacman -S python git python-pyelftools pciutils meson ninja make gcc numactl libpcap linux-headers linux dpdk xz wget --noconfirm
```

Downloading latest DPDK Tarball
```shell
wget http://fast.dpdk.org/rel/dpdk-23.07.tar.xz
tar -xvf dpdk-23.07.tar.xz
```
Compiling DPDK from source
```shell
cd dpdk-23.07
meson setup build
ninja -C build
ninja -C  build install
```
Add the following lines to the end of /etc/profile
```shell
export RTE_SDK=~/dpdk-23.07
export RTE_TARGET=build
```
then,
```shell
source /etc/profile
```

# Configure hugepages
```shell

sudo mount -t hugetlbfs nodev /mnt/hugepages
sudo sh -c "/bin/echo 1024 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages"                                                                         
```
We can automatically mount hugepages when OS booted.
1. Edit file `/etc/default/grub`, and append `"hugepages=1024 iommu=pt, intel_iommu=on"` to `GRUB_CMDLINE_LINUX_DEFAULT`,
1. Do `sudo grub-mkconfig -o /boot/grub/grub.cfg` to generate a new grub config file with updated kernel parameters,
1. Edit file `/etc/fstab` , and add a new line `nodev /dev/hugepages hugetlbfs defaults 0 0` to the end of the file,
1. Finally `reboot`.

# Hello world
Build helloworld application
```shell
cd ~/dpdk-23.07/examples/helloworld
make
```
Due to the permission issue, we use the superuser to run the application
```shell
sudo ./build/helloworld
```
The output is similar to
```
hello from core 1
hello from core 2
hello from core 3
hello from core 0
```

Seeing this means the dpdk and hugepages are configured correctly and you can proceed to next steps.
