<#
.SYNOPSIS
    Extends Windows Update pause to 10 years with automatic Admin elevation.
#>

# Pastikan berjalan sebagai Admin
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Elevating privileges..." -ForegroundColor Yellow
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

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

try {
    if (!(Test-Path $registryPath)) { New-Item -Path $registryPath -Force | Out-Null }
    foreach ($setting in $pauseSettings.GetEnumerator()) {
        New-ItemProperty -Path $registryPath -Name $setting.Key -Value $setting.Value -PropertyType String -Force -ErrorAction Stop
        Write-Host "[SUCCESS] $($setting.Key) updated." -ForegroundColor Green
    }
    Write-Host "`nDone! Updates paused until $expiryDate." -ForegroundColor Cyan
} catch {
    Write-Host "`n[ERROR] $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
