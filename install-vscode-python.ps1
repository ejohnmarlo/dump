Write-Host "Installing vscode to all users..."
winget uninstall vscode
winget install vscode --source=winget --scope=machine

Write-Host "Installing Python 3.11 to all users..."
winget uninstall Python.Python.3.11
winget install Python.Python.3.11 --source=winget --scope=machine

Write-Host "Changing Windows permission to allow multi-user access of Python..."
icacls "C:\Program Files\Python311" /grant Users:f /t /q
