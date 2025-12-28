<#
.SYNOPSIS
    Extends the Windows Update pause period to 10 years.

.DESCRIPTION
    This script modifies the Windows Registry to set the Windows Update pause duration 
    to 10 years from the current date. it handles cases where the update has not 
    been paused before by creating the necessary registry values.

.NOTES
    Author: YourName/GitHubUsername
    Requires: Administrative Privileges
#>

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

# Ensure the registry path exists
if (!(Test-Path $registryPath)) {
    Write-Host "[*] Creating registry path..." -ForegroundColor Yellow
    New-Item -Path $registryPath -Force | Out-Null
}

# Apply the settings
foreach ($setting in $pauseSettings.GetEnumerator()) {
    try {
        # New-ItemProperty with -Force acts as an "Upsert" (Update or Insert)
        New-ItemProperty -Path $registryPath -Name $setting.Key -Value $setting.Value -PropertyType String -Force -ErrorAction Stop
        Write-Host "[SUCCESS] $($setting.Key) set to 10 years from now." -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Failed to set $($setting.Key). Please run as Administrator." -ForegroundColor Red
    }
}

Write-Host "`nTask completed. Windows Update is now paused until $expiryDate." -ForegroundColor Cyan
Write-Host "Please restart the Settings app to see the changes." -ForegroundColor Gray