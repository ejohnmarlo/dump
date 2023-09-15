
Write-Host "Changing admin password..."
net user admin admin@samsung204

Write-Host "Creating user student..."
net user student studentpass /add

Write-Host "Changing student password..."
net user student studentpass

Write-Host "Disable popup on install..."
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0

Write-Host "Disable sleep mode..."
powercfg -change -standby-timeout-ac 0

Write-Host "Downloading PGina to C://..."
Invoke-WebRequest -Uri https://github.com/MutonUfoAI/pgina/releases/download/3.9.9.12/pGinaSetup-3.9.9.12.exe -OutFile C:\pGinaSetup-3.9.9.12.exe -UseBasicParsing

Write-Host "Installing vscode to all users..."
winget uninstall vscode
winget install vscode --source=winget --scope=machine

Write-Host "Installing Python 3.10 to all users..."
winget uninstall Python.Python.3.10
winget install Python.Python.3.10 --source=winget --scope=machine

Write-Host "Installing Python 3.11 to all users..."
winget uninstall Python.Python.3.11
winget install Python.Python.3.11 --source=winget --scope=machine

Write-Host "Changing Windows permission to allow multi-user access of Python..."
icacls "C:\Program Files\Python310" /grant Users:f /t /q
icacls "C:\Program Files\Python311" /grant Users:f /t /q

Write-Host "Downloading sample Jupyter notebook located at C:\"
Invoke-WebRequest -Uri https://raw.githubusercontent.com/guipsamora/pandas_exercises/master/01_Getting_%26_Knowing_Your_Data/Chipotle/Exercise_with_Solutions.ipynb -OutFile C:\test.ipynb

winget install "openssh beta"

Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

New-NetFirewallRule -DisplayName 'Allow SSH' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 22

#Start-Process 'C:\pGinaSetup-3.9.9.12.exe' -Argument '/S /D=C:\Program Files\pGina.fork'
