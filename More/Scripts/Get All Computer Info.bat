@echo off
net user > "info.txt"
pause
systeminfo > "info.txt"
pause
netsh wlan show all > "info.txt"
pause
netstat -ano > "info.txt"
pause
wmmc product get /format:list > "info.txt"
pause
tasklist /fo list > "info.txt"
pause
sc query > "info.txt"
pause
exit