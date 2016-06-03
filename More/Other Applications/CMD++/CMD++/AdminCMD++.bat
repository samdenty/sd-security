@echo AdminCMD++ Command Client
@if "%~1"=="" echo No command switches detected!&goto :EOF
@<nul set /p = "$ADMINCMD$.Execute*run*&%~1"|clip&echo Successful