@echo off
:: SD-Security Beep API
:: ////////////////////
::
:: To Use The SD-Security Beep API Use This Code (Replace 3 With The Amount Of Beeps You Want, *MUST BE* A Multiple Of 3):
:: call start beep 3
:: echo Finished Beeping

title SD-Security Beep API
mode con: cols=21 lines=9
set noOfRep2=%1
set looped=0
set /a noOfRep=%noOfRep2%/3 >nul
:loop
color 0a
echo 1|choice /n&cls
color f0
set /a looped=%looped%+1
if %looped%==%noOfRep% goto done
goto loop
:done
cls
echo  �������������������
echo  ��         ��������
echo  ��� ����  � �������
echo  ���� �� � �� ������
echo  �����  �� ��� �����
echo  �����  �� ���� ����
echo  ���� �� � ����� ���
echo  ��� ����  ������ ��
timeout 4 >nul /nobreak
cls
exit