# dec/24/2021 10:08:20 by RouterOS 7.1.1
# software id = SYTB-ZK4C
#
# model = RB5009UG+S+
# serial number = EC1A0FCC6B92

/system identity
set name=RT1-Office-NR2

/interface ethernet
set [ find default-name=ether7 ] name=ether7-Access

/interface bridge
add admin-mac=DC:2C:6E:47:0F:C0 auto-mac=no name=bridge protocol-mode=none \
    vlan-filtering=yes

/interface bridge port
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether2
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether3
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether4
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether5
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether6
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether8 pvid=99
add bridge=bridge frame-types=admit-only-vlan-tagged interface=sfp-sfpplus1

/interface bridge vlan
add bridge=bridge tagged=\
    bridge,ether2,ether3,ether4,ether5,ether6,sfp-sfpplus1 vlan-ids=99
add bridge=bridge tagged=\
    bridge,ether2,ether3,ether4,ether5,ether6,sfp-sfpplus1 vlan-ids=101
add bridge=bridge tagged=\
    bridge,ether2,ether3,ether4,ether5,ether6,sfp-sfpplus1 vlan-ids=107
add bridge=bridge tagged=\
    bridge,ether2,ether3,ether4,ether5,ether6,sfp-sfpplus1 vlan-ids=119

/interface list
add name=WAN
add name=VLAN
add name=BASE

/interface list member
add interface=ether1 list=WAN
add interface=vlan-guest list=VLAN
add interface=vlan-iot list=VLAN
add interface=vlan-base list=BASE
add interface=vlan-base list=VLAN
add interface=ether7-Access list=BASE
add interface=vlan-security list=VLAN

/interface vlan
add interface=bridge name=vlan-base vlan-id=99
add interface=bridge name=vlan-guest vlan-id=101
add interface=bridge name=vlan-iot vlan-id=107
add interface=bridge name=vlan-security vlan-id=119

/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik

/ip dns
set allow-remote-requests=yes servers=\
    1.1.1.3,1.0.0.3,2606:4700:4700::1113,2606:4700:4700::1003 use-doh-server=\
    https://family.cloudflare-dns.com/dns-query verify-doh-cert=yes

/ip dhcp-client
add interface=ether1

/ip address
add address=192.168.99.1/24 interface=vlan-base network=192.168.99.0
add address=192.168.101.1/24 interface=vlan-guest network=192.168.101.0
add address=192.168.107.1/24 interface=vlan-iot network=192.168.107.0
add address=192.168.9.11/24 interface=ether7-Access network=192.168.9.0
add address=192.168.119.1/24 interface=vlan-security network=192.168.119.0

/ip pool
add name=dhcp_pool-base ranges=192.168.99.20-192.168.99.254
add name=dhcp_pool-guest ranges=192.168.101.20-192.168.101.254
add name=dhcp_pool-iot ranges=192.168.107.20-192.168.107.254
add name=dhcp_pool-security ranges=192.168.119.20-192.168.119.254

/ip dhcp-server
add address-pool=dhcp_pool-base interface=vlan-base name=dhcp-base
add address-pool=dhcp_pool-guest interface=vlan-guest name=dhcp-guest
add address-pool=dhcp_pool-iot interface=vlan-iot name=dhcp-iot
add address-pool=dhcp_pool-security interface=vlan-security name=\
    dhcp-security

/ip dhcp-server network
add address=192.168.99.0/24 gateway=192.168.99.1
add address=192.168.101.0/24 gateway=192.168.101.1
add address=192.168.107.0/24 gateway=192.168.107.1
add address=192.168.119.0/24 gateway=192.168.119.1

/ip firewall address-list
add address=ec1a0fcc6b92.sn.mynetname.net list=WAN_IP

/ip firewall filter
add action=accept chain=input comment="defconf: accept established,related" \
    connection-state=established,related
add action=accept chain=input comment="Allow VLAN" in-interface-list=VLAN
add action=accept chain=input comment="Allow VLAN_BASE" in-interface=\
    vlan-base log=yes
add action=accept chain=input comment="Allow LAN NTP queries-UDP" dst-port=\
    123 in-interface-list=VLAN log=yes log-prefix=NTP:: protocol=udp
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=accept chain=input comment=\
    "defconf: accept to local loopback (for CAPsMAN)" dst-address=127.0.0.1
add action=drop chain=input comment="Drop everything else"
add action=accept chain=forward comment="defconf: accept in ipsec policy" \
    ipsec-policy=in,ipsec
