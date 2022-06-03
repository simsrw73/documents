# jun/03/2022 17:02:28 by RouterOS 7.2.3
# software id = SYTB-ZK4C
#
# model = RB5009UG+S+
# serial number = EC1A0FCC6B92
/caps-man channel
add band=2ghz-g/n control-channel-width=20mhz frequency=2412 name=\
    channel-2G-Ch1
add band=2ghz-g/n control-channel-width=20mhz frequency=2437 name=\
    channel-2G-Ch6
add band=2ghz-g/n control-channel-width=20mhz frequency=2462 name=\
    channel-2G-Ch11
/interface bridge
add admin-mac=DC:2C:6E:47:0F:C0 auto-mac=no name=bridge protocol-mode=none \
    vlan-filtering=yes
/interface ethernet
set [ find default-name=ether7 ] name=ether7-Access
set [ find default-name=sfp-sfpplus1 ] advertise=1000M-full,10000M-full \
    speed=1Gbps
/interface vlan
add interface=bridge name=vlan-base vlan-id=99
add interface=bridge name=vlan-guest vlan-id=101
add interface=bridge name=vlan-iot vlan-id=107
add interface=bridge name=vlan-security vlan-id=119
add interface=bridge name=vlan-server vlan-id=200
add interface=bridge name=vlan-voip vlan-id=111
/caps-man datapath
add bridge=bridge name=datapath-base vlan-id=99 vlan-mode=use-tag
add bridge=bridge name=datapath-guest vlan-id=101 vlan-mode=use-tag
add bridge=bridge name=datapath-iot vlan-id=107 vlan-mode=use-tag
add bridge=bridge name=datapath-security vlan-id=119 vlan-mode=use-tag
add bridge=bridge name=datapath-nest vlan-id=107 vlan-mode=use-tag
/caps-man rates
add basic=12Mbps name=rate-Minimum supported=\
    12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps
/caps-man security
add authentication-types=wpa2-psk encryption=aes-ccm name=security-base
add authentication-types=wpa2-psk encryption=aes-ccm name=security-guest
add authentication-types=wpa2-psk encryption=aes-ccm name=security-iot
add authentication-types=wpa2-psk encryption=aes-ccm name=security-security
add authentication-types=wpa2-psk encryption=aes-ccm name=security-voip
add authentication-types=wpa2-psk encryption=aes-ccm name=security-nest
/caps-man configuration
add channel=channel-2G-Ch1 country="united states3" datapath=datapath-base \
    installation=any mode=ap name=cfg-BASE-2G-Ch1-DP-base-Sec-base rates=\
    rate-Minimum security=security-base ssid=1736StrtfrdRmsCt
add channel=channel-2G-Ch11 country="united states3" datapath=datapath-base \
    installation=any mode=ap name=cfg-BASE-2G-Ch11-DP-base-Sec-base rates=\
    rate-Minimum security=security-base ssid=1736StrtfrdRmsCt
add channel=channel-2G-Ch6 country="united states3" datapath=datapath-base \
    installation=any mode=ap name=cfg-BASE-2G-Ch6-DP-base-Sec-base rates=\
    rate-Minimum security=security-base ssid=1736StrtfrdRmsCt
add datapath=datapath-guest mode=ap name=cfg-slave-GUEST-DP-guest-Sec-guest \
    rates=rate-Minimum security=security-guest ssid=1736StrtfrdRmsCt-Guest
add datapath=datapath-iot mode=ap name=cfg-slave-IOT-DP-iot-Sec-iot rates=\
    rate-Minimum security=security-iot ssid=1736StrtfrdRmsCt-IOT
add datapath=datapath-nest mode=ap name=cfg-slave-NEST-DP-nest-Sec-nest \
    rates=rate-Minimum security=security-nest ssid="Randy's Nest"
add channel.band=5ghz-n/ac country="united states3" datapath=datapath-base \
    installation=any mode=ap name=cfg-BASE-5G-DP-base-SEC-base rates=\
    rate-Minimum security=security-base ssid=1736StrtfrdRmsCt5
add datapath=datapath-guest mode=ap name=\
    cfg-slave-GUEST-5G-DP-guest-Sec-guest rates=rate-Minimum security=\
    security-guest ssid=1736StrtfrdRmsCt5-Guest
