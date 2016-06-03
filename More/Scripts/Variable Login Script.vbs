set shellobj = CreateObject("WScript.Shell")
Password2 = InputBox("Enter Password: ", "Enter Password - SD-Security", "default")
If Password2 = "" Then
   Wscript.Quit
Else
    shellobj.run "SD-Security.exe"
    wscript.sleep 200
    shellobj.sendkeys "  2"
    shellobj.sendkeys "{ENTER}"
    shellobj.sendkeys "admin"
    shellobj.sendkeys "{ENTER}"
    shellobj.sendkeys Password2
    shellobj.sendkeys "{ENTER}"
    wscript.sleep 200
End If