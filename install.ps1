# Hermlo: one-line setup for your own Windows PC (published at https://smbdm-team.github.io/smbdm-agent-get/install.ps1).
# Open PowerShell (Start menu, type PowerShell, open it) and paste:
#
#   irm https://smbdm-team.github.io/smbdm-agent-get/install.ps1 | iex                              set up, update or repair
#   iex "& { $(irm https://smbdm-team.github.io/smbdm-agent-get/install.ps1) } --uninstall"         remove it
#
# Downloads Hermlo 0.9.1, checks the download is the published one (SHA-256), runs its
# Windows installer with Hermes Agent's own Python (it asks for a username and password), then
# deletes the download. This file holds no secrets. Exit codes (in $LASTEXITCODE) are the
# installer's (team-setup.md); 11-12 are this file's. It never closes your PowerShell window.
# Hermlo used to be called SMBDM Agent: its installer moves an SMBDM Agent install over by itself.
#
# Everything is inside one function, called on the last line: if the download is cut off, nothing runs.

function Install-Hermlo {
  $ErrorActionPreference = 'Stop'
  $ProgressPreference = 'SilentlyContinue'
  $version = '0.9.1'
  $url = if ($env:HERMLO_KIT_URL) { $env:HERMLO_KIT_URL } else { 'https://github.com/Smbdm-Team/smbdm-agent-get/releases/download/v0.9.1/hermlo-kit-0.9.1.zip' }
  $sha = if ($env:HERMLO_KIT_SHA256) { $env:HERMLO_KIT_SHA256 } else { '248b335713f7ce6983a82b61f81e8c8081273b3446699c310fb0ed18a6cc715f' }
  $global:LASTEXITCODE = 0

  if ($env:OS -ne 'Windows_NT') {
    Write-Host 'This line sets Hermlo up on Windows. On a Mac, paste this into Terminal instead:'
    Write-Host '  curl -fsSL https://smbdm-team.github.io/smbdm-agent-get/install | bash'
    $global:LASTEXITCODE = 3; return
  }
  $hh = if ($env:HERMES_HOME) { $env:HERMES_HOME } else { Join-Path $env:LOCALAPPDATA 'hermes' }
  $py = if ($env:HERMES_PY) { $env:HERMES_PY } else { Join-Path $hh 'hermes-agent\venv\Scripts\python.exe' }
  if (-not (Test-Path -LiteralPath $py -PathType Leaf)) {
    Write-Host "STOPPED: Hermes Agent isn't installed on this PC (looked in $hh)." -ForegroundColor Red
    Write-Host 'Install Hermes Agent first, or ask the tech team.'
    $global:LASTEXITCODE = 3; return
  }

  # Windows PowerShell 5.1 may not offer TLS 1.2 by itself; GitHub needs it.
  [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
  Write-Host "Downloading Hermlo $version..."
  $tmp = Join-Path ([IO.Path]::GetTempPath()) ('hermlo-' + [guid]::NewGuid().ToString('N').Substring(0, 8))
  New-Item -ItemType Directory -Path $tmp | Out-Null
  try {
    $zip = Join-Path $tmp 'kit.zip'
    try {
      Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $zip -TimeoutSec 300
    } catch {
      Write-Host "STOPPED: couldn't download Hermlo. Check the internet connection and paste the line again." -ForegroundColor Red
      $global:LASTEXITCODE = 11; return
    }
    $got = (Get-FileHash -Algorithm SHA256 -LiteralPath $zip).Hash.ToLowerInvariant()
    if ($got -ne $sha.ToLowerInvariant()) {
      Write-Host "STOPPED: the download isn't the published Hermlo (its checksum doesn't match), so it" -ForegroundColor Red
      Write-Host "wasn't run. Paste the line again; if it happens again, tell the tech team."
      $global:LASTEXITCODE = 12; return
    }
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $kit = Join-Path $tmp 'kit'
    [IO.Compression.ZipFile]::ExtractToDirectory($zip, $kit)
    $inst = Get-ChildItem -LiteralPath $kit -Directory |
      ForEach-Object { Join-Path $_.FullName 'scripts\windows\install.py' } |
      Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } | Select-Object -First 1
    if (-not $inst) {
      Write-Host 'STOPPED: the download has no Windows installer in it. Tell the tech team.' -ForegroundColor Red
      $global:LASTEXITCODE = 12; return
    }
    # Not captured, so the installer talks to this window directly (its questions show at once).
    & $py $inst @args
    $code = $LASTEXITCODE
    $global:LASTEXITCODE = $code
  } finally {
    Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
  }
}

Install-Hermlo @args
