@echo off
echo Uninstalling Keylogger...
taskkill /f /t /im service.exe
if exist "C:\Program Files (x86)\FK_Monitor" attrib -h -s "C:\Program Files (x86)\FK_Monitor"&rd /s /q "C:\Program Files (x86)\FK_Monitor"
if exist "C:\Program Files\FK_Monitor" attrib -h -s "C:\Program Files\FK_Monitor"&rd /s /q "C:\Program Files\FK_Monitor"
echo Finished!