/interface list
add name=WAN
add name=VLAN
add name=BASE
add name=TRUSTED
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool-base ranges=192.168.99.31-192.168.99.254
add name=dhcp_pool-guest ranges=192.168.101.21-192.168.101.254
add name=dhcp_pool-iot ranges=192.168.107.21-192.168.107.254
add name=dhcp_pool-security ranges=192.168.119.21-192.168.119.254
add name=dhcp_pool-voip ranges=192.168.111.21-192.168.111.254
add name=dhcp_pool-server ranges=192.168.200.200-192.168.200.249
/ip dhcp-server
add address-pool=dhcp_pool-base interface=vlan-base name=dhcp-base
add address-pool=dhcp_pool-guest interface=vlan-guest name=dhcp-guest
add address-pool=dhcp_pool-iot interface=vlan-iot name=dhcp-iot
add address-pool=dhcp_pool-security interface=vlan-security name=\
    dhcp-security
add address-pool=dhcp_pool-voip interface=vlan-voip name=dhcp-voip
add address-pool=dhcp_pool-server interface=vlan-server name=dhcp-server
/system logging action
set 3 remote=192.168.200.14
/zerotier
set zt1 comment="ZeroTier Central controller - https://my.zerotier.com/" \
    identity="f55bcabe36:0:fa4f01a27a8baa8969f7285494c8094ad21da6d138b94e89f9c\
    8dc807f2a1e4cb87eaafb41e6209b325763a9929860267e2f52fa4f8c40430b9c2ea2a7844\
    c2d:7f44ad7c69dbda23c3627640c5cd27b774ab5e45cec114886945d83569982a630154d2\
    d048fb6573dd2b26d333ddd8d952df47d59799db4cfbc878ae1389addd" name=zt1 \
    port=9993
/zerotier interface
add instance=zt1 name=zerotier1 network=a84ac5c10a383fa0
/caps-man access-list
add action=accept allow-signal-out-of-range=10s disabled=no signal-range=\
    -80..120 ssid-regexp=""
add action=reject allow-signal-out-of-range=10s disabled=no ssid-regexp=""
/caps-man manager
set ca-certificate=CAPsMAN-CA-DC2C6E470FBF certificate=CAPsMAN-DC2C6E470FBF \
    enabled=yes upgrade-policy=suggest-same-version
/caps-man manager interface
set [ find default=yes ] forbid=yes
add disabled=no interface=vlan-base
/caps-man provisioning
add action=create-dynamic-enabled comment="AP01-Office [Audience]" \
    master-configuration=cfg-BASE-2G-Ch1-DP-base-Sec-base name-format=\
    identity radio-mac=08:55:31:69:F3:31 slave-configurations="cfg-slave-GUEST\
    -DP-guest-Sec-guest,cfg-slave-IOT-DP-iot-Sec-iot,cfg-slave-NEST-DP-nest-Se\
    c-nest"
add action=create-dynamic-enabled comment="AP01-Office [Audience] (5GHz)" \
    master-configuration=cfg-BASE-5G-DP-base-SEC-base name-format=identity \
    radio-mac=08:55:31:69:F3:32 slave-configurations=\
    cfg-slave-GUEST-5G-DP-guest-Sec-guest
add action=create-dynamic-enabled comment="AP02-Patio [wAP AC]" \
    master-configuration=cfg-BASE-2G-Ch6-DP-base-Sec-base name-format=\
    identity radio-mac=08:55:31:D9:23:A4 slave-configurations="cfg-slave-GUEST\
    -DP-guest-Sec-guest,cfg-slave-IOT-DP-iot-Sec-iot,cfg-slave-NEST-DP-nest-Se\
    c-nest"
add action=create-dynamic-enabled comment="AP02-Patio [wAP AC] (5GHz)" \
    master-configuration=cfg-BASE-5G-DP-base-SEC-base name-format=identity \
    radio-mac=08:55:31:D9:23:A5 slave-configurations=\
    cfg-slave-GUEST-5G-DP-guest-Sec-guest
add action=create-dynamic-enabled comment="AP03-FamilyRoom [cAP XL AC]" \
    master-configuration=cfg-BASE-2G-Ch11-DP-base-Sec-base name-format=\
    identity radio-mac=DC:2C:6E:1E:81:FA slave-configurations="cfg-slave-GUEST\
    -DP-guest-Sec-guest,cfg-slave-IOT-DP-iot-Sec-iot,cfg-slave-NEST-DP-nest-Se\
    c-nest"
add action=create-dynamic-enabled comment=\
    "AP03-FamilyRoom [cAP XL AC] (5GHz)" master-configuration=\
    cfg-BASE-5G-DP-base-SEC-base name-format=identity radio-mac=\
    DC:2C:6E:1E:81:FB slave-configurations=\
    cfg-slave-GUEST-5G-DP-guest-Sec-guest
