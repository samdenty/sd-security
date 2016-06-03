@echo off
set currentyear=2015
:setTime
set TwentyFour=%time:~0,5%
if "%TwentyFour:~0,2%" == " 0" set hour=12&set hourtype=AM&goto setDays
if "%TwentyFour:~0,2%" == "01" set hour=1&set hourtype=AM&goto setDays
if "%TwentyFour:~0,2%" == "02" set hour=2&set hourtype=AM&goto setDays
if "%TwentyFour:~0,2%" == "03" set hour=3&set hourtype=AM&goto setDays
if "%TwentyFour:~0,2%" == "04" set hour=4&set hourtype=AM&goto setDays
if "%TwentyFour:~0,2%" == "05" set hour=5&set hourtype=AM&goto setDays
if "%TwentyFour:~0,2%" == "06" set hour=6&set hourtype=AM&goto setDays
if "%TwentyFour:~0,2%" == "07" set hour=7&set hourtype=AM&goto setDays
if "%TwentyFour:~0,2%" == "08" set hour=8&set hourtype=AM&goto setDays
if "%TwentyFour:~0,2%" == "09" set hour=9&set hourtype=AM&goto setDays
if "%TwentyFour:~0,2%" == "10" set hour=10&set hourtype=AM&goto setDays
if "%TwentyFour:~0,2%" == "11" set hour=11&set hourtype=AM&goto setDays
if "%TwentyFour:~0,2%" == "12" set hour=12&set hourtype=PM&goto setDays
if "%TwentyFour:~0,2%" == "13" set hour=1&set hourtype=PM&goto setDays
if "%TwentyFour:~0,2%" == "14" set hour=2&set hourtype=PM&goto setDays
if "%TwentyFour:~0,2%" == "15" set hour=3&set hourtype=PM&goto setDays
if "%TwentyFour:~0,2%" == "16" set hour=4&set hourtype=PM&goto setDays
if "%TwentyFour:~0,2%" == "17" set hour=5&set hourtype=PM&goto setDays
if "%TwentyFour:~0,2%" == "18" set hour=6&set hourtype=PM&goto setDays
if "%TwentyFour:~0,2%" == "19" set hour=7&set hourtype=PM&goto setDays
if "%TwentyFour:~0,2%" == "20" set hour=8&set hourtype=PM&goto setDays
if "%TwentyFour:~0,2%" == "21" set hour=9&set hourtype=PM&goto setDays
if "%TwentyFour:~0,2%" == "22" set hour=10&set hourtype=PM&goto setDays
if "%TwentyFour:~0,2%" == "23" set hour=11&set hourtype=PM&goto setDays
if "%TwentyFour:~0,2%" == "24" set hour=12&set hourtype=PM&goto setDays
:setDays
set Twelve=%hour%:%time:~3,2%%hourtype%
set abbDay=%date:~0,3%
set dayDig=%date:~4,2%
set dayDig2=%date:~5,1%
set dayDig3=%date:~4,1%
set dayDig4=%date:~4,2%
if "%quick%" == "yes" set quick=&goto :EOF
if "%daydig4%" == "04" set daySuffix=th&goto doDays
if "%daydig4%" == "01" set daySuffix=st&goto doDays
if "%daydig4%" == "02" set daySuffix=nd&goto doDays
if "%daydig4%" == "03" set daySuffix=rd&goto doDays
set daySuffix=th
:doDays
set dayNext=TimeAPINext
if "%abbDay%" == "Mon" set day=Monday&goto %dayNext%
if "%abbDay%" == "Tue" set day=Tuesday&goto %dayNext%
if "%abbDay%" == "Wed" set day=Wednesday&goto %dayNext%
if "%abbDay%" == "Thu" set day=Thursday&goto %dayNext%
if "%abbDay%" == "Fri" set day=Friday&goto %dayNext%
if "%abbDay%" == "Sat" set day=Saturday&goto %dayNext%
if "%abbDay%" == "Sun" set day=Sunday&goto %dayNext%
goto TimeAPINext
:reDayDig
set dayDig=%dayDig2%
goto TimeAPINextNext
:TimeAPINext
if "%daydig3%" == "0" goto reDayDig
:TimeAPINextNext
set abbmonth=%date:~7,2%
set monthDig=%abbmonth%
set monthNext=TimeAPINext2
if "%abbmonth%" == "01" set month=January&goto %monthNext%
if "%abbmonth%" == "02" set month=February&goto %monthNext%
if "%abbmonth%" == "03" set month=March&goto %monthNext%
if "%abbmonth%" == "04" set month=April&goto %monthNext%
if "%abbmonth%" == "05" set month=May&goto %monthNext%
if "%abbmonth%" == "06" set month=June&goto %monthNext%
if "%abbmonth%" == "07" set month=July&goto %monthNext%
if "%abbmonth%" == "08" set month=August&goto %monthNext%
if "%abbmonth%" == "09" set month=September&goto %monthNext%
if "%abbmonth%" == "10" set month=October&goto %monthNext%
if "%abbmonth%" == "11" set month=November&goto %monthNext%
if "%abbmonth%" == "12" set month=December&goto %monthNext%
:TimeAPINext2
set year=%currentYear:~0,2%%date:~10,2%
set fulldate=%date:~4,8%
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
pause