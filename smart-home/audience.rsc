# dec/24/2021 09:17:28 by RouterOS 7.1.1
# software id = L4BD-ZE0J
#
# model = RBD25G-5HPacQD2HPnD
# serial number = D5840D80F71A

/system identity
set name=AP01-Office

/interface bridge
add admin-mac=08:55:31:69:F3:2F auto-mac=no name=bridge protocol-mode=none \
    vlan-filtering=yes

/interface bridge port
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether1
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether2
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=wlan-5g pvid=99
add bridge=bridge interface=wlan3
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=wlan-2g pvid=99
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=wlan-2g-guest pvid=101
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=wlan-2g-iot pvid=107
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=wlan-5g-guest pvid=101
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=wlan-5g-iot pvid=107
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=wlan-2g-nest pvid=107

/interface bridge vlan
add bridge=bridge tagged=bridge,ether1,ether2 vlan-ids=99
add bridge=bridge tagged=ether1,ether2 vlan-ids=101
add bridge=bridge tagged=ether1,ether2 vlan-ids=107

/interface list
add name=BASE

/interface list member
add interface=vlan-base list=BASE

/interface vlan
add interface=bridge name=vlan-base vlan-id=99

/interface wireless cap
set bridge=bridge discovery-interfaces=bridge interfaces=\
    wlan-2g,wlan-5g,wlan3

/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk mode=dynamic-keys \
    supplicant-identity=MikroTik
add authentication-types=wpa2-psk eap-methods="" mode=dynamic-keys name=\
    profile-guest supplicant-identity=""
add authentication-types=wpa2-psk eap-methods="" mode=dynamic-keys name=\
    profile-iot supplicant-identity=""
add authentication-types=wpa2-psk eap-methods="" mode=dynamic-keys name=\
    profile-nest supplicant-identity=""

/interface wireless
add default-forwarding=no disabled=no keepalive-frames=disabled mac-address=\
    0A:55:31:69:F3:31 master-interface=wlan-2g multicast-buffering=disabled \
    name=wlan-2g-guest security-profile=profile-guest ssid=\
    1736StrtfrdRmsCt-Guest wds-cost-range=0 wds-default-cost=0 wps-mode=\
    disabled
add disabled=no keepalive-frames=disabled mac-address=0A:55:31:69:F3:32 \
    master-interface=wlan-2g multicast-buffering=disabled name=wlan-2g-iot \
    security-profile=profile-iot ssid=1736StrtfrdRmsCt-IOT wds-cost-range=0 \
    wds-default-cost=0 wps-mode=disabled
add disabled=no keepalive-frames=disabled mac-address=0A:55:31:69:F3:35 \
    master-interface=wlan-2g multicast-buffering=disabled name=wlan-2g-nest \
    security-profile=profile-nest ssid="Randy's Nest" wds-cost-range=0 \
    wds-default-cost=0 wps-mode=disabled
add default-forwarding=no disabled=no keepalive-frames=disabled mac-address=\
    0A:55:31:69:F3:33 master-interface=wlan-5g multicast-buffering=disabled \
    name=wlan-5g-guest security-profile=profile-guest ssid=\
    1736StrtfrdRmsCt-Guest wds-cost-range=0 wds-default-cost=0 wps-mode=\
    disabled
add keepalive-frames=disabled mac-address=0A:55:31:69:F3:34 master-interface=\
    wlan-5g multicast-buffering=disabled name=wlan-5g-iot security-profile=\
    profile-iot ssid=1736StrtfrdRmsCt-IOT wds-cost-range=0 wds-default-cost=0 \
    wps-mode=disabled

/interface wireless access-list
add authentication=no comment="REJECT: Echo: Bedroom R" interface=wlan-2g \
    mac-address=74:E2:0C:A2:49:D5
add authentication=no comment="REJECT: Echo: Bedroom R" interface=\
    wlan-2g-nest mac-address=74:E2:0C:A2:49:D5
add authentication=no comment="REJECT: Echo: Bedroom R" interface=wlan-5g \
    mac-address=74:E2:0C:A2:49:D5
add authentication=no comment="REJECT: Echo: Bedroom L" interface=wlan-2g \
    mac-address=D8:BE:65:54:93:23
