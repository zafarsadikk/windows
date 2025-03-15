# Install Python 3.10
$pythonUrl = 'https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe'
$pythonInstaller = "$env:TEMP\python-3.10-installer.exe"

try {
    Write-Host "Downloading Python installer..."
    Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonInstaller -ErrorAction Stop
    Write-Host "Download completed successfully"
}
catch {
    Write-Error "Failed to download Python installer: $_"
    exit 1
}

Start-Process -Wait -FilePath $pythonInstaller -ArgumentList '/quiet InstallAllUsers=0 PrependPath=1'

# Install RustDesk via direct download
try {
    $rustdeskUrl = 'https://github.com/rustdesk/rustdesk/releases/download/1.2.3/rustdesk-1.2.3-x86_64.exe'
    $rustdeskInstaller = "$env:TEMP\rustdesk-installer.exe"
    
    Write-Host "Downloading RustDesk installer..."
    Invoke-WebRequest -Uri $rustdeskUrl -OutFile $rustdeskInstaller -ErrorAction Stop
    
    Write-Host "Installing RustDesk..."
    Start-Process -Wait -FilePath $rustdeskInstaller -ArgumentList '/S' -ErrorAction Stop
    
    # Verify installation
    $rustdeskPath = Join-Path $env:LOCALAPPDATA 'RustDesk\rustdesk.exe'
    if (-not (Test-Path $rustdeskPath)) {
        throw "RustDesk executable not found at $rustdeskPath"
    }
}
catch {
    Write-Error "Failed to install RustDesk: $_"
    exit 1
}

# Final verification
python --version
if ($LASTEXITCODE -ne 0) {
    Write-Host "`nSetup failed with errors!" -ForegroundColor Red
    exit 1
}

Write-Host "`nSetup completed successfully!" -ForegroundColor Green