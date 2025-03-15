# Requires admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as Administrator!" -ForegroundColor Red
    exit 1
}

# Replace these values with your actual details
$GITHUB_ORG = $env:GITHUB_ORG
if (-not $GITHUB_ORG) { Throw "GITHUB_ORG environment variable not set" }

$GITHUB_REPO = $env:GITHUB_REPO
if (-not $GITHUB_REPO) { Throw "GITHUB_REPO environment variable not set" }

$GITHUB_TOKEN = $env:GITHUB_TOKEN
if (-not $GITHUB_TOKEN) { Throw "GITHUB_TOKEN environment variable not set" }

# Download latest GitHub Actions runner
$RUNNER_VERSION="2.311.0"  # Update to latest version
$RUNNER_URL="https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-win-x64-$RUNNER_VERSION.zip"
$RUNNER_ZIP="$env:TEMP\actions-runner.zip"

Invoke-WebRequest -Uri $RUNNER_URL -OutFile $RUNNER_ZIP

# Extract and configure
Expand-Archive -Path $RUNNER_ZIP -DestinationPath .\runner
cd .\runner

./config.cmd --url "https://github.com/$GITHUB_ORG/$GITHUB_REPO" --token "$GITHUB_TOKEN" --unattended

# Install and start service
./svc install
./svc start