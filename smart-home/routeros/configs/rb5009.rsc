# mar/25/2022 08:07:37 by RouterOS 7.1.5
# software id = SYTB-ZK4C
#
# model = RB5009UG+S+
# serial number = EC1A0FCC6B92
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
/interface list
add name=WAN
add name=VLAN
add name=BASE
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool-base ranges=192.168.99.31-192.168.99.254
add name=dhcp_pool-guest ranges=192.168.101.21-192.168.101.254
add name=dhcp_pool-iot ranges=192.168.107.21-192.168.107.254
add name=dhcp_pool-security ranges=192.168.119.21-192.168.119.254
add name=dhcp_pool-voip ranges=192.168.111.21-192.168.111.254
add name=dhcp_pool-server ranges=192.168.200.20-192.168.200.254
/ip dhcp-server
add address-pool=dhcp_pool-base interface=vlan-base name=dhcp-base
add address-pool=dhcp_pool-guest interface=vlan-guest name=dhcp-guest
add address-pool=dhcp_pool-iot interface=vlan-iot name=dhcp-iot
add address-pool=dhcp_pool-security interface=vlan-security name=\
    dhcp-security
add address-pool=dhcp_pool-voip interface=vlan-voip name=dhcp-voip
add address-pool=dhcp_pool-server interface=vlan-server name=dhcp-server
/interface bridge port
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether2 pvid=99
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether3
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether4
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether5
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether6
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether8 pvid=99
add bridge=bridge frame-types=admit-only-vlan-tagged interface=sfp-sfpplus1
/ip neighbor discovery-settings
set discover-interface-list=BASE
/interface bridge vlan
add bridge=bridge tagged=\
    bridge,ether2,ether3,ether4,ether5,ether6,sfp-sfpplus1 vlan-ids=99
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
/ip address
add address=192.168.99.1/24 interface=vlan-base network=192.168.99.0
add address=192.168.101.1/24 interface=vlan-guest network=192.168.101.0
add address=192.168.107.1/24 interface=vlan-iot network=192.168.107.0
add address=192.168.9.11/24 interface=ether7-Access network=192.168.9.0
add address=192.168.119.1/24 interface=vlan-security network=192.168.119.0
add address=192.168.111.1/24 interface=vlan-voip network=192.168.111.0
add address=192.168.200.0/24 interface=vlan-server network=192.168.200.0
/ip cloud
set ddns-enabled=yes update-time=no
/ip dhcp-client
add interface=ether1 use-peer-dns=no
/ip dhcp-server lease
add address=192.168.99.15 client-id=1:60:12:8b:5c:43:5b comment=\
    "Canon MB5320 Printer" mac-address=60:12:8B:5C:43:5B server=dhcp-base
add address=192.168.99.20 client-id=1:50:eb:f6:7e:73:de comment=Desktop \
    mac-address=50:EB:F6:7E:73:DE server=dhcp-base
add address=192.168.200.10 client-id=1:24:4b:fe:5a:a9:9e mac-address=\
    24:4B:FE:5A:A9:9E server=dhcp-server
/ip dhcp-server network
add address=192.168.99.0/24 gateway=192.168.99.1
add address=192.168.101.0/24 dns-server=192.168.99.1 gateway=192.168.101.1
add address=192.168.107.0/24 dns-server=192.168.99.1 gateway=192.168.107.1
add address=192.168.111.0/24 dns-server=192.168.99.1 gateway=192.168.111.1
add address=192.168.119.0/24 dns-server=192.168.99.1 gateway=192.168.119.1
add address=192.168.200.0/24 dns-server=192.168.99.1 gateway=192.168.200.1
/ip dns
set allow-remote-requests=yes servers=\
    1.1.1.3,1.0.0.3,2606:4700:4700::1113,2606:4700:4700::1003 use-doh-server=\
    https://family.cloudflare-dns.com/dns-query verify-doh-cert=yes
/ip dns static
add address=192.168.200.10 name=zadkiel.home.arpa
add address=192.168.99.20 name=cassiel.home.arpa
add address=192.168.200.10 name=wiki.home.arpa
/ip firewall address-list
add address=ec1a0fcc6b92.sn.mynetname.net list=WAN_IP
add address=192.168.99.0/24 list=Clients
/ip firewall filter
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=accept chain=input comment="Allow VLAN" in-interface-list=VLAN
add action=accept chain=input comment="Allow VLAN_BASE" in-interface=\
    vlan-base
add action=accept chain=input connection-state=new dst-port=123 \
    in-interface-list=VLAN log=yes log-prefix=NTP: protocol=udp
add action=accept chain=input comment="Allow LAN NTP queries-UDP" \
    connection-state=new dst-port=123 log=yes log-prefix=NTP:: protocol=udp
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid log=yes log-prefix=IN_INVALID:
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=accept chain=input comment=\
    "defconf: accept to local loopback (for CAPsMAN)" dst-address=127.0.0.1
