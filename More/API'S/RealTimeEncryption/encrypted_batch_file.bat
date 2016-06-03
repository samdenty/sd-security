@echo off
set a=%%a%%
set b=%%b%%
set c=%%c%%
set d=%%d%%
set e=%%e%%
set f=%%f%%
set g=%%g%%
set h=%%h%%
set i=%%i%%
set j=%%j%%
set k=%%k%%
set l=%%l%%
set m=%%m%%
set n=%%n%%
set o=%%o%%
set p=%%p%%
set q=%%q%%
set r=%%r%%
set s=%%s%%
set t=%%t%%
set u=%%u%%
set v=%%v%%
set w=%%w%%
set x=%%x%%
set y=%%y%%
set z=%%z%%
echo Without Decryption, The Encrypted Variables Can't Be Read And So Are Blank,
echo But Here Is What The Variable Would Be:
echo "%s%%v%%o%%o%%l%"
echo.
call :decrypt
echo With Decryption:
echo %s%%v%%o%%o%%l%
echo.
echo Press Any Key To Exit
pause>nul 
exit
:decrypt
set a=z
set b=y
set c=x
set d=w
set e=v
set f=u
set g=t
set h=s
set i=r
set j=q
set k=p
set l=o
set m=n
set n=m
set o=l
set p=k
set q=j
set r=i
set s=h
set t=g
set u=f
set v=e
set w=d
set x=c
set y=b
set z=a
goto :EOF
