@echo off
if exist "C:\Program Files (x86)\netcut\netcut.exe" (set Netcut=Installed) else (if exist "C:\Program Files\netcut\netcut.exe" (set Netcut=Installed) else (set Netcut=Uninstalled))