add action=drop chain=input comment="Drop if not from BASE vlan" \
    in-interface-list=!BASE log=yes log-prefix=IN_NOTBASE
add action=drop chain=input comment="Drop everything else" disabled=yes
add action=accept chain=forward comment="Log NTP traffic" dst-port=123 log=\
    yes log-prefix=NTP: protocol=udp
add action=accept chain=forward comment="Allow connect to server from BASE" \
    dst-address=192.168.200.10 log=yes log-prefix=SERVER:
add action=accept chain=forward comment="defconf: accept in ipsec policy" \
    ipsec-policy=in,ipsec
add action=accept chain=forward comment="defconf: accept out ipsec policy" \
    ipsec-policy=out,ipsec
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" \
    connection-state=established,related hw-offload=yes
add action=accept chain=forward comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=accept chain=forward comment="Accept DSTNATed" \
    connection-nat-state=dstnat
add action=drop chain=forward comment=\
    "Isolation for wifi guest. Only allow internet." in-interface=vlan-guest \
    log=yes log-prefix=FWD_ISOLATE: out-interface-list=!WAN
add action=accept chain=forward comment="Allow VLAN access Internet" \
    connection-state=new in-interface-list=VLAN log=yes log-prefix=\
    VLAN->INTERNET: out-interface-list=WAN
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid log=yes log-prefix=FWD_INVALID:
add action=drop chain=forward comment=\
    "defconf: drop all from WAN not DSTNATed" connection-nat-state=!dstnat \
    connection-state=new in-interface-list=WAN log=yes log-prefix=\
    FWD_NOTDSTNAT
add action=drop chain=forward comment="Drop everything else" disabled=yes \
    log=yes
/ip firewall nat
add action=dst-nat chain=dstnat comment="Port Fwd for WWW" dst-address-list=\
    WAN_IP dst-port=80 in-interface=ether1 log=yes log-prefix=WWW protocol=\
    tcp to-addresses=192.168.200.10 to-ports=80
add action=masquerade chain=srcnat comment="Hairpin NAT" disabled=yes \
    dst-address=192.168.99.0/24 log=yes log-prefix="HAIRPIN: " src-address=\
    192.168.99.0/24
add action=masquerade chain=srcnat comment="defconf: masquerade" \
    ipsec-policy=out,none log=yes log-prefix="MASQ: " out-interface-list=WAN
add action=dst-nat chain=dstnat comment="Port Fwd for Home Assistant" \
    disabled=yes dst-address-list=WAN_IP dst-port=8123 protocol=tcp \
    to-addresses=192.168.99.10
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh address=192.168.99.0/24,192.168.9.0/24
set api disabled=yes
set winbox address=192.168.99.0/24,192.168.9.0/24
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
/system ntp client
set enabled=yes
/system ntp server
set manycast=yes
/system ntp client servers
add address=0.north-america.pool.ntp.org
add address=1.north-america.pool.ntp.org
add address=2.north-america.pool.ntp.org
add address=3.north-america.pool.ntp.org
/system routerboard settings
set cpu-frequency=auto
/system scheduler
add interval=25w5d name=schedule-UpdateCACerts on-event=\
    "/system/script/run script-UpdateCACerts" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=dec/30/2021 start-time=02:30:00
add interval=1d name=schedule-UpdateDDNS on-event=\
    "/system/script/run script-UpdateDDNS" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=dec/30/2021 start-time=02:40:00
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
add dont-require-permissions=no name=script-UpdateDDNS owner=Yosef policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    \_Variables\r\
    \n:local GoogleDNSUsername \"Xdb3ILxQVxc7raMT\"\r\
    \n:local GoogleDNSPassword \"p3cM5AoNMvakMVnL\"\r\
    \n:local hostName \"mysmarthome.network\"\r\
    \n:local currentIP \"\"\r\
    \n:local previousIP \"\"\r\
    \n:local Results \"\"\r\
    \n:local fileResults \"GoogleDNS.txt\"\r\
    \n\r\
    \n# Script\r\
    \n:set currentIP [/ip cloud get public-address]\r\
    \n:set previousIP [:resolve \"\$hostName\"]\r\
    \n\r\
    \n:if (\$currentIP != \$previousIP) do={\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://\$GoogleDNSUsername:\$GoogleDNSPasswor\
    d@domains.google.com/nic/update\?hostname=\$hostName&myip=\$currentIP\" ht\
    tp-header-field=\"User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:\
    70.0) Gecko/20100101 Firefox/70.0\" mode=https dst-path=\$fileResults\r\
    \n        :set Results [/file get \$fileResults contents];\r\
    \n        :log info (\"DDNS Updater: GoogleDNS said this: \$Results\")\r\
    \n    } on-error={ \r\
    \n        :log error (\"DDNS Updater: GoogleDNS: script failed to set new \
    IP address\") \r\
    \n    }\r\
    \n    /file remove \$fileResults\r\
    \n}"
/tool mac-server
set allowed-interface-list=BASE
/tool mac-server mac-winbox
set allowed-interface-list=BASE
/tool romon
set enabled=yes
