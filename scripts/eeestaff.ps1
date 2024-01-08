net user staff eeestaff /add
net localgroup administrators staff /add
net user student /delete
netsh wlan delete profile name="Computing Laboratory"
get-netadapter "Wi-Fi" | Set-DnsClientServerAddress -ResetServerAddresses
choco uninstall pginafork
