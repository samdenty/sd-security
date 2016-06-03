@echo off
set "MskLtr=Enter Password Û: "
set userpaswrd2=-
set userpaswrd=-
goto AdvancedLoginNext2
:AdvancedLoginNext
set MskLtr=%MskLtr%þ>nul
set userpaswrd=%userpaswrd2:~1,254%
cls
:AdvancedLoginNext2
if /I %userpaswrd%==text goto text
if /I %userpaswrd%==cancel goto home
if /I %userpaswrd%==exit goto home
CHOICE /C abcdefghijklmnopqrstuvwxyz1234567890 /N /M "%MskLtr%"
IF ERRORLEVEL 36 set unMskdLstLtr=0&set userpaswrd2=%userpaswrd2%0&goto AdvancedLoginNext
IF ERRORLEVEL 35 set unMskdLstLtr=9&set userpaswrd2=%userpaswrd2%9&goto AdvancedLoginNext
IF ERRORLEVEL 34 set unMskdLstLtr=8&set userpaswrd2=%userpaswrd2%8&goto AdvancedLoginNext
IF ERRORLEVEL 33 set unMskdLstLtr=7&set userpaswrd2=%userpaswrd2%7&goto AdvancedLoginNext
IF ERRORLEVEL 32 set unMskdLstLtr=6&set userpaswrd2=%userpaswrd2%6&goto AdvancedLoginNext
IF ERRORLEVEL 31 set unMskdLstLtr=5&set userpaswrd2=%userpaswrd2%5&goto AdvancedLoginNext
IF ERRORLEVEL 30 set unMskdLstLtr=4&set userpaswrd2=%userpaswrd2%4&goto AdvancedLoginNext
IF ERRORLEVEL 29 set unMskdLstLtr=3&set userpaswrd2=%userpaswrd2%3&goto AdvancedLoginNext
IF ERRORLEVEL 28 set unMskdLstLtr=2&set userpaswrd2=%userpaswrd2%2&goto AdvancedLoginNext
IF ERRORLEVEL 27 set unMskdLstLtr=1&set userpaswrd2=%userpaswrd2%1&goto AdvancedLoginNext
IF ERRORLEVEL 26 set unMskdLstLtr=z&set userpaswrd2=%userpaswrd2%z&goto AdvancedLoginNext
IF ERRORLEVEL 25 set unMskdLstLtr=y&set userpaswrd2=%userpaswrd2%y&goto AdvancedLoginNext
IF ERRORLEVEL 24 set unMskdLstLtr=x&set userpaswrd2=%userpaswrd2%x&goto AdvancedLoginNext
IF ERRORLEVEL 23 set unMskdLstLtr=w&set userpaswrd2=%userpaswrd2%w&goto AdvancedLoginNext
IF ERRORLEVEL 22 set unMskdLstLtr=v&set userpaswrd2=%userpaswrd2%v&goto AdvancedLoginNext
IF ERRORLEVEL 21 set unMskdLstLtr=u&set userpaswrd2=%userpaswrd2%u&goto AdvancedLoginNext
IF ERRORLEVEL 20 set unMskdLstLtr=t&set userpaswrd2=%userpaswrd2%t&goto AdvancedLoginNext
IF ERRORLEVEL 19 set unMskdLstLtr=s&set userpaswrd2=%userpaswrd2%s&goto AdvancedLoginNext
IF ERRORLEVEL 18 set unMskdLstLtr=r&set userpaswrd2=%userpaswrd2%r&goto AdvancedLoginNext
IF ERRORLEVEL 17 set unMskdLstLtr=q&set userpaswrd2=%userpaswrd2%q&goto AdvancedLoginNext
IF ERRORLEVEL 16 set unMskdLstLtr=p&set userpaswrd2=%userpaswrd2%p&goto AdvancedLoginNext
IF ERRORLEVEL 15 set unMskdLstLtr=o&set userpaswrd2=%userpaswrd2%o&goto AdvancedLoginNext
IF ERRORLEVEL 14 set unMskdLstLtr=n&set userpaswrd2=%userpaswrd2%n&goto AdvancedLoginNext
IF ERRORLEVEL 13 set unMskdLstLtr=m&set userpaswrd2=%userpaswrd2%m&goto AdvancedLoginNext
IF ERRORLEVEL 12 set unMskdLstLtr=l&set userpaswrd2=%userpaswrd2%l&goto AdvancedLoginNext
IF ERRORLEVEL 11 set unMskdLstLtr=k&set userpaswrd2=%userpaswrd2%k&goto AdvancedLoginNext
IF ERRORLEVEL 10 set unMskdLstLtr=j&set userpaswrd2=%userpaswrd2%j&goto AdvancedLoginNext
IF ERRORLEVEL 9 set unMskdLstLtr=i&set userpaswrd2=%userpaswrd2%i&goto AdvancedLoginNext
IF ERRORLEVEL 8 set unMskdLstLtr=h&set userpaswrd2=%userpaswrd2%h&goto AdvancedLoginNext
IF ERRORLEVEL 7 set unMskdLstLtr=g&set userpaswrd2=%userpaswrd2%g&goto AdvancedLoginNext
IF ERRORLEVEL 6 set unMskdLstLtr=f&set userpaswrd2=%userpaswrd2%f&goto AdvancedLoginNext
IF ERRORLEVEL 5 set unMskdLstLtr=e&set userpaswrd2=%userpaswrd2%e&goto AdvancedLoginNext
IF ERRORLEVEL 4 set unMskdLstLtr=d&set userpaswrd2=%userpaswrd2%d&goto AdvancedLoginNext
IF ERRORLEVEL 3 set unMskdLstLtr=c&set userpaswrd2=%userpaswrd2%c&goto AdvancedLoginNext
IF ERRORLEVEL 2 set unMskdLstLtr=b&set userpaswrd2=%userpaswrd2%b&goto AdvancedLoginNext
IF ERRORLEVEL 1 set unMskdLstLtr=a&set userpaswrd2=%userpaswrd2%a&goto AdvancedLoginNext
goto AdvancedLoginNext
:cracked
echo YES
pause