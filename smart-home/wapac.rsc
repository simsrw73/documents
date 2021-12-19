# jan/04/1970 00:24:28 by RouterOS 7.1
# software id = YCAH-QLG1
#
# model = RBwAPG-5HacD2HnD
# serial number = E4660DD387D8
/interface bridge
add name=bridge vlan-filtering=yes
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-g/n disabled=no distance=indoors \
    frequency=2437 installation=outdoor mode=ap-bridge name=wlan-2g ssid=\
    1736StrtfrdRmsCt wireless-protocol=802.11 wps-mode=disabled
set [ find default-name=wlan2 ] band=5ghz-a/n/ac channel-width=\
    20/40/80mhz-XXXX disabled=no distance=indoors frequency=5765 \
    installation=outdoor mode=ap-bridge name=wlan-5g ssid=1736StrtfrdRmsCt \
    wireless-protocol=802.11 wps-mode=disabled
/interface vlan
add interface=bridge name=vlan-base vlan-id=99
/interface list
add name=VLAN_BASE
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk eap-methods="" mode=\
    dynamic-keys supplicant-identity=MikroTik
add authentication-types=wpa2-psk eap-methods="" mode=dynamic-keys name=\
    profile-guest supplicant-identity=MikroTik
add authentication-types=wpa2-psk eap-methods="" mode=dynamic-keys name=\
    profile-iot supplicant-identity=MikroTik
add authentication-types=wpa2-psk eap-methods="" mode=dynamic-keys name=\
    profile-base supplicant-identity=MikroTik
add authentication-types=wpa2-psk eap-methods="" mode=dynamic-keys name=\
    profile-security supplicant-identity=MikroTik
/interface wireless
add default-forwarding=no disabled=no keepalive-frames=disabled mac-address=\
    0A:55:31:D9:23:A4 master-interface=wlan-2g multicast-buffering=disabled \
    name=wlan-2g-guest security-profile=profile-guest ssid=\
    1736StrtfrdRmsCt-Guest wds-cost-range=0 wds-default-cost=0 wps-mode=\
    disabled
add disabled=no keepalive-frames=disabled mac-address=0A:55:31:D9:23:A5 \
    master-interface=wlan-2g multicast-buffering=disabled name=wlan-2g-iot \
    security-profile=profile-iot ssid=1736StrtfrdRmsCt-IOT wds-cost-range=0 \
    wds-default-cost=0 wps-mode=disabled
add disabled=no keepalive-frames=disabled mac-address=0A:55:31:D9:23:A6 \
    master-interface=wlan-2g multicast-buffering=disabled name=\
    wlan-2g-security security-profile=profile-security ssid=\
    1736StrtfrdRmsCt-Security wds-cost-range=0 wds-default-cost=0 wps-mode=\
    disabled
add default-forwarding=no disabled=no keepalive-frames=disabled mac-address=\
    0A:55:31:D9:23:A7 master-interface=wlan-5g multicast-buffering=disabled \
    name=wlan-5g-guest security-profile=profile-guest ssid=\
    1736StrtfrdRmsCt-Guest wds-cost-range=0 wds-default-cost=0 wps-mode=\
    disabled
add disabled=no keepalive-frames=disabled mac-address=0A:55:31:D9:23:A8 \
    master-interface=wlan-5g multicast-buffering=disabled name=wlan-5g-iot \
    security-profile=profile-iot ssid=1736StrtfrdRmsCt-IOT wds-cost-range=0 \
    wds-default-cost=0 wps-mode=disabled
add disabled=no keepalive-frames=disabled mac-address=0A:55:31:D9:23:A9 \
    master-interface=wlan-5g multicast-buffering=disabled name=\
    wlan-5g-security security-profile=profile-security ssid=\
    1736StrtfrdRmsCt-Security wds-cost-range=0 wds-default-cost=0 wps-mode=\
    disabled
/interface bridge port
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether2
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=wlan-2g pvid=99
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=wlan-5g pvid=99
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether1
/ip neighbor discovery-settings
set discover-interface-list=all
/interface bridge vlan
add bridge=bridge tagged=bridge,ether1,ether2 vlan-ids=99
add bridge=bridge tagged=ether1,ether2 vlan-ids=101
add bridge=bridge tagged=ether1,ether2 vlan-ids=107
add bridge=bridge tagged=ether1,ether2 vlan-ids=119
/interface list member
add interface=ether1 list=VLAN_BASE
add interface=ether2 list=VLAN_BASE
/ip address
add address=192.168.99.6 interface=vlan-base network=192.168.99.6
/ip dns
set allow-remote-requests=yes servers=192.168.99.1
/ip dns static
add address=192.168.88.1 comment=defconf name=router.lan
/ip route
add disabled=no distance=1 dst-address="" gateway=192.168.99.1 routing-table=\
    main suppress-hw-offload=no
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
/system identity
set name=AP02-Patio
/system routerboard settings
set cpu-frequency=auto