add action=accept chain=forward comment="defconf: accept out ipsec policy" \
    ipsec-policy=out,ipsec
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" \
    connection-state=established,related hw-offload=yes
add action=accept chain=forward comment="defconf: accept established,related" \
    connection-state=established,related
add action=drop chain=forward comment=\
    "Isolation for wifi guest. Only allow internet." in-interface=vlan-guest \
    log=yes out-interface-list=!WAN
add action=accept chain=forward comment="Allow VLAN access Internet" \
    connection-state=new in-interface-list=VLAN out-interface-list=WAN
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=forward comment=\
    "defconf: drop all from WAN not DSTNATed" connection-nat-state=!dstnat \
    connection-state=new in-interface-list=WAN
add action=drop chain=forward comment="Drop everything else"

/ip firewall nat
add action=masquerade chain=srcnat comment="Hairpin NAT" dst-address=\
    192.168.99.0/24 src-address=192.168.99.0/24
add action=masquerade chain=srcnat comment="defconf: masquerade" \
    ipsec-policy=out,none out-interface-list=WAN
add action=dst-nat chain=dstnat comment="Port Fwd for Home Assistant" \
    dst-address-list=WAN_IP dst-port=8123 protocol=tcp to-addresses=\
    192.168.99.10

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

/ipv6 firewall address-list
add address=::/128 comment="defconf: unspecified address" list=bad_ipv6
add address=::1/128 comment="defconf: lo" list=bad_ipv6
add address=fec0::/10 comment="defconf: site-local" list=bad_ipv6
add address=::ffff:0.0.0.0/96 comment="defconf: ipv4-mapped" list=bad_ipv6
add address=::/96 comment="defconf: ipv4 compat" list=bad_ipv6
add address=100::/64 comment="defconf: discard only " list=bad_ipv6
add address=2001:db8::/32 comment="defconf: documentation" list=bad_ipv6
add address=2001:10::/28 comment="defconf: ORCHID" list=bad_ipv6
add address=3ffe::/16 comment="defconf: 6bone" list=bad_ipv6

/ipv6 firewall filter
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="defconf: accept ICMPv6" protocol=\
    icmpv6
add action=accept chain=input comment="defconf: accept UDP traceroute" port=\
    33434-33534 protocol=udp
add action=accept chain=input comment=\
    "defconf: accept DHCPv6-Client prefix delegation." dst-port=546 protocol=\
    udp src-address=fe80::/10
add action=accept chain=input comment="defconf: accept IKE" dst-port=500,4500 \
    protocol=udp
add action=accept chain=input comment="defconf: accept ipsec AH" protocol=\
    ipsec-ah
add action=accept chain=input comment="defconf: accept ipsec ESP" protocol=\
    ipsec-esp
add action=accept chain=input comment=\
    "defconf: accept all that matches ipsec policy" ipsec-policy=in,ipsec
add action=drop chain=input comment=\
    "defconf: drop everything else not coming from LAN" in-interface-list=\
    !*2000011
add action=accept chain=forward comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=forward comment=\
    "defconf: drop packets with bad src ipv6" src-address-list=bad_ipv6
add action=drop chain=forward comment=\
    "defconf: drop packets with bad dst ipv6" dst-address-list=bad_ipv6
add action=drop chain=forward comment="defconf: rfc4890 drop hop-limit=1" \
    hop-limit=equal:1 protocol=icmpv6
add action=accept chain=forward comment="defconf: accept ICMPv6" protocol=\
    icmpv6
add action=accept chain=forward comment="defconf: accept HIP" protocol=139
add action=accept chain=forward comment="defconf: accept IKE" dst-port=\
    500,4500 protocol=udp
add action=accept chain=forward comment="defconf: accept ipsec AH" protocol=\
    ipsec-ah
add action=accept chain=forward comment="defconf: accept ipsec ESP" protocol=\
    ipsec-esp
add action=accept chain=forward comment=\
    "defconf: accept all that matches ipsec policy" ipsec-policy=in,ipsec
add action=drop chain=forward comment=\
    "defconf: drop everything else not coming from LAN" in-interface-list=\
    !*2000011

/system clock
set time-zone-name=America/New_York

/ip cloud
set ddns-enabled=yes

/system ntp client
set enabled=yes

/system ntp client servers
add address=pool.ntp.org

/system ntp server
set broadcast=yes broadcast-addresses=192.168.99.255 enabled=yes

/system routerboard settings
set cpu-frequency=auto

/ip smb shares
add comment="default share" directory=/pub name=pub
add comment="default share" directory=/pub name=pub

/ip smb users
add name=guest
add name=guest
