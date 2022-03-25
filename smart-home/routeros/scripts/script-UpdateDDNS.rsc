# Variables
:local GoogleDNSUsername "Xdb3ILxQVxc7raMT"
:local GoogleDNSPassword "p3cM5AoNMvakMVnL"
:local hostName "mysmarthome.network"
:local currentIP ""
:local previousIP ""
:local Results ""
:local fileResults "GoogleDNS.txt"

# Script
:set currentIP [/ip cloud get public-address]
:set previousIP [:resolve "$hostName"]

:if ($currentIP != $previousIP) do={
    :do {
        /tool fetch url="https://$GoogleDNSUsername:$GoogleDNSPassword@domains.google.com/nic/update?hostname=$hostName&myip=$currentIP" http-header-field="User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:70.0) Gecko/20100101 Firefox/70.0" mode=https dst-path=$fileResults
        :set Results [/file get $fileResults contents];
        :log info ("DDNS Updater: GoogleDNS said this: $Results")
    } on-error={ 
        :log error ("DDNS Updater: GoogleDNS: script failed to set new IP address") 
    }
    /file remove $fileResults
}