@echo off
echo Uninstalling FakeUpdatr...
attrib -h -s "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\dwm.exe"
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\dwm.exe"
echo Finished!