\# Windows Update Pause Extender (10 Years)



A simple PowerShell script to bypass the default Windows Update pause limit. This script extends the pause duration to \*\*10 years\*\* by modifying the Windows Registry.



\## 🚀 How it Works

Windows usually limits the "Pause Updates" feature to 35 days. This script manually injects a start and end date into the registry, allowing you to stay on your current version without forced updates for a decade.



It targets the following Registry Path:

`HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\WindowsUpdate\\UX\\Settings`



\## 🛠️ Usage

1\. Download `PauseWindowsUpdate10YearWithoutDisableIt.ps1`.

2\. Right-click the file and select \*\*Run with PowerShell\*\*.

3\. \*\*Important:\*\* You must run this script with \*\*Administrative Privileges\*\*.



\## 📝 Features

\- \*\*Auto-Create:\*\* If you haven't paused updates before, the script creates the missing registry keys for you.

\- \*\*UTC Sync:\*\* Uses ISO 8601 (UTC) format to ensure compatibility with Windows system time.

\- \*\*Verbose Output:\*\* Clearly shows which keys were successfully updated.



\## ⚠️ Disclaimer

Registry modifications can affect system behavior. Use this script at your own risk. To resume updates manually, simply go to \*\*Settings > Windows Update\*\* and click "Resume updates".



\## License

MIT

