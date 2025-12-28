@echo off
:: Requesting Admin permission and running PowerShell without being blocked by Execution Policy
powershell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dp0Extend-WindowsUpdatePause.ps1""' -Verb RunAs}"