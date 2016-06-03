@echo off
echo Uninstalling Backdoor...
taskkill /f /im sethc.exe
copy /Y C:\Windows\system32\sethc.exe C:\Windows\system32\sethc_patched.exe
del /F "C:\Windows\system32\sethc.exe"
copy /Y C:\Windows\system32\sethc2.exe C:\Windows\system32\sethc.exe
echo Finished!