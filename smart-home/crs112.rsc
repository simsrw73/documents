# dec/18/2021 13:44:25 by RouterOS 7.1
# software id = 1U75-R59F
#
# model = CRS112-8G-4S
# serial number = D25A0DCCEBE1
/interface bridge
add admin-mac=08:55:31:CD:F3:A6 auto-mac=no comment=defconf \
    ingress-filtering=no name=bridge vlan-filtering=yes
/interface vlan
add interface=bridge name=vlan-base vlan-id=99
/interface list
add name=WAN
add name=LAN
/interface lte apn
set [ find default=yes ] ip-type=ipv4
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/port
set 0 name=serial0
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
/ip neighbor discovery-settings
set discover-interface-list=all
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
/interface list member
add interface=ether1 list=WAN
add interface=ether2 list=LAN
add interface=ether3 list=LAN
add interface=ether4 list=LAN
add interface=ether5 list=LAN
add interface=ether6 list=LAN
add interface=ether7 list=LAN
add interface=ether8 list=LAN
add interface=sfp9 list=LAN
add interface=sfp10 list=LAN
add interface=sfp11 list=LAN
add interface=sfp12 list=LAN
/ip address
add address=192.168.99.2/24 interface=vlan-base network=192.168.99.0
/ip route
add distance=1 gateway=192.168.99.1
/system clock
set time-zone-name=America/New_York
/system identity
set name=SW01-Office-NR4
