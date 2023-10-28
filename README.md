# Step by step DPDK experiments

This tutorial aims to build an experimental environment of DPDK 23.07.
By following this tutorial, you can
* Build DPDK test enviroment in **ONE VM**.
* Make concrete understanding of DPDK.

However, it is **NOT** for performance purpose.

1. [Hello DPDK world](markdown/1-hello-dpdk.md)
1. [NIC Binding](markdown/2-nic-binding.md)
1. [Building Containers](markdown/3-building-containers.md)
1. [Test pktgen-dpdk](markdown/4-pktgen-dpdk.md)
1. [Layer2 forwarding](markdown/5-layer-2-forwarding.md)

# Enviroment
My test environment is
````
Guest OS: Archlinux (as of Oct 2023)
Hypervisor: VMware VirtualBox with KVM Para-virtualization enabled
Host OS: Archlinux
NIC(s) : 4 * virtual Intel Pro 1000 MT Server (82545EM)
HugePages Configuration : 1024 * 2MB Pagesize Mounted @ /mnt/hugepages on both host and guest Machines.
````
This tutorial works according to my exprience, and should also apply to other virtual machines, such as debian/ubuntu and centos, which may need some customization.

