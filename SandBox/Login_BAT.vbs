set shellobj = CreateObject("WScript.Shell")
shellobj.run "SD-Security.bat"

wscript.sleep 500

shellobj.sendkeys "1"
shellobj.sendkeys "{ENTER}"
wscript.sleep 200
shellobj.sendkeys "admin"
shellobj.sendkeys "{ENTER}"
wscript.sleep 100
shellobj.sendkeys "1234"
shellobj.sendkeys "{ENTER}"