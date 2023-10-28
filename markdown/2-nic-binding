# Bind NIC to uio driver
Show current network device drivers
```shell
sudo dpdk-devbind.py --status
```
The output looks like
````
Network devices using DPDK-compatible driver
============================================
<none>

Network devices using kernel driver
===================================
0000:02:01.0 '82545EM Gigabit Ethernet Controller (Copper) 100f' if=ens33 drv=e1000 unused= *Active*
0000:02:06.0 '82545EM Gigabit Ethernet Controller (Copper) 100f' if=ens38 drv=e1000 unused=
````

Probe uio driver
````
sudo modprobe uio
````

build `igb-uio.ko` using source code from DPDK-kmods
```
git clone https://dpdk.org/git/dpdk-kmods
cd dpdk-kmods
make
sudo insmod igb_uio.ko
```

and finally Bind NIC to dpdk-compat driver
```
dpdk-devbind.py -b igb_uio 02:06.0
```
The output looks like
````
Network devices using DPDK-compatible driver
============================================
0000:02:06.0 '82545EM Gigabit Ethernet Controller (Copper) 100f' drv=igb_uio unused=uio_pci_generic

Network devices using kernel driver
===================================
0000:02:01.0 '82545EM Gigabit Ethernet Controller (Copper) 100f' if=ens33 drv=e1000 unused=igb_uio,uio_pci_generic *Active*
````

