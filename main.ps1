# Main orchestration script

# Run dependency installer with elevated privileges
Start-Process powershell -ArgumentList "-File .\install_dependencies.ps1" -Verb RunAs -Wait

# Run GitHub runner setup with elevated privileges
Start-Process powershell -ArgumentList "-File .\setup_github_runner.ps1" -Verb RunAs -Wait

Write-Host "\nSetup completed successfully!" -ForegroundColor Green
Write-Host "Remember to update the GitHub organization, repository, and token in setup_github_runner.ps1" -ForegroundColor Yellow