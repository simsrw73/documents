# dec/24/2021 10:08:15 by RouterOS 7.1.1
# software id = YCAH-QLG1
#
# model = RBwAPG-5HacD2HnD
# serial number = E4660DD387D8

/system identity
set name=AP02-Patio

/interface bridge
add name=bridge protocol-mode=none vlan-filtering=yes

/interface bridge port
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether2
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=wlan-2g pvid=99
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=wlan-5g pvid=99
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether1

/interface bridge vlan
add bridge=bridge tagged=bridge,ether1,ether2 vlan-ids=99
add bridge=bridge tagged=ether1,ether2 vlan-ids=101
add bridge=bridge tagged=ether1,ether2 vlan-ids=107
add bridge=bridge tagged=ether1,ether2 vlan-ids=119

/interface vlan
add interface=bridge name=vlan-base vlan-id=99

/interface list
add name=BASE

/interface list member
add interface=vlan-base list=BASE

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
set [ find default-name=wlan1 ] band=2ghz-g/n disabled=no distance=indoors \
    frequency=2437 installation=outdoor mode=ap-bridge name=wlan-2g ssid=\
    1736StrtfrdRmsCt wireless-protocol=802.11 wps-mode=disabled
set [ find default-name=wlan2 ] band=5ghz-a/n/ac channel-width=\
    20/40/80mhz-XXXX disabled=no distance=indoors frequency=5765 \
    installation=outdoor mode=ap-bridge name=wlan-5g ssid=1736StrtfrdRmsCt \
    wireless-protocol=802.11 wps-mode=disabled

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

/ip dns
set servers=192.168.99.1

/ip address
add address=192.168.99.6/24 interface=vlan-base network=192.168.99.0

/ip route
add disabled=no distance=1 dst-address="" gateway=192.168.99.1 routing-table=\
    main suppress-hw-offload=no
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

/system clock
set time-zone-name=America/New_York

/system routerboard settings
set cpu-frequency=auto
