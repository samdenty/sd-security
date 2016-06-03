#include <GuiConstantsEx.au3>
#include <Constants.au3>
#NoTrayIcon
GUICreate("AdminCMD API", 200, 100)
GUICtrlCreateLabel("AdminCMD API for SD-Security", 27, 15)
GUICtrlCreateLabel("Software by SD-Storage", 43, 28)
$FilePath = @ScriptDir
$CMD = Run(@ComSpec & " /c " & 'tasklist /NH /FI "WINDOWTITLE eq Administrator:  @AdminCMD:Auth:@"|findstr /V /B /C:"INFO:">nul 2>&1&&echo Active', $FilePath, @SW_HIDE, $STDOUT_CHILD)
ProcessWaitClose($CMD)
$CMDOutput = StdoutRead($CMD)
If StringInStr($CMDOutput, "Active") Then
$switch = GUICtrlCreateButton("Deactivate Background Service", 20, 55, 160, 35)
Else
$switch = GUICtrlCreateButton("Activate Background Service", 20, 55, 160, 35)
EndIf
GUISetState()
While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            ExitLoop
        Case $switch
            switchButton()
    EndSwitch
 WEnd
GUIDelete()
Exit
Func switchButton ()
    Switch GUICtrlRead($switch)
        Case "Activate Background Service"
			ProgressOn("Activating...", "Starting Background Service...", "0%")
			$CMD = 'start AdminCMD.exe'
			For $i = 0 To 50 Step 25
			Sleep(4)
			ProgressSet($i, $i & "%")
			Next
			RunWait(@ComSpec & " /c " & $CMD, "", @SW_HIDE)
			GUICtrlSetData($switch, "Deactivate Background Service")
			For $i = 50 To 100 Step 25
			Sleep(4)
			ProgressSet($i, $i & "%")
			Next
			ProgressSet(100, "Activated Successfully", "AdminCMD is Activate")
			Sleep(1500)
			ProgressOff()
        Case "Deactivate Background Service"
			$CMD = 'echo.>"%Temp%\KillAdminCMD.ini"'
			RunWait(@ComSpec & " /c " & $CMD, "", @SW_HIDE)
			GUICtrlSetData($switch, "Activate Background Service")
    EndSwitch
EndFunc