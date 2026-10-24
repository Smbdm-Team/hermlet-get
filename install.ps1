# SMBDM Agent is now Hermlo. This is the old one-line setup address (https://smbdm-team.github.io/smbdm-agent-get/install.ps1).
# It still works: it downloads Hermlo's one-line setup (https://smbdm-team.github.io/hermlo-get/install.ps1) and runs it with
# the same options, so the old line does exactly what the new one does
# (scripts/publish-get.sh --forwarder). Exit codes (in $LASTEXITCODE) are Hermlo's; 13 = Hermlo's
# setup couldn't be downloaded. It never closes your PowerShell window.
#
# Everything is inside one function, called on the last line: if the download is cut off, nothing runs.

function Install-FromOldLine {
  $new = 'https://smbdm-team.github.io/hermlo-get/install.ps1'
  Write-Host "SMBDM Agent is now Hermlo: running Hermlo's setup. (The new line is: irm $new | iex)" -ForegroundColor Yellow
  try { $s = Invoke-RestMethod -UseBasicParsing -Uri $new } catch { $s = $null }
  if (-not $s) {
    Write-Host "Couldn't download Hermlo's setup from $new. Check the internet connection and try again."
    $global:LASTEXITCODE = 13; return
  }
  & ([scriptblock]::Create([string]$s)) @args
}

Install-FromOldLine @args
