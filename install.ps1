$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
  throw "npm is required but was not found in PATH."
}

if (Get-Command winget -ErrorAction SilentlyContinue) {
  winget install --id Google.Chrome --exact --silent --accept-package-agreements --accept-source-agreements
  winget install --id Microsoft.VCRedist.2015+.x64 --exact --silent --accept-package-agreements --accept-source-agreements
} else {
  Write-Host "winget was not found. Install Google Chrome and Microsoft Visual C++ Redistributable manually."
}

npx puppeteer browsers install chrome
Write-Host "Puppeteer prerequisites installed successfully."
