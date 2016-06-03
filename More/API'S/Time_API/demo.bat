@echo off
set currentyear=2015
:setTime
for /f "tokens=1-2 delims=:." %%a in ('time /t') do set hourTwentyFour=%%a&set Minutes=%%b
set TwentyFour=%hourTwentyFour%:%minutes%
if "%hourTwentyFour%" == "0" set hour=12&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "01" set hour=1&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "02" set hour=2&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "03" set hour=3&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "04" set hour=4&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "05" set hour=5&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "06" set hour=6&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "07" set hour=7&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "08" set hour=8&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "09" set hour=9&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "10" set hour=10&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "11" set hour=11&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "12" set hour=12&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "13" set hour=1&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "14" set hour=2&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "15" set hour=3&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "16" set hour=4&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "17" set hour=5&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "18" set hour=6&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "19" set hour=7&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "20" set hour=8&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "21" set hour=9&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "22" set hour=10&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "23" set hour=11&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "24" set hour=12&set hourtype=PM&goto SetTwelveHourTime
:SetTwelveHourTime
set Twelve=%hour%:%minutes%%hourtype%
:SetDays
set abbOfDay=%date:~0,3%
for /f "tokens=2-3 delims=/ " %%a in ('date /t') do set daydig=%%a&set MonthDig=%%b&set year=%currentYear:~0,2%%date:~-2%
if "%daydig:~0,1%" == "0" set daydig=%daydig:~1,1%
if "%MonthDig:~0,1%" == "0" set MonthDig=%MonthDig:~1,1%
if "%daydig%" == "1" set daySuffix=st&goto SetDayNames
if "%daydig%" == "2" set daySuffix=nd&goto SetDayNames
if "%daydig%" == "3" set daySuffix=rd&goto SetDayNames
set daySuffix=th
:SetDayNames
if "%abbOfDay%" == "Mon" set day=Monday&goto SetMonthNames
if "%abbOfDay%" == "Tue" set day=Tuesday&goto SetMonthNames
if "%abbOfDay%" == "Wed" set day=Wednesday&goto SetMonthNames
if "%abbOfDay%" == "Thu" set day=Thursday&goto SetMonthNames
if "%abbOfDay%" == "Fri" set day=Friday&goto SetMonthNames
if "%abbOfDay%" == "Sat" set day=Saturday&goto SetMonthNames
if "%abbOfDay%" == "Sun" set day=Sunday&goto SetMonthNames
:SetMonthNames
if "%MonthDig%" == "1" set month=January&goto SetTimeFinished
if "%MonthDig%" == "2" set month=February&goto SetTimeFinished
if "%MonthDig%" == "3" set month=March&goto SetTimeFinished
if "%MonthDig%" == "4" set month=April&goto SetTimeFinished
if "%MonthDig%" == "5" set month=May&goto SetTimeFinished
if "%MonthDig%" == "6" set month=June&goto SetTimeFinished
if "%MonthDig%" == "7" set month=July&goto SetTimeFinished
if "%MonthDig%" == "8" set month=August&goto SetTimeFinished
if "%MonthDig%" == "9" set month=September&goto SetTimeFinished
if "%MonthDig%" == "10" set month=October&goto SetTimeFinished
if "%MonthDig%" == "11" set month=November&goto SetTimeFinished
if "%MonthDig%" == "12" set month=December&goto SetTimeFinished
:SetTimeFinished
set fulldate=%date:~4%
set date2=%daydig%/%monthDig%/%year%
:: goto :EOF
echo Day Digit  : %dayDig%
echo Day Text   : %day%
echo Month Text : %month%
echo Month Digit: %monthDig%
echo Year       : %year%
echo Normal Date: %fullDate%
echo Styled Date: %date2%
echo Text Date  : %day% The %daydig%%daySuffix% Of %month% %year%
echo 12 Hour    : %Twelve%
echo 24 Hour    : %TwentyFour%
echo Hour (12)  : %hour%
echo Hour (24)  : %hourTwentyFour%
echo Minutes    : %minutes%
echo Hour Type  : %hourtype%
pause