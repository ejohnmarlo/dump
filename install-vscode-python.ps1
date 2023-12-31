Write-Host "Add admin account..."
net user admin admin@samung204 /add

Write-Host "Changing admin password..."
net user admin admin@samsung204

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

Write-Host "Downloading PGina to C://..."
Invoke-WebRequest -Uri https://github.com/MutonUfoAI/pgina/releases/download/3.9.9.12/pGinaSetup-3.9.9.12.exe -OutFile C:\pGinaSetup-3.9.9.12.exe -UseBasicParsing

Write-Host "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Write-Host "Enabling remembered argument for Upgrades on Chocolatey..."
choco feature enable -n='useRememberedArgumentsForUpgrades'

Write-Host "Allow Global confirmation when installing and updating packages..."
choco feature enable -n=allowGlobalConfirmation

Write-Host "Installing vscode to all users..."
#winget uninstall vscode
#winget install vscode --source=winget --scope=machine
choco uninstall vscode
choco install vscode --params "/ALLUSERS"

Write-Host "Installing Python 3.10 to all users..."
#winget uninstall Python.Python.3.10
#winget install Python.Python.3.10 --source=winget --scope=machine
choco uninstall Python310
choco install Python310 --params "/ALLUSERS"

Write-Host "Installing Python 3.11 to all users..."
#winget uninstall Python.Python.3.11
#winget install Python.Python.3.11 --source=winget --scope=machine
choco uninstall Python311
choco install Python311 --params "/ALLUSERS"

Write-Host "Changing Windows permission to allow multi-user access of Python..."
icacls "C:\Program Files\Python310" /grant Users:f /t /q
icacls "C:\Program Files\Python311" /grant Users:f /t /q
icacls "C:\Python310" /grant Users:f /t /q
icacls "C:\Python311" /grant Users:f /t /q

Write-Host "Downloading sample Jupyter notebook located at C:\"
Invoke-WebRequest -Uri https://raw.githubusercontent.com/guipsamora/pandas_exercises/master/01_Getting_%26_Knowing_Your_Data/Chipotle/Exercise_with_Solutions.ipynb -OutFile C:\test.ipynb

Write-Host "Installing OpenSSH..."
#winget install "openssh beta" --source=winget --scope=machine
choco uninstall openssh
choco install openssh --params "/ALLUSERS"

Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

New-NetFirewallRule -DisplayName 'Allow SSH' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 22

#Start-Process 'C:\pGinaSetup-3.9.9.12.exe' -Argument '/S /D=C:\Program Files\pGina.fork'
