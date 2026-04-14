MouseMove(0,0)
MouseMove(@DesktopWidth/2,@DesktopHeight/2,50)
MouseMove(@DesktopWidth,0,50)
MouseClick("left")
MouseClick("left",3,3,1,50)
For $veces = 1 To 10
	MouseMove(@DesktopWidth/Random(1,100),@DesktopHeight/Random(1,100),50)
	Sleep(100)
Next










