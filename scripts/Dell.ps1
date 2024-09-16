Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Host "Setting Timezone..."
Set-TimeZone -Id "Taipei Standard Time"

Write-Host "Sync Time"
net start w32time
start-sleep -second 2
w32tm /resync

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
net user student studentpass /add /expires:never

Write-Host "Add administrator permission..." 
net localgroup administrators student /add

Write-Host "Changing student password..." 
net user student studentpass

Write-Host "Disable popup on install..." 
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0

Write-Host "Disable sleep mode..."
powercfg -change -standby-timeout-ac 0
powercfg -change -standby-timeout-dc 0

Write-Host "Disable turn off screen mode..."
powercfg -change -monitor-timeout-ac 0
powercfg -change -monitor-timeout-dc 0

Write-Host "Install LTSpice"
winget install "AnalogDevices.LTspice" --source=winget --scope=machine

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
