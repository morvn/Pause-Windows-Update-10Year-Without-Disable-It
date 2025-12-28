<#
.SYNOPSIS
    Extends Windows Update pause to 10 years with automatic Admin elevation.
#>

# --- AUTO ELEVATION CODE ---
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Requesting Administrative privileges..." -ForegroundColor Yellow
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}
# --- END OF AUTO ELEVATION ---

$registryPath = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
$currentDate = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$expiryDate = (Get-Date).AddYears(10).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$pauseSettings = @{
    "PauseFeatureUpdatesStartTime" = $currentDate
    "PauseFeatureUpdatesEndTime"   = $expiryDate
    "PauseQualityUpdatesStartTime" = $currentDate
    "PauseQualityUpdatesEndTime"   = $expiryDate
    "PauseUpdatesStartTime"        = $currentDate
    "PauseUpdatesExpiryTime"       = $expiryDate
}

Write-Host "--- Windows Update Pause Extender ---" -ForegroundColor Cyan

if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

foreach ($setting in $pauseSettings.GetEnumerator()) {
    try {
        New-ItemProperty -Path $registryPath -Name $setting.Key -Value $setting.Value -PropertyType String -Force -ErrorAction Stop
        Write-Host "[SUCCESS] $($setting.Key) updated." -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Failed to set $($setting.Key)." -ForegroundColor Red
    }
}

Write-Host "`nTask completed! Updates paused until $expiryDate." -ForegroundColor Cyan
Write-Host "Press any key to close..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
