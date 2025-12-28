# Windows Update Pause Without Disable It (10-Year Duration)

[![Platform: Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com/windows)
[![Language: PowerShell](https://img.shields.io/badge/Language-PowerShell-blue.svg)](https://github.com/PowerShell/PowerShell)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A PowerShell utility to bypass the default 35-day Windows Update pause limitation and extend the pause duration to **10 years**. This README is designed for direct copy-paste execution without downloading files and without triggering Windows execution policy restrictions.

## Overview

Windows 10 and Windows 11 only allow pausing updates for a short period of approximately five weeks. This method directly modifies Windows Update User Experience registry values so the system recognizes a long-term pause window immediately, preventing forced updates and restarts.

This approach is intended for advanced users managing development machines, test systems, or controlled production environments where update timing must be explicitly controlled.

## How to Apply (Copy-Paste Method)

No file download is required.

1. Press `Win + X` and open **Terminal (Admin)** or **Windows PowerShell (Admin)**.
2. Copy the entire script below.
3. Paste it into the elevated PowerShell window and press **Enter**.

    # --- ⬇️Windows Update 10-Year Pause Script⬇️ ---

<details>
<summary><strong>Copy–Paste This PowerShell Script (Run as Administrator)</strong></summary>

```powershell
# =====================================================
# Windows Update Pause Extender — 10 Years
# Copy & Paste directly into PowerShell (Run as Admin)
# =====================================================

$registryPath = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"

$now    = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$expiry = (Get-Date).AddYears(10).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$values = @{
    "PauseFeatureUpdatesStartTime" = $now
    "PauseFeatureUpdatesEndTime"   = $expiry
    "PauseQualityUpdatesStartTime" = $now
    "PauseQualityUpdatesEndTime"   = $expiry
    "PauseUpdatesStartTime"        = $now
    "PauseUpdatesExpiryTime"       = $expiry
}

if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

foreach ($item in $values.GetEnumerator()) {
    New-ItemProperty `
        -Path $registryPath `
        -Name $item.Key `
        -Value $item.Value `
        -PropertyType String `
        -Force | Out-Null
}

Restart-Service UsoSvc   -Force -ErrorAction SilentlyContinue
Restart-Service wuauserv -Force -ErrorAction SilentlyContinue

Write-Host "Windows Update paused until $expiry"

```

</details>

## Technical Details

The script modifies the following registry path:

    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings

The following `REG_SZ` values are written using ISO 8601 UTC timestamps:

- `PauseFeatureUpdatesStartTime`
- `PauseFeatureUpdatesEndTime`
- `PauseQualityUpdatesStartTime`
- `PauseQualityUpdatesEndTime`
- `PauseUpdatesStartTime`
- `PauseUpdatesExpiryTime`

These values are the same keys used internally by the Windows Update user interface.

## Verification

After execution:

1. Open **Settings > Windows Update**.
2. The status should display updates paused until a date approximately 10 years in the future.
3. If the date does not update visually, click **Pause for 1 week** once to force the UI to re-read the registry values.

## Disclaimer

This script is provided as-is for administrative and educational purposes. Modifying registry values and disabling Windows security updates for extended periods may expose the system to known vulnerabilities. Use only in environments where update management is handled manually and with full awareness of the risks.

## License

This project is licensed under the MIT License.


