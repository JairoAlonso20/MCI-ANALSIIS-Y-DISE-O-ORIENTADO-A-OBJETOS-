; ======================================
; BOT GEOFs - MAQUINA DE ESTADOS
; ======================================

Global $estado = 0
Global $T_aceleracion, $T_AleronUp, $T_estabilizar, $T_AleronDown, $T_vuelo
Global $T_AleronUp_aterrizaje, $T_AleronDown_aterrizaje, $T_frenado, $T_motorOff

HotKeySet("{1}", "Avion1")
HotKeySet("{2}", "Avion2")
HotKeySet("{3}", "Avion3")
HotKeySet("{ESC}", "Salir")

Run('"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" https://www.geo-fs.com/geofs.php?aircraft=1')


WinWaitActive("[CLASS:Chrome_WidgetWin_1]", "", 20)
Sleep(10000)
MouseClick("left", (@DesktopWidth/2) -200, @DesktopHeight/2, 1)
Sleep(2000)

ConsoleWrite("Presiona 1, 2 o 3 para iniciar vuelo" & @CRLF)

While 1
    Switch $estado

        Case 1 ; ACELERACION
            ConsoleWrite("Estado 1: Acelerando" & @CRLF)
            Send("{NUMPADADD down}")
            Sleep($T_aceleracion)
            $estado = 2

        Case 2 ; ASCENSO
            ConsoleWrite("Estado 2: Ascendiendo" & @CRLF)
            Send("{DOWN down}") ; SUBIR
            Sleep($T_AleronUp)
            Send("{DOWN up}")
            Sleep($T_estabilizar)
            $estado = 3

        Case 3 ; VUELO
            ConsoleWrite("Estado 3: Volando" & @CRLF)
            Sleep($T_vuelo)
            $estado = 4

        Case 4 ; DESCENSO ULTRA SUAVE
			ConsoleWrite("Estado 4: Descenso ultra suave" & @CRLF)

			; Reducir potencia poco a poco
			Send("{NUMPADADD up}")
			Send("{NUMPADSUB down}")
			Sleep(800)
			Send("{NUMPADSUB up}")

			; Descenso en micro-pulsos progresivos
			For $i = 1 To 12

				; Pulsos cada vez más pequeños
				Send("{UP down}")
				Sleep(120 - ($i * 3)) ; cada vez menos agresivo
				Send("{UP up}")

				; Más tiempo de estabilización
				Sleep(700 + ($i * 40))

			Next

			; Último ajuste muy fino antes de aterrizar
			For $j = 1 To 4
				Send("{UP down}")
				Sleep(60)
				Send("{UP up}")
				Sleep(900)
			Next

			$estado = 5

        Case 5 ; FRENADO
            ConsoleWrite("Estado 5: Frenando" & @CRLF)
            Send("{NUMPADADD up}")
            Send("{NUMPADSUB down}")
            Sleep($T_frenado)
            Send("{NUMPADSUB up}")
            Send("{E}") ; Motor off
            ConsoleWrite("Vuelo Finalizado" & @CRLF)
            $estado = 0

    EndSwitch

    Sleep(100)
WEnd


; ================= FUNCIONES =================

Func Avion1()
    CargarConfig("Avion_1")
EndFunc

Func Avion2()
    CargarConfig("Avion_2")
EndFunc

Func Avion3()
    CargarConfig("Avion_3")
EndFunc


Func CargarConfig($seccion)
    $T_aceleracion = IniRead(".\config.ini", $seccion, "T_aceleracion", 20000)
    $T_AleronUp = IniRead(".\config.ini", $seccion, "T_AleronUp", 500)
    $T_estabilizar = IniRead(".\config.ini", $seccion, "T_estabilizar", 5000)
    $T_AleronDown = IniRead(".\config.ini", $seccion, "T_AleronDown", 250)
    $T_vuelo = IniRead(".\config.ini", $seccion, "T_vuelo", 30000)
    $T_AleronUp_aterrizaje = IniRead(".\config.ini", $seccion, "T_AleronUp_aterrizaje", 500)
    $T_AleronDown_aterrizaje = IniRead(".\config.ini", $seccion, "T_AleronDown_aterrizaje", 1000)
    $T_frenado = IniRead(".\config.ini", $seccion, "T_frenado", 2000)
    $T_motorOff = IniRead(".\config.ini", $seccion, "T_motorOff", 50000)

    ConsoleWrite("Configuracion cargada: " & $seccion & @CRLF)
    $estado = 1
EndFunc


Func Salir()
    Exit
EndFunc