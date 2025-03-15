# Install Python 3.10
$pythonUrl = 'https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe'
$pythonInstaller = "$env:TEMP\python-3.10-installer.exe"

Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonInstaller
Start-Process -Wait -FilePath $pythonInstaller -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1' -NoNewWindow

# Install RustDesk
winget install RustDesk.RustDesk

# Verify installations
python --version
rustdesk --version