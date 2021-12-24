# dec/24/2021 10:09:36 by RouterOS 7.1.1
# software id = 1U75-R59F
#
# model = CRS112-8G-4S
# serial number = D25A0DCCEBE1

/system identity
set name=SW01-Office-NR4

/port
set 0 name=serial0

/interface bridge
add admin-mac=08:55:31:CD:F3:A6 auto-mac=no ingress-filtering=no name=bridge \
    protocol-mode=none vlan-filtering=yes

/interface bridge port
add bridge=bridge comment=defconf frame-types=admit-only-vlan-tagged \
    interface=ether1
add bridge=bridge comment=defconf frame-types=admit-only-vlan-tagged \
    interface=ether2
add bridge=bridge comment=defconf ingress-filtering=no interface=ether3
add bridge=bridge comment=defconf ingress-filtering=no interface=ether4
add bridge=bridge comment=defconf frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether5 pvid=107
add bridge=bridge comment=defconf frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether6 pvid=107
add bridge=bridge comment=defconf frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether7 pvid=107
add bridge=bridge comment=defconf frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether8 pvid=107
add bridge=bridge comment=defconf frame-types=admit-only-vlan-tagged \
    interface=sfp9
add bridge=bridge comment=defconf frame-types=admit-only-vlan-tagged \
    interface=sfp10
add bridge=bridge comment=defconf frame-types=admit-only-vlan-tagged \
    interface=sfp11
add bridge=bridge comment=defconf frame-types=admit-only-vlan-tagged \
    interface=sfp12

/interface bridge vlan
add bridge=bridge tagged=bridge,ether1,ether2,sfp9,sfp10,sfp11,sfp12 \
    vlan-ids=99
add bridge=bridge tagged=bridge,ether1,ether2,sfp9,sfp10,sfp11,sfp12 \
    vlan-ids=101
add bridge=bridge tagged=bridge,ether1,ether2,sfp9,sfp10,sfp11,sfp12 \
    vlan-ids=107

/interface vlan
add interface=bridge name=vlan-base vlan-id=99

/interface list
add name=BASE

/interface list member
add interface=vlan-base list=BASE

/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik

/ip dns
set servers=192.168.99.1

/ip address
add address=192.168.99.2/24 interface=vlan-base network=192.168.99.0

/ip route
add distance=1 gateway=192.168.99.1

/ip neighbor discovery-settings
set discover-interface-list=BASE

/tool mac-server
set allowed-interface-list=BASE

/tool mac-server mac-winbox
set allowed-interface-list=BASE

/ip ssh
set strong-crypto=yes

/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes

/ip settings
set max-neighbor-entries=8192

/ipv6 settings
set disable-ipv6=yes max-neighbor-entries=8192

/system clock
set time-zone-name=America/New_York

/interface lte apn
set [ find default=yes ] ip-type=ipv4
