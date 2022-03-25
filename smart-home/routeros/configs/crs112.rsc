# mar/20/2022 20:43:31 by RouterOS 7.1.3
# software id = 1U75-R59F
#
# model = CRS112-8G-4S
# serial number = D25A0DCCEBE1
/interface bridge
add admin-mac=08:55:31:CD:F3:A6 auto-mac=no ingress-filtering=no name=bridge \
    protocol-mode=none vlan-filtering=yes
/interface ethernet
set [ find default-name=sfp9 ] advertise=\
    1000M-full,10000M-full,2500M-full,5000M-full auto-negotiation=no
/interface vlan
add interface=bridge name=vlan-base vlan-id=99
/interface list
add name=BASE
/interface lte apn
set [ find default=yes ] ip-type=ipv4
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/port
set 0 name=serial0
/interface bridge port
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether1
add bridge=bridge comment="[Trunk] Bedroom Entertainment Switch" frame-types=\
    admit-only-vlan-tagged interface=ether2
add bridge=bridge comment="Kadziel (PC-Win-Server)" frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether3 pvid=200
add bridge=bridge interface=ether4 pvid=99
add bridge=bridge comment="Yealink W60B VOIP Phone" frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether5 pvid=99
add bridge=bridge comment="Canon MB 5320 Printer/Fax" frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether6 pvid=99
add bridge=bridge comment="Lutron Smart Bridge" frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether7 pvid=107
add bridge=bridge comment="Ring Base Station" frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether8 pvid=107
add bridge=bridge frame-types=admit-only-vlan-tagged interface=sfp9
add bridge=bridge frame-types=admit-only-vlan-tagged interface=sfp10
add bridge=bridge frame-types=admit-only-vlan-tagged interface=sfp11
add bridge=bridge frame-types=admit-only-vlan-tagged interface=sfp12
/ip neighbor discovery-settings
set discover-interface-list=BASE
/ip settings
set max-neighbor-entries=8192
/ipv6 settings
set disable-ipv6=yes max-neighbor-entries=8192
/interface bridge vlan
add bridge=bridge tagged=bridge,ether1,ether2,sfp9,sfp10,sfp11,sfp12 \
    vlan-ids=99
add bridge=bridge tagged=bridge,ether1,ether2,sfp9,sfp10,sfp11,sfp12 \
    vlan-ids=101
add bridge=bridge tagged=bridge,ether1,ether2,sfp9,sfp10,sfp11,sfp12 \
    vlan-ids=107
add bridge=bridge tagged=bridge,ether1,ether2,sfp9,sfp10,sfp11,sfp12 \
    vlan-ids=111
add bridge=bridge tagged=bridge,ether1,ether2,sfp9,sfp10,sfp11,sfp12 \
    vlan-ids=200
/interface list member
add interface=vlan-base list=BASE
/ip address
add address=192.168.99.2/24 interface=vlan-base network=192.168.99.0
/ip cloud
set update-time=no
/ip dns
set servers=192.168.99.1
/ip route
add distance=1 gateway=192.168.99.1
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/ip ssh
set strong-crypto=yes
/system clock
set time-zone-name=America/New_York
/system identity
set name=SW01-Office-NR4
/system ntp client
set enabled=yes mode=multicast
/system ntp client servers
add address=192.168.99.1
/tool mac-server
set allowed-interface-list=BASE
/tool mac-server mac-winbox
set allowed-interface-list=BASE
