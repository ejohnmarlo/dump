# Clear screen
Clear-Host

Set-ExecutionPolicy Bypass -Scope Process -Force

# Prompt the user for a choice
Write-Host "Which profile would you like to install?" -ForegroundColor Green
Write-Host "(a) HP-Zbook laptop"
Write-Host "(b) Dell"
$choice = Read-Host -Prompt "Enter choice [a/b]"

# Execute the corresponding profile script based on user choice
switch ($choice.ToLower()) {
    'a' {
        Write-Host "Executing HP-Zbook profile (profile1.ps1)..." -ForegroundColor Yellow
        powershell -C "irm https://raw.githubusercontent.com/ejohnmarlo/dump/main/scripts/ComputingLaboratory.ps1 | iex"
        # Call the profile1 script
    }
    'b' {
        Write-Host "Executing Dell profile (profile2.ps1)..." -ForegroundColor Yellow
        .\profile2.ps1  # Call the profile2 script
    }
    default {
        Write-Host "Invalid choice. Please run the script again and enter 'a' or 'b'." -ForegroundColor Red
    }
}
