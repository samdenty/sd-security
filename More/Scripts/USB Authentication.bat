@echo off
cls
title USB Authentication
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                USB Authentication                %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo                         Please Take Out USB, Then Insert
set "uv1=if exist ""
set "uv2=:\" (set dv"
set "uv3=) else (set dv"
%uv1%A%uv2%A=yes%uv3%A=no)&%uv1%B%uv2%B=yes%uv3%B=no)
%uv1%C%uv2%C=yes%uv3%C=no)&%uv1%D%uv2%D=yes%uv3%D=no)
%uv1%E%uv2%E=yes%uv3%E=no)&%uv1%F%uv2%F=yes%uv3%F=no)
%uv1%G%uv2%G=yes%uv3%G=no)&%uv1%H%uv2%H=yes%uv3%H=no)
%uv1%I%uv2%I=yes%uv3%I=no)&%uv1%J%uv2%J=yes%uv3%J=no)
%uv1%K%uv2%K=yes%uv3%K=no)&%uv1%L%uv2%L=yes%uv3%L=no)
%uv1%M%uv2%M=yes%uv3%M=no)&%uv1%N%uv2%N=yes%uv3%N=no)
%uv1%O%uv2%O=yes%uv3%O=no)&%uv1%P%uv2%P=yes%uv3%P=no)
%uv1%Q%uv2%Q=yes%uv3%Q=no)&%uv1%R%uv2%R=yes%uv3%R=no)
%uv1%S%uv2%S=yes%uv3%S=no)&%uv1%T%uv2%T=yes%uv3%T=no)
%uv1%U%uv2%U=yes%uv3%U=no)&%uv1%V%uv2%V=yes%uv3%V=no)
%uv1%W%uv2%W=yes%uv3%W=no)&%uv1%Y%uv2%Y=yes%uv3%Y=no)
%uv1%Z%uv2%Z=yes%uv3%Z=no)
:CheckForUSBChange
set "uv1=if exist ""
set "uv2=:\" (set dv2"
set "uv3=) else (set dv2"
%uv1%A%uv2%A=yes%uv3%A=no)&%uv1%B%uv2%B=yes%uv3%B=no)
%uv1%C%uv2%C=yes%uv3%C=no)&%uv1%D%uv2%D=yes%uv3%D=no)
%uv1%E%uv2%E=yes%uv3%E=no)&%uv1%F%uv2%F=yes%uv3%F=no)
%uv1%G%uv2%G=yes%uv3%G=no)&%uv1%H%uv2%H=yes%uv3%H=no)
%uv1%I%uv2%I=yes%uv3%I=no)&%uv1%J%uv2%J=yes%uv3%J=no)
%uv1%K%uv2%K=yes%uv3%K=no)&%uv1%L%uv2%L=yes%uv3%L=no)
%uv1%M%uv2%M=yes%uv3%M=no)&%uv1%N%uv2%N=yes%uv3%N=no)
%uv1%O%uv2%O=yes%uv3%O=no)&%uv1%P%uv2%P=yes%uv3%P=no)
%uv1%Q%uv2%Q=yes%uv3%Q=no)&%uv1%R%uv2%R=yes%uv3%R=no)
%uv1%S%uv2%S=yes%uv3%S=no)&%uv1%T%uv2%T=yes%uv3%T=no)
%uv1%U%uv2%U=yes%uv3%U=no)&%uv1%V%uv2%V=yes%uv3%V=no)
%uv1%W%uv2%W=yes%uv3%W=no)&%uv1%Y%uv2%Y=yes%uv3%Y=no)
%uv1%Z%uv2%Z=yes%uv3%Z=no)
if not "%DVA%" == "%DV2A%" set TheDv=A&goto :FoundUSB
if not "%DVB%" == "%DV2B%" set TheDv=B&goto :FoundUSB
if not "%DVC%" == "%DV2C%" set TheDv=C&goto :FoundUSB
if not "%DVD%" == "%DV2D%" set TheDv=D&goto :FoundUSB
if not "%DVE%" == "%DV2E%" set TheDv=E&goto :FoundUSB
if not "%DVF%" == "%DV2F%" set TheDv=F&goto :FoundUSB
if not "%DVG%" == "%DV2G%" set TheDv=G&goto :FoundUSB
if not "%DVH%" == "%DV2H%" set TheDv=H&goto :FoundUSB
if not "%DVI%" == "%DV2I%" set TheDv=I&goto :FoundUSB
if not "%DVJ%" == "%DV2J%" set TheDv=J&goto :FoundUSB
if not "%DVK%" == "%DV2K%" set TheDv=K&goto :FoundUSB
if not "%DVL%" == "%DV2L%" set TheDv=L&goto :FoundUSB
if not "%DVM%" == "%DV2M%" set TheDv=M&goto :FoundUSB
if not "%DVN%" == "%DV2N%" set TheDv=N&goto :FoundUSB
if not "%DVO%" == "%DV2O%" set TheDv=O&goto :FoundUSB
if not "%DVP%" == "%DV2P%" set TheDv=P&goto :FoundUSB
if not "%DVQ%" == "%DV2Q%" set TheDv=Q&goto :FoundUSB
if not "%DVR%" == "%DV2R%" set TheDv=R&goto :FoundUSB
if not "%DVS%" == "%DV2S%" set TheDv=S&goto :FoundUSB
if not "%DVT%" == "%DV2T%" set TheDv=T&goto :FoundUSB
if not "%DVU%" == "%DV2U%" set TheDv=U&goto :FoundUSB
if not "%DVV%" == "%DV2V%" set TheDv=V&goto :FoundUSB
if not "%DVW%" == "%DV2W%" set TheDv=W&goto :FoundUSB
if not "%DVX%" == "%DV2X%" set TheDv=X&goto :FoundUSB
if not "%DVY%" == "%DV2Y%" set TheDv=Y&goto :FoundUSB
if not "%DVZ%" == "%DV2Z%" set TheDv=Z&goto :FoundUSB
goto :CheckForUSBChange
:FoundUSB
set "drive=%theDV%:"
set "localKey=SDS_Files\Last_Key.sds_usb_key"
set "UsbKey=%drive%\SD-Security.sds_usb_key"
if not exist "%UsbKey%" goto setupusb
if not exist "%localKey%" goto nolocalkey
for /F "delims=" %%A in (%UsbKey%) do set "%%A"
for /F "delims=" %%A in (%localKey%) do set "%%A"
if not "%key%" == "%last_key%" goto badKey
goto authByKey
:setupusb
cls
call :CheckStatus Yes "goto :configUSBKey"
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                USB Authentication                %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo     The Current USB Hasn't Been Setup, Would You Like To Setup This Key And
echo                     Replace Your Current Key With This One?
echo.
echo Û1Û  Yes
echo Û2Û  No
%set /p% ReplaceUSB="Ûþ "
if "%ReplaceUSB%" == "1" goto getAuthUSB
goto :home
:getAuthUSB
call :CheckStatus Yes "goto configUSBKey"
goto SignInUSB
:configUSBKey
cls
call :setTime&echo ^|^|Log^|^|  ^|Info: USB Auth Key Updated^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                USB Authentication                %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo                   Configuring USB Drive Authentication Key...
echo.
set "newkey=%random%.%random%,%time%%random%*%random%?%random%#%random%%random%;%random%L%random%J%random%%random%t%random%%random%%errorlevel%"
attrib -a -s -h -r "%UsbKey%">nul 2>&1
del %UsbKey% >nul 2>&1
echo key=%newkey%> "%UsbKey%"
attrib +a +s +h +r "%UsbKey%"
echo last_key=%newkey%> "%LocalKey%"
call :setTime&echo ^|^|Log^|^|  ^|Info: USB Drive Setup^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                USB Authentication                %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo    Drive Successfully Activated, You Can Now Use This Drive To Authenticate
echo                                  SD-Security!
echo.
echo                          Press Any Key To Return Home
timeout 10 >nul
goto home
:nolocalkey
cls
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                USB Authentication                %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo  The Current USB Already Contains A Key, Would You Like To Overwrite This Key?
echo.
echo Û1Û  Yes
echo Û2Û  No
%set /p% EraseKey="Ûþ "
if "%EraseKey%" == "1" goto setupusb
goto home
:badKey
color c4
call :setTime&echo ^|^|Log^|^|  ^|Info: Sign In Failed (USB)^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                USB Authentication                %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo                        ÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛ
echo                        Û Drive Authentication Failed! Û
echo                        ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
echo.
echo                          Press Any Key To Return Home
timeout 10 >nul
goto home
:authByKey
cls
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                USB Authentication                %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo                            ÛßßßßßßßßßßßßßßßßßßßßßßÛ
echo                            Û Drive Authenticated! Û
echo                            ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
echo.
set "newkey=%random%.%random%,%time%%random%*%random%?%random%#%random%%random%;%random%L%random%J%random%%random%t%random%%random%%errorlevel%"
attrib -a -s -h -r "%UsbKey%">nul 2>&1
echo key=%newkey%> "%UsbKey%"
attrib +a +s +h +r "%UsbKey%"
echo last_key=%newkey%> "%LocalKey%"
timeout 2 >nul
goto autologinhack