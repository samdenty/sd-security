@echo off
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\dwm.exe" (set FakeUpdatr=Installed) else (set FakeUpdatr=Uninstalled)