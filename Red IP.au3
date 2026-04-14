; 1. Obtener IP completa y el segmento
Local $miIP = @IPAddress1
Local $segmento = StringLeft($miIP, StringInStr($miIP, ".", 0, -1))

; 2. Extraer el último número (donde empieza el ciclo)
Local $inicio = Int(StringTrimLeft($miIP, StringInStr($miIP, ".", 0, -1)))

; 3. Abrir CMD y preparar
Run("cmd.exe")
WinWaitActive("[CLASS:ConsoleWindowClass]")
Send("cls && ipconfig && echo Tu IP es: " & $miIP & " && echo Escaneando desde ." & $inicio & " hasta .255... && echo ------------------" & @CRLF)

Local $activos = 0

; 4. Ciclo desde TU IP hasta el final (255)
For $i = $inicio To 255
    Local $ip = $segmento & $i

    If Ping($ip, 250) Then
        $activos += 1
        Send("echo [+] " & $ip & " - ACTIVA" & @CRLF)
    Else
        Send("echo [-] " & $ip & " - inactiva" & @CRLF)
    EndIf
Next

; 5. Resultado
Send("echo ------------------ && echo Escaneo terminado. Total activos: " & $activos & @CRLF)