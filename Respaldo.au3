
$Hora_act = @HOUR & ":" & @MIN
$ejecutar = True
$final = True

While $ejecutar = True
	Sleep(1000)
	If @MIN = "00" Then
		RUN ("cmd")
		Sleep(5000)
		Send("C:" & @CRLF & "cd \a" & @CRLF &"DIR > A.txt" & @CRLF & "COPY A.txt .\b\c\d\respaldos" & @CRLF)
		Sleep(1000)
		Send("cd .\b" & @CRLF &"DIR > B.txt" & @CRLF & "COPY B.txt .\c\d\respaldos" & @CRLF)
		Sleep(1000)
		Send("cd .\c" & @CRLF &"DIR > C.txt" & @CRLF & "COPY C.txt .\d\respaldos" & @CRLF)
		Sleep(1000)
		Send("cd .\d" & @CRLF &"DIR > D.txt" & @CRLF & "COPY D.txt .\respaldos" & @CRLF)
		Sleep(1000)
		Send ("cd .\respaldos" & @CRLF & "DIR" & @CRLF)
		$ejecutar = False
	EndIf
WEnd
