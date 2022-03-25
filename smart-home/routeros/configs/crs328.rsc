# mar/13/2022 20:45:48 by RouterOS 7.1.3
# software id = K7J1-43V8
#
# model = CRS328-24P-4S+
# serial number = F6090F1EA2ED
/interface bridge
add admin-mac=DC:2C:6E:64:0A:5C auto-mac=no ingress-filtering=no name=bridge \
    vlan-filtering=yes
/interface ethernet
set [ find default-name=sfp-sfpplus1 ] advertise="10M-half,10M-full,100M-half,\
    100M-full,1000M-half,1000M-full,10000M-full,2500M-full,5000M-full"
set [ find default-name=sfp-sfpplus2 ] auto-negotiation=no
set [ find default-name=sfp-sfpplus3 ] auto-negotiation=no
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
add bridge=bridge frame-types=admit-only-vlan-tagged interface=sfp-sfpplus1
add bridge=bridge frame-types=admit-only-vlan-tagged interface=sfp-sfpplus2
add bridge=bridge frame-types=admit-only-vlan-tagged interface=sfp-sfpplus3
add bridge=bridge frame-types=admit-only-vlan-tagged interface=sfp-sfpplus4
/ip neighbor discovery-settings
set discover-interface-list=BASE
/ip settings
set max-neighbor-entries=8192
/ipv6 settings
set disable-ipv6=yes
/interface bridge vlan
add bridge=bridge tagged="bridge,ether1,ether2,ether3,ether4,sfp-sfpplus1,sfp-\
    sfpplus2,sfp-sfpplus3,sfp-sfpplus4" vlan-ids=99
add bridge=bridge tagged="ether1,ether2,ether3,ether4,sfp-sfpplus1,sfp-sfpplus\
    2,sfp-sfpplus3,sfp-sfpplus4" vlan-ids=101
add bridge=bridge tagged="ether1,ether2,ether3,ether4,sfp-sfpplus1,sfp-sfpplus\
    2,sfp-sfpplus3,sfp-sfpplus4" vlan-ids=107
add bridge=bridge tagged="ether1,ether2,ether3,ether4,sfp-sfpplus1,sfp-sfpplus\
    2,sfp-sfpplus3,sfp-sfpplus4" untagged=ether9,ether10,ether11,ether12 \
    vlan-ids=119
add bridge=bridge tagged="ether1,ether2,ether3,ether4,sfp-sfpplus1,sfp-sfpplus\
    2,sfp-sfpplus3,sfp-sfpplus4" vlan-ids=111
add bridge=bridge tagged="bridge,ether1,ether2,ether3,ether4,sfp-sfpplus1,sfp-\
    sfpplus2,sfp-sfpplus3,sfp-sfpplus4" vlan-ids=200
/interface list member
add interface=vlan-base list=BASE
/ip address
add address=192.168.99.3/24 interface=vlan-base network=192.168.99.0
/ip dns
set servers=192.168.99.1
/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=192.168.99.1
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
set name=SW02-Office-NR5
/system ntp client
set enabled=yes mode=broadcast
/system ntp client servers
add address=192.168.99.1
/system routerboard settings
set boot-os=router-os
/tool mac-server
set allowed-interface-list=BASE
/tool mac-server mac-winbox
set allowed-interface-list=BASE
