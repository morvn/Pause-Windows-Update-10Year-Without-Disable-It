# 🛑 Windows Update Pause Extender (10-Year Duration)

> A **lightweight**, **automated** PowerShell utility to bypass Windows’ 35-day update pause limit — extend pause up to **10 years** with a single command.

---

## 📖 Overview

Windows 10/11 limits update pausing to **5 weeks (35 days)** via Settings UI.  
This script **directly edits** the Windows Update UX registry keys to extend deferral *far beyond* that — ideal for:

- 🔒 Mission-critical or air-gapped systems  
- 📉 Metered/limited-bandwidth environments  
- 💻 Dev/test setups sensitive to unexpected reboots  
- 🧪 Controlled lab/education environments

---

## ✨ Key Features

| Feature | Description |
|--------|-------------|
| ⏳ **10-Year Timer** | Sets expiry **exactly 10 years** from execution (`Now + 3652 days`) |
| 🧪 **Safe & Idempotent** | No side effects — rerun anytime to *refresh* timer |
| 🧱 **Auto-Create Keys** | Creates missing registry path/values if needed |
| 🎯 **Full Coverage** | Pauses *Feature*, *Quality*, and *All Updates* uniformly |
| 🪪 **ISO 8601 UTC** | All timestamps use standard `YYYY-MM-DDTHH:MM:SSZ` format |

---

## 🛠️ Technical Specs

- **Registry Hive**: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings`  
- **Values Modified** (REG_SZ):
  - `PauseFeatureUpdatesStartTime` / `EndTime`
  - `PauseQualityUpdatesStartTime` / `EndTime`
  - `PauseUpdatesStartTime` / `PauseUpdatesExpiryTime`

> ✅ All timestamps computed in **UTC** to avoid timezone ambiguity.

---

## 🚀 Quick Start

### 🔧 Prerequisites
- Windows 10 or 11 (x64 recommended)
- **Run PowerShell as Administrator**

## ⚠️ Disclaimer

> 🔥 **Security Risk**: Extending update pause for years *intentionally delays critical security patches*. Systems become vulnerable to known exploits — **especially dangerous on internet-connected or untrusted networks**.

> 🛡️ **Only use in isolated, air-gapped, or tightly controlled environments** (e.g., labs, kiosks, offline dev machines). Never use on domain-joined production endpoints without compensating controls (e.g., network segmentation, EDR, strict firewall rules).

> 🔄 **Resuming updates**:  
> Go to `Settings > Windows Update > Pause updates` and click **"Resume updates"** — this immediately clears the registry pause values.

> 📜 **No warranty**: This tool is provided *"as-is"*. You assume full responsibility for system stability and compliance (e.g., ISO 27001, NIST, internal policy).