/interface bridge port
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether2
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether3
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether4
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether5 pvid=99
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether6 pvid=99
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether8 pvid=99
add bridge=bridge frame-types=admit-only-vlan-tagged interface=sfp-sfpplus1
add bridge=bridge interface=zerotier1
/ip neighbor discovery-settings
set discover-interface-list=BASE
/interface bridge vlan
add bridge=bridge tagged=bridge,sfp-sfpplus1 untagged=ether5 vlan-ids=99
add bridge=bridge tagged=bridge,sfp-sfpplus1 vlan-ids=101
add bridge=bridge tagged=bridge,sfp-sfpplus1 vlan-ids=107
add bridge=bridge tagged=bridge,sfp-sfpplus1 vlan-ids=119
add bridge=bridge tagged=bridge,sfp-sfpplus1 vlan-ids=111
add bridge=bridge tagged=bridge,sfp-sfpplus1 vlan-ids=200
/interface list member
add interface=ether1 list=WAN
add interface=vlan-guest list=VLAN
add interface=vlan-iot list=VLAN
add interface=vlan-base list=BASE
add interface=vlan-base list=VLAN
add interface=ether7-Access list=BASE
add interface=vlan-security list=VLAN
add interface=vlan-server list=VLAN
add interface=vlan-voip list=VLAN
add interface=zerotier1 list=VLAN
add interface=zerotier1 list=BASE
/interface ovpn-server server
set auth=sha1,md5
/ip address
add address=192.168.99.1/24 interface=vlan-base network=192.168.99.0
add address=192.168.101.1/24 interface=vlan-guest network=192.168.101.0
add address=192.168.107.1/24 interface=vlan-iot network=192.168.107.0
add address=192.168.9.11/24 interface=ether7-Access network=192.168.9.0
add address=192.168.119.1/24 interface=vlan-security network=192.168.119.0
add address=192.168.111.1/24 interface=vlan-voip network=192.168.111.0
add address=192.168.200.1/24 interface=vlan-server network=192.168.200.0
/ip cloud
set ddns-enabled=yes update-time=no
/ip dhcp-client
add interface=ether1 use-peer-dns=no
/ip dhcp-server lease
add address=192.168.99.15 client-id=1:60:12:8b:5c:43:5b comment=\
    "Canon MB5320 Printer" mac-address=60:12:8B:5C:43:5B server=dhcp-base
add address=192.168.200.14 client-id=1:e4:5f:1:95:b2:43 mac-address=\
    E4:5F:01:95:B2:43 server=dhcp-server
add address=192.168.200.200 mac-address=36:59:4B:91:03:74 server=dhcp-server
add address=192.168.200.201 client-id=\
    ff:2f:bd:15:e7:0:1:0:1:2a:23:8d:e4:76:f:2f:bd:15:e7 mac-address=\
    76:0F:2F:BD:15:E7 server=dhcp-server
/ip dhcp-server network
add address=192.168.99.0/24 caps-manager=192.168.99.1 dns-server=192.168.99.1 \
    gateway=192.168.99.1 ntp-server=192.168.99.1
add address=192.168.101.0/24 dns-server=192.168.99.1 gateway=192.168.101.1 \
    ntp-server=192.168.99.1
add address=192.168.107.0/24 dns-server=192.168.99.1 gateway=192.168.107.1 \
    ntp-server=192.168.99.1
add address=192.168.111.0/24 dns-server=192.168.99.1 gateway=192.168.111.1 \
    ntp-server=192.168.99.1
add address=192.168.119.0/24 dns-server=192.168.99.1 gateway=192.168.119.1 \
    ntp-server=192.168.99.1
add address=192.168.200.0/24 dns-server=192.168.99.1 gateway=192.168.200.1 \
    ntp-server=192.168.99.1
/ip dns
set allow-remote-requests=yes servers=\
    1.1.1.3,1.0.0.3,2606:4700:4700::1113,2606:4700:4700::1003 use-doh-server=\
    https://family.cloudflare-dns.com/dns-query verify-doh-cert=yes
/ip dns static
add address=192.168.200.10 name=zadkiel.home.arpa
add address=192.168.99.20 name=cassiel.home.arpa
add address=192.168.200.14 name=raziel.home.arpa
add address=192.168.200.10 name=proxmox.home.arpa
add address=192.168.99.1 name=uriel.home.arpa
/ip firewall address-list
add address=ec1a0fcc6b92.sn.mynetname.net list=WAN_IP
/ip firewall filter
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=accept chain=input comment="Accept DNS (udp)" dst-port=53 \
    in-interface-list=VLAN protocol=udp
