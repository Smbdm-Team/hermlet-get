# SMBDM Agent is now Hermlo. This is the old one-line setup address (https://smbdm-team.github.io/smbdm-agent-get/install.ps1):
# it only says which line to paste instead (scripts/publish-get.sh --forwarder), and sets
# $LASTEXITCODE to 1. It never closes your PowerShell window.

function Show-Hermlo {
  $line = 'irm https://smbdm-team.github.io/hermlo-get/install.ps1 | iex'
  $what = 'It moves your SMBDM Agent setup over: same link, same sign-in.'
  if ($args -contains '--uninstall') {
    $line = 'iex "& { $(irm https://smbdm-team.github.io/hermlo-get/install.ps1) } --uninstall"'
    $what = 'It removes SMBDM Agent too.'
  }
  Write-Host 'SMBDM Agent is now Hermlo. Run this instead:' -ForegroundColor Yellow
  Write-Host "  $line"
  Write-Host $what
  $global:LASTEXITCODE = 1
}

Show-Hermlo @args
