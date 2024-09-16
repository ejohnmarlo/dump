# Clear screen
Clear-Host

Set-ExecutionPolicy Bypass -Scope Process -Force

# Prompt the user for a choice
Write-Host "Which profile would you like to install?" -ForegroundColor Green
Write-Host "(1) HP-Zbook laptop"
Write-Host "(2) Dell"
Write-Host "(s) Shutdown without update"
Write-Host "(r) Restart without update"
$choice = Read-Host -Prompt "Enter choice: "

# Execute the corresponding profile script based on user choice
switch ($choice.ToLower()) {
    '1' {
        Write-Host "Executing HP-Zbook profile (ComputingLaboratory.ps1)..." -ForegroundColor Yellow
        powershell -C "irm https://raw.githubusercontent.com/ejohnmarlo/dump/main/scripts/ComputingLaboratory.ps1 | iex"
        # Call the profile1 script
    }
    '2' {
        Write-Host "Executing Dell profile (Dell.ps1)..." -ForegroundColor Yellow
        powershell -C "irm https://raw.githubusercontent.com/ejohnmarlo/dump/main/scripts/Dell.ps1 | iex"
    }

    's' {
        Write-Host "Shutdown without update..." -ForegroundColor Red
        Start-Sleep -Seconds 5
        shutdown /s /t 0
    }
    
    'r' {
        Write-Host "Restart without update..." -ForegroundColor Red
        Start-Sleep -Seconds 5
        shutdown /r /t 0
    }
    default {
        Write-Host "Invalid choice. Please run the script again and valid choice." -ForegroundColor Red
    }
}
