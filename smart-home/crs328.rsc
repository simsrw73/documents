# dec/24/2021 10:05:21 by RouterOS 7.1.1
# software id = K7J1-43V8
#
# model = CRS328-24P-4S+
# serial number = F6090F1EA2ED

/system identity
set name=SW02-Office-NR5

/port
set 0 name=serial0

/interface bridge
add admin-mac=DC:2C:6E:64:0A:5C auto-mac=no ingress-filtering=no name=bridge \
    vlan-filtering=yes

/interface bridge port
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether1
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether2
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether3
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether4
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether9 pvid=119
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether10 pvid=119
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether11 pvid=119
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether12 pvid=119

/interface bridge vlan
add bridge=bridge tagged=bridge,ether1,ether2,ether3,ether4 vlan-ids=99
add bridge=bridge tagged=ether1,ether2,ether3,ether4 vlan-ids=101
add bridge=bridge tagged=ether1,ether2,ether3,ether4 vlan-ids=107
add bridge=bridge tagged=ether1,ether2,ether3,ether4 untagged=\
    ether9,ether10,ether11,ether12 vlan-ids=119

/interface list
add name=BASE

/interface list member
add interface=vlan-base list=BASE

/interface vlan
add interface=bridge name=vlan-base vlan-id=99

/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik

/ip dns
set servers=192.168.99.1

/ip address
add address=192.168.99.3/24 interface=vlan-base network=192.168.99.0

/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=192.168.99.1

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
set disable-ipv6=yes

/system clock
set time-zone-name=America/New_York

/system ntp client
set enabled=yes mode=broadcast

/system ntp client servers
add address=192.168.99.1

/system routerboard settings
set boot-os=router-os

/interface lte apn
set [ find default=yes ] ip-type=ipv4
