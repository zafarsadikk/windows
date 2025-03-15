# Main orchestration script

# Run dependency installer with elevated privileges
Start-Process powershell -ArgumentList "-File .\install_dependencies.ps1" -Wait


Write-Host "\nSetup completed successfully!" -ForegroundColor Green