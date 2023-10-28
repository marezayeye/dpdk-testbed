# Layer2 forwarding

## Run
We have three pci devices binded to DPDK-compatible driver, which are 02:06.0, 02:07.0 and 02:08.0.
````
Network devices using DPDK-compatible driver
============================================
0000:02:06.0 '82545EM Gigabit Ethernet Controller (Copper) 100f' drv=igb_uio unused=vfio-pci
0000:02:07.0 '82545EM Gigabit Ethernet Controller (Copper) 100f' drv=igb_uio unused=vfio-pci
0000:02:08.0 '82545EM Gigabit Ethernet Controller (Copper) 100f' drv=igb_uio unused=vfio-pci
````
We use `02:06.0` to generate traffic by using pktgen-dpdk, while `02:07.0` and `02:08.0` to do layer2 forwarding.
Since one DPDK-compatible network device can only be used by one DPDK application, we need to blacklist `02:06.0` in l2fwd, do so to `02:07.0` and `02:08.0` in pktgen.

### Run l2fwd

```shell
cd /usr/local/share/dpdk/examples/
sudo ./l2fwd -c 0x3 -m 128 -b 02:06.0 -- -p 0x3
```

```
......

Initializing port 0... done:
Port 0, MAC address: 00:0C:29:E0:8B:D5

Initializing port 1... done:
Port 1, MAC address: 00:0C:29:E0:8B:DF

......
```

Current output of l2fwd is
````
Port statistics ====================================
Statistics for port 0 ------------------------------
Packets sent:                        0
Packets received:                    0
Packets dropped:                     0
Statistics for port 1 ------------------------------
Packets sent:                        0
Packets received:                    0
Packets dropped:                     0
Aggregate statistics ===============================
Total packets sent:                  0
Total packets received:              0
Total packets dropped:               0
====================================================
````

### Run pktgen-dpdk
first we need to copy pktgen config file from `pktgen-configs/l2fwd.cfg` to `$PKTGEN/cfg/` and then we run pktgen to generate traffic based on the confg file.
```shell
cd /path-to-pktgen-dpdk/
./tools/dpdk-run.py l2fwd
Pktgen:/> set 0 dst mac 00:0C:29:E0:8B:D5
Pktgen:/> str
```
We set the dst mac of generated packets to `00:0C:29:E0:8B:D5`, which is the mac of device `02:07.0` (port 0 in l2fwd).
Now l2fwd keeps receiving packets by port 0 (02:07.0) and forwarding out through port 1 (02:08.0).
Current output of l2fwd is
````
Port statistics ====================================
Statistics for port 0 ------------------------------
Packets sent:                        0
Packets received:              1131166
Packets dropped:                     0
Statistics for port 1 ------------------------------
Packets sent:                  1131166
Packets received:                    0
Packets dropped:                     0
Aggregate statistics ===============================
Total packets sent:            1131166
Total packets received:        1131166
Total packets dropped:               0
====================================================
````

We stop pktgen-dpdk and set the dst mac to `00:0C:29:E0:8B:DF` (port 1 in l2fwd), and start generating.
```shell
Pktgen:/> stp
Pktgen:/> set 0 dst mac 00:0C:29:E0:8B:DF
Pktgen:/> str
```
Current output of l2fwd is
````
Port statistics ====================================
Statistics for port 0 ------------------------------
Packets sent:                 12428128
Packets received:              1131178
Packets dropped:                     0
Statistics for port 1 ------------------------------
Packets sent:                  1131178
Packets received:             12428128
Packets dropped:                     0
Aggregate statistics ===============================
Total packets sent:           13559306
Total packets received:       13559306
Total packets dropped:               0
====================================================
````
Now, the l2fwd receives packets through port 1 and sends through port 0.