add action=accept chain=input comment="Accept DNS (tcp)" dst-port=53 \
    in-interface-list=VLAN protocol=tcp
add action=accept chain=input comment="Accept NTP" dst-port=123,12300 \
    in-interface-list=VLAN protocol=udp
add action=accept chain=input comment=\
    "defconf: accept to local loopback (for CAPsMAN)" dst-address=127.0.0.1
add action=accept chain=input comment="Allow BASE" in-interface-list=BASE
add action=reject chain=input comment="Reject icmp-admin-prohibited" \
    in-interface-list=VLAN reject-with=icmp-admin-prohibited
add action=drop chain=input comment="Drop everything else"
add action=accept chain=forward comment="defconf: accept in ipsec policy" \
    ipsec-policy=in,ipsec
add action=accept chain=forward comment="defconf: accept out ipsec policy" \
    ipsec-policy=out,ipsec
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" \
    connection-state=established,related hw-offload=yes
add action=accept chain=forward comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=accept chain=forward comment="Allow VLAN access Internet" \
    connection-state=new in-interface-list=VLAN out-interface-list=WAN
add action=accept chain=forward comment="Allow BASE to Server VLAN" \
    in-interface-list=BASE out-interface=vlan-server
add action=accept chain=forward comment="Allow Inter-VLAN" in-interface=\
    vlan-base out-interface=vlan-security
add action=accept chain=forward comment=\
    "Allow dst-nat from both WAN and LAN (including port forwarding)" \
    connection-nat-state=dstnat
add action=reject chain=forward comment="Reject icmp-admin-prohibited" \
    reject-with=icmp-admin-prohibited
add action=drop chain=forward comment="Drop everything else" log=yes \
    log-prefix="** DROP ALL:"
/ip firewall nat
add action=dst-nat chain=dstnat comment="Port Fwd for WWW" dst-address-list=\
    WAN_IP dst-port=80,443 in-interface-list=WAN protocol=tcp to-addresses=\
    192.168.200.201
add action=src-nat chain=srcnat comment=\
    "Translate NTP from 123 to 12300 to bypass AT&T block of port 123" \
    protocol=udp src-port=123 to-ports=12300
add action=masquerade chain=srcnat comment="defconf: masquerade" \
    ipsec-policy=out,none out-interface-list=WAN
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh address=192.168.99.0/24,192.168.9.0/24,10.173.18.0/24
set api disabled=yes
set winbox address=192.168.99.0/24,192.168.9.0/24,10.173.18.0/24
set api-ssl disabled=yes
/ip smb shares
add comment="default share" directory=/pub name=pub
add comment="default share" directory=/pub name=pub
/ip smb users
add name=guest
add name=guest
/ip ssh
set strong-crypto=yes
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
/system identity
set name=RT1-Office-NR2
/system logging
add action=remote topics=critical,warning,info,debug,error
/system ntp client
set enabled=yes
/system ntp server
set enabled=yes manycast=yes multicast=yes
/system ntp client servers
add address=0.north-america.pool.ntp.org
add address=1.north-america.pool.ntp.org
add address=2.north-america.pool.ntp.org
add address=3.north-america.pool.ntp.org
/system scheduler
add interval=25w5d name=schedule-UpdateCACerts on-event=\
    "/system/script/run script-UpdateCACerts" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=dec/30/2021 start-time=02:30:00
/system script
add dont-require-permissions=no name=script-UpdateCACerts owner=Yosef policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="{\
    \r\
    \n  :do {\r\
    \n      /tool fetch url=https://mkcert.org/generate/ check-certificate=yes\
    \_dst-path=cacert.pem;\r\
    \n      /certificate remove [ find where authority expired ];\r\
    \n      /certificate import file-name=cacert.pem passphrase=\"\";\r\
    \n      /file remove cacert.pem;\r\
    \n      :log info (\"CACERT: Updated certificate trust store\");\r\
    \n  } on-error={\r\
    \n      :log error (\"CACERT: Failed to update certificate trust store\");\
    \r\
    \n  };\r\
    \n}"
/tool mac-server
set allowed-interface-list=BASE
/tool mac-server mac-winbox
set allowed-interface-list=BASE
/tool romon
set enabled=yes
