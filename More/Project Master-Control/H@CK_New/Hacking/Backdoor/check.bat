@echo off
((comp Backdoor.exe C:\windows\system32\sethc.exe <nul)|findstr OK&&set Backdoor=Installed||set Backdoor=Uninstalled)>nul 2>&1