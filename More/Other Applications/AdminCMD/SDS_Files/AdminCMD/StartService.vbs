Set UAC = CreateObject("Shell.Application")
UAC.ShellExecute """" & WScript.Arguments(0) & """", "ELEV", "", "runas", 0