add authentication=no comment="REJECT: Echo: Bedroom L" interface=\
    wlan-2g-nest mac-address=D8:BE:65:54:93:23
add authentication=no comment="REJECT: Echo: Bedroom L" interface=wlan-5g \
    mac-address=D8:BE:65:54:93:23
add authentication=no comment="REJECT: Echo: Bathroom" interface=wlan-2g \
    mac-address=0C:EE:99:E6:93:BA
add authentication=no comment="REJECT: Echo: Bathroom" interface=wlan-2g-nest \
    mac-address=0C:EE:99:E6:93:BA
add authentication=no comment="REJECT: Echo: Bathroom" interface=wlan-5g \
    mac-address=0C:EE:99:E6:93:BA
add authentication=no comment="REJECT: Echo: Dining Room" interface=wlan-2g \
    mac-address=FC:49:2D:A7:3D:29
add authentication=no comment="REJECT: Echo: Dining Room" interface=\
    wlan-2g-nest mac-address=FC:49:2D:A7:3D:29
add authentication=no comment="REJECT: Echo: Dining Room" interface=wlan-5g \
    mac-address=FC:49:2D:A7:3D:29
add authentication=no comment="REJECT: Echo: Family Room" interface=wlan-2g \
    mac-address=C8:6C:3D:03:D4:E5
add authentication=no comment="REJECT: Echo: Family Room" interface=\
    wlan-2g-nest mac-address=C8:6C:3D:03:D4:E5
add authentication=no comment="REJECT: Echo: Family Room" interface=wlan-5g \
    mac-address=C8:6C:3D:03:D4:E5
add authentication=no comment="REJECT: Echo: Kitchen Show" interface=wlan-2g \
    mac-address=10:96:93:C4:0F:47
add authentication=no comment="REJECT: Echo: Kitchen Show" interface=\
    wlan-2g-nest mac-address=10:96:93:C4:0F:47
add authentication=no comment="REJECT: Echo: Kitchen Show" interface=wlan-5g \
    mac-address=10:96:93:C4:0F:47
add authentication=no comment="REJECT: Echo: Laundry Room" interface=wlan-2g \
    mac-address=74:A7:EA:F1:DB:E5
add authentication=no comment="REJECT: Echo: Laundry Room" interface=\
    wlan-2g-nest mac-address=74:A7:EA:F1:DB:E5
add authentication=no comment="REJECT: Echo: Laundry Room" interface=wlan-5g \
    mac-address=74:A7:EA:F1:DB:E5
add authentication=no comment="REJECT: Echo: Master Bedroom" interface=\
    wlan-2g mac-address=00:F3:61:6E:B6:C8
add authentication=no comment="REJECT: Echo: Master Bedroom" interface=\
    wlan-2g-nest mac-address=00:F3:61:6E:B6:C8
add authentication=no comment="REJECT: Echo: Master Bedroom" interface=\
    wlan-5g mac-address=00:F3:61:6E:B6:C8
add authentication=no comment="REJECT: Echo: Spare Bedroom" interface=wlan-2g \
    mac-address=F8:54:B8:97:35:2D
add authentication=no comment="REJECT: Echo: Spare Bedroom" interface=\
    wlan-2g-nest mac-address=F8:54:B8:97:35:2D
add authentication=no comment="REJECT: Echo: Spare Bedroom" interface=wlan-5g \
    mac-address=F8:54:B8:97:35:2D
add authentication=no comment="REJECT: Echo: Shop" interface=wlan-2g \
    mac-address=08:A6:BC:33:B0:13
add authentication=no comment="REJECT: Echo: Shop" interface=wlan-2g-nest \
    mac-address=08:A6:BC:33:B0:13
add authentication=no comment="REJECT: Echo: Shop" interface=wlan-5g \
    mac-address=08:A6:BC:33:B0:13

/ip dns
set servers=192.168.99.1

/ip address
add address=192.168.99.5/24 interface=vlan-base network=192.168.99.0

/ip route
add distance=1 gateway=192.168.99.1

/ip neighbor discovery-settings
set discover-interface-list=BASE

/system clock
set time-zone-name=America/New_York

/system ntp client
set enabled=yes mode=broadcast

/system ntp client servers
add address=192.168.99.1

/system routerboard settings
set cpu-frequency=auto
