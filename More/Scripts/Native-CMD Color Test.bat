@Echo off
color f7
set fullLine='''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
set thirdLine=''''''''''''''''''''''
set a='
set b=''
set c=call :color
%c% 07 %fullLine%
%c% 11 %fullLine%
%c% 22 %fullLine%
%c% 33 %fullLine%
%c% 44 %fullLine%
%c% 55 %fullLine%
%c% 66 %fullLine%
%c% 77 %fullLine%
%c% 88 %fullLine%
%c% 99 %fullLine%
%c% aa %fullLine%
%c% bb %fullLine%
%c% cc %fullLine%
%c% dd %fullLine%
%c% ee %fullLine%
%c% ff %fullLine%
%c% 07 %a%
%c% 11 %a%
%c% 22 %a%
%c% 33 %a%
%c% 44 %a%
%c% 55 %a%
%c% 66 %a%
%c% 77 %a%
%c% 88 %a%
%c% 99 %a%
%c% aa %a%
%c% bb %a%
%c% cc %a%
%c% dd %a%
%c% ee %a%
%c% ff %a%



pause >nul
exit
:Color
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & for %%b in (1) do rem"') do (set "DEL=%%a")
pushd %temp%
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
popd
goto :EOF