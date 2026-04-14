;Run("Notepad.exe")
; Sleep(1000)
;;WinWait("Sin título-Notepad")
;Send("Hola mundo"&@CRLF&"Saludos."&@CRLF)

#RequiereAdmin
Run("CMD")
Sleep(1000)
Send("c:"&@CRLF&"cd %temp%"&@CRLF&"del *.tmp"&@CRLF)
