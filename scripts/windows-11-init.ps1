Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Host "Setting Timezone..."

Set-TimeZone -Id "Taipei Standard Time"

Write-Host "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Write-Host "Enabling remembered argument for Upgrades on Chocolatey..."
choco feature enable -n='useRememberedArgumentsForUpgrades'

Write-Host "Allow Global confirmation when installing and updating packages..."
choco feature enable -n=allowGlobalConfirmation

Write-Host "Changing admin password..."
net user admin ++adminzbook2023!!

Write-Host "Add administrator permission..."
net localgroup administrators admin /add

Write-Host "Creating user student..." 
net user student studentpass /add

Write-Host "Add administrator permission..." 
net localgroup administrators student /add

Write-Host "Changing student password..." 
net user student studentpass

Write-Host "Disable popup on install..." 
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0

Write-Host "Disable sleep mode..."
powercfg -change -standby-timeout-ac 0

Write-Host "Downloading WiFi Profile..."
Invoke-WebRequest -Uri https://raw.githubusercontent.com/ejohnmarlo/dump/main/scripts/wifi_profile.xml -OutFile ~\wifi_profile.xml -UseBasicParsing

Write-Host "Connecting to WiFi..."
netsh wlan delete profile name="Computing Laboratory"
netsh wlan add profile filename=C:\Users\admin\wifi_profile.xml
netsh wlan connect name="Computing Laboratory"

Write-Host "Setting IP Address..."
Set-NetIPInterface -InterfaceAlias "Wi-Fi" -Dhcp Enabled
start-sleep -second 10
Remove-NetIPAddress -InterfaceAlias "Wi-Fi" -Confirm:$false
Remove-NetRoute -InterfaceAlias "Wi-Fi" -Confirm:$false

Write-Host "Enter IP Configuration" -ForegroundColor Green
$ipaddress= Read-Host -Prompt "Enter IP Address"
#$subnet= Read-Host -Prompt "Enter subnet (e.g 24)"
$subnet="24"
#$gateway= Read-Host -Prompt "Enter Gateway Address"
$gateway="10.158.72.1"
New-NetIPAddress -InterfaceAlias "Wi-Fi" -AddressFamily IPv4 $ipaddress -PrefixLength $subnet -Type Unicast -DefaultGateway $gateway
Set-DnsClientServerAddress -InterfaceAlias "Wi-Fi" -ServerAddresses ("10.158.1.56","10.32.1.7")
start-sleep -second 10
#Write-Host "Downloading PGina to C://..."

#Write-Host "Installing OpenSSH..."
#winget install "openssh beta" --source=winget --scope=machine
#choco uninstall openssh
#choco install openssh --params "/ALLUSERS"

Write-Host "Installing OpenSSH-server"
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

New-NetFirewallRule -DisplayName 'Allow NoMachine' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 4000
#Remove-NetFirewallRule -DisplayName 'Allow Nomachine'
New-NetFirewallRule -DisplayName 'Allow SSH' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 22
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
New-NetFirewallRule -DisplayName 'Allow inbound ICMPv4' -Direction Inbound -Protocol ICMPv4 -IcmpType 8 -Action Allow

#Write-Host "Downloading PGina to C://..."
#$filePath="C:\pGinaSetup-3.9.9.12.exe"
#if (-not(Test-Path($filePath)))
#{
#    Write-Host "File does not exist, downloading" -ForegroundColor Yellow
#    Invoke-WebRequest -Uri https://github.com/MutonUfoAI/pgina/releases/download/3.9.9.12/pGinaSetup-3.9.9.12.exe -OutFile $filePath -UseBasicParsing
#}
#Start-Process 'C:\pGinaSetup-3.9.9.12.exe' -Argument '/S /D=C:\Program Files\pGina.fork'

Write-Host "Install PGinaFork"
choco install pginafork

Invoke-WebRequest -Uri https://raw.githubusercontent.com/ejohnmarlo/dump/main/scripts/pginafork.reg -OutFile pginafork.reg -UseBasicParsing
reg import .\pginafork.reg

Write-Host "Install vscode"
choco install vscode --params "/ALLUSERS"

Write-Host "Install vscode"
choco install nomachine


