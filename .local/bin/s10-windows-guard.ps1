# S10 Windows guard — run ONCE in Windows as Administrator:
#   mountvol S: /S ; powershell -ExecutionPolicy Bypass -File S:\s10-windows-guard.ps1 ; mountvol S: /D
# 1) turns off Fast Startup/hibernation (it corrupts the shared EFI partition)
# 2) installs a startup task that keeps "Linux Boot Manager" first in the firmware boot order,
#    so Windows updates can never hide Arch again.
powercfg /h off
$order = (bcdedit /enum '{fwbootmgr}' | Select-String 'displayorder|^\s+\{') -replace '^\s*displayorder\s*','' | ForEach-Object { $_.Trim() }
$fw = (bcdedit /enum firmware) -join "`n"
$linuxId = $null
foreach ($id in $order) {
  $blk = ($fw -split "(?m)^-+$") | Where-Object { $_ -match [regex]::Escape($id) -and $_ -match 'description\s+Linux Boot Manager' }
  if ($blk) { $linuxId = $id; break }
}
if (-not $linuxId) { Write-Host "Linux Boot Manager not found in boot order — tell Claude." -ForegroundColor Red; exit 1 }
bcdedit /set '{fwbootmgr}' displayorder $linuxId /addfirst | Out-Null
schtasks /create /tn "S10 keep Linux first" /sc onstart /ru SYSTEM /rl HIGHEST /f /tr "bcdedit /set {fwbootmgr} displayorder $linuxId /addfirst" | Out-Null
Write-Host "Done: Fast Startup OFF, Linux ($linuxId) first, guard task installed." -ForegroundColor Green
