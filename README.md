# Windows Update Pause Extender (10-Year Duration)

A lightweight PowerShell utility to bypass the default Windows Update pause limitation and extend the pause duration to 10 years from the execution date. The script works by modifying official Windows Update UX registry keys used internally by Windows 10 and Windows 11.

## Overview

Windows 10 and Windows 11 restrict update pauses to a short period of approximately five weeks. This script directly updates Windows Update User Experience settings stored in the system registry to enforce a long-term deferral period without relying on third-party services or background processes.

This tool is intended for systems where update stability is prioritized, including mission-critical environments, bandwidth-limited or metered connections, and development machines where unexpected updates or reboots can interrupt long-running tasks.

## Key Features

- Automatically applies a 10-year pause duration calculated from the execution timestamp.
- Verifies the required registry path and creates it if it does not exist.
- Applies pause settings consistently for Feature Updates, Quality Updates, and the global Windows Update timer.
- Idempotent execution, allowing repeated runs without side effects while refreshing the pause window.

## Technical Details

The script modifies the following Windows Registry path:

    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings

The following registry values of type `REG_SZ` are written using ISO 8601 UTC timestamps:

- `PauseFeatureUpdatesStartTime`
- `PauseFeatureUpdatesEndTime`
- `PauseQualityUpdatesStartTime`
- `PauseQualityUpdatesEndTime`
- `PauseUpdatesStartTime`
- `PauseUpdatesExpiryTime`

These keys are the same values used internally by the Windows Update user interface.

## Installation and Usage

### Manual Execution (Recommended)
1. Download the `PauseWindowsUpdate10YearWithoutDisableIt.ps1` script from this repository.
2. Right-click the file and select **Run with PowerShell**.
3. Confirm the UAC prompt to allow administrative changes.

## Disclaimer

Use this tool at your own risk. Disabling Windows security updates for extended periods can expose systems to known vulnerabilities. This utility is intended for advanced users operating in controlled environments.

## To restore normal update behavior at any time, open **Settings → Windows Update** and select **Resume updates**.
