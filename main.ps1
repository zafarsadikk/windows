# Main orchestration script

# Run dependency installer normally
.\install_dependencies.ps1

if ($LASTEXITCODE -ne 0) {
    Write-Host "\nDependency installation failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host "\nSetup completed successfully!" -ForegroundColor Green