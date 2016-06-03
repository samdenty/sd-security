set shellobj = CreateObject("WScript.Shell")
shellobj.run "SD-Security.exe"

wscript.sleep 200

shellobj.sendkeys "  2"
shellobj.sendkeys "{ENTER}"
shellobj.sendkeys "samdenty99"
shellobj.sendkeys "{ENTER}"
shellobj.sendkeys "eebbcafb2550"
shellobj.sendkeys "{ENTER}"
wscript.sleep 200