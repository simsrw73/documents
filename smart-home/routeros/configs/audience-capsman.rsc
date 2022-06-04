# jun/04/2022 18:44:11 by RouterOS 7.2.3
# software id = L4BD-ZE0J
#
# model = RBD25G-5HPacQD2HPnD
# serial number = D5840D80F71A
/interface bridge
add admin-mac=08:55:31:69:F3:2F auto-mac=no comment=defconf name=bridgeLocal
/interface wireless
# managed by CAPsMAN
# channel: 2412/20-Ce/gn(27dBm), SSID: 1736StrtfrdRmsCt, CAPsMAN forwarding
set [ find default-name=wlan1 ] ssid=MikroTik
# managed by CAPsMAN
# channel: 5180/20-Ceee/ac(26dBm), SSID: 1736StrtfrdRmsCt5, CAPsMAN forwarding
set [ find default-name=wlan2 ] ssid=MikroTik
set [ find default-name=wlan3 ] ssid=MikroTik
/interface list
add name=MGMT
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridgeLocal comment=defconf interface=ether1
add bridge=bridgeLocal comment=defconf interface=ether2
/ip neighbor discovery-settings
set discover-interface-list=MGMT
/interface list member
add interface=ether1 list=MGMT
/interface wireless cap
# 
set bridge=bridgeLocal certificate=CAP-08553169F32F discovery-interfaces=\
    bridgeLocal enabled=yes interfaces=wlan1,wlan2
/ip dhcp-client
add comment=defconf interface=bridgeLocal
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/ip ssh
set host-key-size=4096 strong-crypto=yes
/system clock
set time-zone-name=America/New_York
/system identity
set name=AP01-Office
/system ntp client
set enabled=yes mode=multicast
/system ntp client servers
add address=192.168.99.1
/tool mac-server
set allowed-interface-list=MGMT
/tool mac-server mac-winbox
set allowed-interface-list=MGMT
