

	SetWorkingDir %A_ScriptDir%
	P := Minecraft
	WinGetPos, X_MCW, Y_MCW, W_MCW, H_MCW, Minecraft
	#Include, Gdip_all.ahk
	#MaxThreadsperHotkey 2
	#SingleInstance force
	CoordMode, Pixel, screen



	;=========================================================================
	;Menu Section
	MenuColor := "cFF00FF00"
	BoxColor := 0xFF00FF00
	VisColor := "00FF00"
	Vis2Color := "00FF00"
	Colorchoice := [ "cFF0000FF", "cFFFF0000", "cFFFFFF00", "cFF00FFFF", "cFFFF00FF", "cFFFFFFFF", "", "cFF00FF00"]
	Vischoice := [ "0000FF", "FF0000", "FFFF00", "00FFFF", "FF00FF", "FFFFFF", "", "00FF00"]
	BoxChoice := [ "0xFF0000FF", "0xFFFF0000", "0xFFFFFF00", "0xFF00FFFF", "0xFFFF00FF", "0xFFFFFFFF", "Clear", "0xFF00FF00"]
	Vis2choice := [ "0000FF", "FF0000", "FFFF00", "00FFFF", "FF00FF", "FFFFFF", "", "00FF00"]
	CIndex := 0
	BOXIndex := 0
	VIndex := 0
	V2Index := 0
	Offset = 32	
	MySlider = 40
	Sensitivty := MySlider
	nocount := False
	Tri := true
	BobberPos := false
	count=0
	Bsize = 65	
	;=========================================================================




	global G, Font, XF1, YF1, HWBoX, Hwtxt, hdc, GPen, pPen, X_MCW, Y_MCW, W_MCW, H_MCW, Bsize, Var1, count, G1, hdc1, HwTxt1, MenuColor, HwtxtPOS, Sensitivty, Search, MySlider,

	If !pToken := Gdip_Startup()
	{
	    MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
	    ExitApp
	    }
	    OnExit, Exit
		
	    Font = Arial
		
	    If !Gdip_FontFamilyCreate(Font)
	    {
	    MsgBox, 48, Font error!, The font you have specified does not exist on the system
	    ExitApp
	    }
	    OnExit, Exit

	Gui, GDI1: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow + OwnDialogs
	Gui, GDI1: Show, NA
	Hwtxt1 := WinExist()

	Gui, GDI2: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow + OwnDialogs
	Gui, GDI2: Show, NA
	HwtxtPOS := WinExist()

	Gui, GDI: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow + OwnDialogs
	Gui, GDI: Show, NA
	Hwtxt := WinExist()

	Gui, HWBOx: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow + OwnDialogs
	Gui, HWBOx: Show, NA
	HWBoX := WinExist()

	;GUI: +E0x80000 makes this box Invisable to Draw ON!.


	hbm := CreateDIBSection( A_screenwidth, A_screenHeight) ; This creates a graphics area to draw on
	hbm1 := CreateDIBSection( A_screenwidth, A_screenHeight) ; This creates a graphics area to draw on
	hbm2 := CreateDIBSection( A_screenwidth, A_screenHeight) ; This creates a graphics area to draw on


	hdc := CreateCompatibleDC() ; This creates a thing that lets you put the graphics onto the screen
	hdc1 := CreateCompatibleDC() ; This creates a thing that lets you put the graphics onto the screen
	hdc2 := CreateCompatibleDC() ; This creates a thing that lets you put the graphics onto the screen


	obm := SelectObject(hdc, hbm) ; This puts the graphics area onto the thing that lets you draw to the screen
	obm1 := SelectObject(hdc1, hbm1) ; This puts the graphics area onto the thing that lets you draw to the screen
	obm2 := SelectObject(hdc2, hbm2) ; This puts the graphics area onto the thing that lets you draw to the screen


	G := Gdip_GraphicsFromHDC(hdc) ; This gets the thing you use to draw on the graphics area
	G1 := Gdip_GraphicsFromHDC(hdc1) ; This gets the thing you use to draw on the graphics area
	GPen := Gdip_GraphicsFromHDC(hdc2) ; This gets the thing you use to draw on the graphics area

	Script:
	Loop, 99999
				{
					If (toggle)							
					{
						goto Start
					}
					If (WinActive("Minecraft")){
						Clear()
						Gui, GDI: show, NA
						Gui, GDI2: show, NA
						WinGetPos, X_MCW, Y_MCW, W_MCW, H_MCW, Minecraft
						updateGDIP(X_MCW,Y_MCW, W_MCW,H_MCW,"Press Ctrl-K to start Fishing `nPress F11 For Full Screen `nPress Ctrl-P to Kill the Programme")
						IF (BobberPos = True){
							updateGDIPPOS(X_MCW, Y_MCW + H_MCW - 100, W_MCW,H_MCW, "X"XF1-30-X_MCW "Y"YF1-30-Y_MCW "W"Bsize+10 "H"Bsize+10 "X"X_MCW "Y"Y_MCW "W"W_MCW "H"H_MCW "`n" "v:"Var1 "S:"Search "BoxSize:"Bsize "`n" "C:"Count "Offset:"Offset)
						}
						
						
							Gui, HWBOx: Hide
						
						
					}Else{
						
						If (!WinActive("Minecraft")){
							
							Gui, GDI: Hide
							Gui, GDI2: Hide
							Gui, HWBOx: Hide
							
						}
					}
				}
	Goto Script



	;Fishing
	^k::
	Toggle := !Toggle
	Start:
	Clear()

	BobberSearch(X_MCW, Y_MCW, W_MCW, H_MCW)
	If Var1 = 1
	{
		If (!toggle)							
		{
			goto Script
		}
		
		If (nocount = true){
			Count = 1
		}
		
		if count = 2
		{
			WinGetPos, X_MCW, Y_MCW, W_MCW, H_MCW, Minecraft
			updateGDIP(X_MCW,Y_MCW, W_MCW,H_MCW,"Changing Rod's and Recasting")
			IF (BobberPos = True){
				updateGDIPPOS(X_MCW, Y_MCW + H_MCW - 100, W_MCW,H_MCW, "X"XF1-30-X_MCW "Y"YF1-30-Y_MCW "W"Bsize+10 "H"Bsize+10 "X"X_MCW "Y"Y_MCW "W"W_MCW "H"H_MCW "`n" "v:"Var1 "S:"Search "BoxSize:"Bsize "`n" "C:"Count "Offset:"Offset)
			}
			Clear()
			Sleep 300
			Click WheelDown
			Sleep 2000
			Count--
			Goto Start
		}Else{
			BobberSearch(X_MCW, Y_MCW, W_MCW, H_MCW)
			WinGetPos, X_MCW, Y_MCW, W_MCW, H_MCW, Minecraft
			updateGDIP(X_MCW,Y_MCW, W_MCW,H_MCW,"Casting")
			IF (BobberPos = True){
				updateGDIPPOS(X_MCW, Y_MCW + H_MCW - 100, W_MCW,H_MCW, "X"XF1-30-X_MCW "Y"YF1-30-Y_MCW "W"Bsize+10 "H"Bsize+10 "X"X_MCW "Y"Y_MCW "W"W_MCW "H"H_MCW "`n" "v:"Var1 "S:"Search "BoxSize:"Bsize "`n" "C:"Count "Offset:"Offset)
			}
			Clear()
			Sleep 300
			Click Right
			Sleep 2500
			Fished := 2
			count++ 
			Goto Start
		}
		
	}Else
			{
			Var1 = 2
			}
	SearchLoop:			
	Loop  
	{
		if toggle{
			
			If Var1 = 2
			{
				
				If Search = 2	
				{
					pPen := Gdip_CreatePen( BoxColor, 5)
					Clear()
					count=0
					WinGetPos, X_MCW, Y_MCW, W_MCW, H_MCW, Minecraft
					BobberSearch(XF1-Offset, YF1-Offset, Bsize, Bsize)
					updateGDIP(X_MCW,Y_MCW, W_MCW,H_MCW,"Tracking at x: " . XF1 . " y: " . YF1)
					If (Tri = True){
						
						
						
						DrawRectangle(XF1-Offset-X_MCW, YF1-Offset-Y_MCW, Bsize, Bsize, X_MCW, Y_MCW, W_MCW, H_MCW)
						
						
						
					;DrawRectangle(XF1-Offset-X_MCW, YF1-Offset-Y_MCW, Bsize, Bsize, X_MCW, Y_MCW, W_MCW, H_MCW)
					}
					IF (BobberPos = True){
						updateGDIPPOS(X_MCW, Y_MCW + H_MCW - 100, W_MCW,H_MCW, "X"XF1-30-X_MCW "Y"YF1-30-Y_MCW "W"Bsize+10 "H"Bsize+10 "X"X_MCW "Y"Y_MCW "W"W_MCW "H"H_MCW "`n" "v:"Var1 "S:"Search "BoxSize:"Bsize "`n" "C:"Count "Offset:"Offset)
					}
				}Else{ 
					pPen := Gdip_CreatePen( BoxColor, 5)
					Clear()
					WinGetPos, X_MCW, Y_MCW, W_MCW, H_MCW, Minecraft
					BobberSearch(X_MCW, Y_MCW, W_MCW, H_MCW)
					updateGDIP(X_MCW, Y_MCW, W_MCW,H_MCW,"Tracking at x: " . XF1 . " y: " . YF1)
					
					IF (BobberPos = True){
						updateGDIPPOS(X_MCW, Y_MCW + H_MCW - 100, W_MCW,H_MCW, "X"XF1-30-X_MCW "Y"YF1-30-Y_MCW "W"Bsize+10 "H"Bsize+10 "X"X_MCW "Y"Y_MCW "W"W_MCW "H"H_MCW "`n" "v:"Var1 "S:"Search "BoxSize:"Bsize "`n" "C:"Count "Offset:"Offset)
					}
					
				}
				
				
			} ; IF Var1 = 2 End; Searching for Bobber
			Else
			{ ;Check State
				Fished := 1
				IF (Fished = 1){
					Gui, HWBOx: Hide
				}
				Clear()
				Sleep 100
				WinGetPos, X_MCW, Y_MCW, W_MCW, H_MCW, Minecraft
				BobberSearch(XF1-Offset, YF1-Offset, Bsize, Bsize)
				updateGDIP(X_MCW, Y_MCW, W_MCW, H_MCW,"Nibble?" )
				IF (BobberPos = True){
					updateGDIPPOS(X_MCW, Y_MCW + H_MCW - 100, W_MCW,H_MCW, "X"XF1-30-X_MCW "Y"YF1-30-Y_MCW "W"Bsize+10 "H"Bsize+10 "X"X_MCW "Y"Y_MCW "W"W_MCW "H"H_MCW "`n" "v:"Var1 "S:"Search "BoxSize:"Bsize "`n" "C:"Count "Offset:"Offset)
				}
				Clear()	
				If Var1 = 1 ; If we have not seen the bobber after 100MillionSmallseconds **FISH ON!**.
				{
					Fished := 1
					IF (Fished = 1){
						Gui, HWBOx: Hide
					}
					Clear()			
					WinGetPos, X_MCW, Y_MCW, W_MCW, H_MCW, Minecraft
					updateGDIP(X_MCW, Y_MCW, W_MCW, H_MCW,"**FISH ON!**")
					IF (BobberPos = True){
						updateGDIPPOS(X_MCW, Y_MCW + H_MCW - 100, W_MCW,H_MCW, "X"XF1-30-X_MCW "Y"YF1-30-Y_MCW "W"Bsize+10 "H"Bsize+10 "X"X_MCW "Y"Y_MCW "W"W_MCW "H"H_MCW "`n" "v:"Var1 "S:"Search "BoxSize:"Bsize "`n" "C:"Count "Offset:"Offset)
					}
					Click Right
					Sleep 300
					goto Start
				} ; Infinite Loop
			} ;End, Cannot be reached
		}Else{
			Break
		}
	} ; End Reachable by toggle
	 
		
		;XF1-30-X_MCW, YF1-30-Y_MCW, Bsize+10  , Bsize+10
	return


	BobberSearch(X,Y,W,H)
		{
			
			Imagesearch,XF1, YF1, X, Y, X + W, Y + H, *%Sensitivty% %A_ScriptDir%\Bobber_2.PNG
			if ErrorLevel = 2
				MsgBox Could not find the bobber image file.
			else if ErrorLevel = 1
			{
				Fished := 1
				Var1 = 1
				Search = 1
				IF (Fished = 1){
					Gui, HWBOx: Hide
				}
				Return	
			} 
			else
			{
				Search = 2
				Var1 = 2
				Return 
			} 	
		}


	Clear()
		{
		Gdip_GraphicsClear(G)
		Gdip_GraphicsClear(G1)
		Gdip_GraphicsClear(GPen)
		}


	;Update string
	 updateGDIP(X, Y, W, H,string)
	    {

	    {
		PreviousString := String
	    Options = X15 Y30 Near %MenuColor% s20 Underline Italic r4
		Gdip_TextToGraphics(G, String, Options, Font,  W, H)
	    UpdateLayeredWindow(Hwtxt, hdc, X, Y, W, H)
		Gui, GDI: +AlwaysOnTop
		return 
	    }
	    return False
	    }
		

	;Update TestPOS string	
	 updateGDIPPOS(X, Y, W, H, TestPos)
	    {

	    {
		TestPosTest := TestPos
	    OptionsVar = X15 Y0 Near %MenuColor% s20 Underline Italic r4
		Gdip_TextToGraphics(G1, TestPos, OptionsVar, Font,  W , H)
	    UpdateLayeredWindow(Hwtxt1, hdc1, X, Y, W, H)
		Gui, GDI1: +AlwaysOnTop
		return 
	    }
	    return False
	    }
		
		

		
	;DrawRectangle(XF1-30-X_MCW, YF1-30-Y_MCW, Bsize+10  , Bsize+10)
	DrawRectangle(X,Y,W,H,X1,Y1,W1,H1)
	{
		{
			
				
				Gui, HWBOx: Show, NA
				Gui, HWBOx: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow + OwnDialogs
				HWBoX := WinExist()
				Global GPen, hdc2, HWBoX
				
					Gdip_DrawRectangle(GPen, pPen, X,Y,W,H) ; Draw a rectangle on the graphics area using the pen
					UpdateLayeredWindow(HWBoX, hdc2, X1, Y1, W1, H1) ; Draw the graphics area onto the fullscreen window
				
				Gui, HWBoX: +AlwaysOnTop
			
			return 
		}
		return False
	}



	^F4::
	if(nocount) {
		nocount := false
		updateGDIP(X_MCW,Y_MCW, W_MCW,H_MCW,"Rod Change is On")
	} else {
		
		nocount := true
		updateGDIP(X_MCW,Y_MCW, W_MCW,H_MCW,"Rod Change Is Off")
	}
	return

	^F2::
	if(Tri) {
		   Tri := false
			Gui, HWBOx: Hide
			  } else {
		   Tri := true
			Gui, HWBOx: Show
			Clear()
	    }
	return

	;Ctrl+1 This toggles POS Information.
		



	^F1::
	    if(BobberPos) {
		   BobberPos := false
			Gui, GDI1: Hide
			  } else {
		   BobberPos := true
			Gui, GDI1: Show
			Clear()
	    }
	Return

		
		
	;========================================================================================
	;MenuSection
		^Numpad1::
	CIndex := Mod(CIndex, Colorchoice.Length())+1
	VIndex := Mod(VIndex, Vischoice.Length())+1
	MenuColor := Colorchoice[CIndex]
	VisColor := Vischoice[VIndex]
	Guicontrol,, MenuControl, %MenuColor%
	Gui, SlideGUI: Color,, %VisColor% 
	Gui, SlideGUI: Add, Edit, x52 y35 w65 h15 , %MenuColor%
	Return

		^Numpad2::
	BOXIndex := Mod(BOXIndex, BoxChoice.Length())+1
	V2Index := Mod(V2Index, Vis2choice.Length())+1
	BoxColor := BoxChoice[BOXIndex]
	Vis2Color := Vis2choice[V2Index]
	Guicontrol,, MenuBox, %BoxColor%
	Gui, BoxGUI: Color,, %Vis2Color%
	Gui, BoxGUI: Add, Edit, x52 y35 w65 h15 , %BoxColor%
	Return						
			
							
	  
	^o::
	Gui, GDI: submit ,hide	,
	 MenuToggle := !MenuToggle
	 If (!Menutoggle)							
				{
	OptionReturn:
	ifWinExist, Option Menu
	Sleep 50
	OptionMenuOpen := OptionMenuClosed 
	Gui, GDI: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow + OwnDialogs
	Gui, GDI: Show, NA
	Gui, Destroy
	Gui, SlideGUI: Destroy
	Gui, BoxGUI: Destroy
	Return
				}

	  
	{
	BoxVarY := Y_MCW + 95
	BoxVarX := X_MCW + 162
	SlideVarY := Y_MCW + 95
	SlideVarX := X_MCW 
	Gui, Menutext: submit ,hide	
	Gui, +ToolWindow -Caption 
	Gui, +AlwaysOnTop
	Gui, +Resize
	Gui, Add, Text, x22 y10 w120 h30 , Box Size
	Gui, Add, Slider, vBsize gBoxSlide x22 y25 TickInterval10 Range37-150,
	Gui, Add, Text, x184 y10 w120 h30 , Offset
	Gui, add, Slider, vOffset gSlide x184 y25 TickInterval10, 28,
	Gui, SlideGUI: +ToolWindow -Caption 
	Gui, SlideGUI: +AlwaysOnTop
	Gui, SlideGUI: +Resize
	Gui, SlideGUI: Add, Text, x22 y5 w180 h30 , Press Ctrl+NumberPad 1 to 
	Gui, SlideGUI: Add, Text, x22 y20 w180 h30 , change colors of The text
	Gui, SlideGUI: Color,, %VisColor% 
	Gui, SlideGUI: Add, Edit, vMenuControl x52 y35 w65 h15 ,
	Gui, SlideGUI: Show, x%SlideVarX% y%SlideVarY% h50 w161,
	Gui, BoxGUI: +ToolWindow -Caption 
	Gui, BoxGUI: +AlwaysOnTop
	Gui, BoxGUI: +Resize
	Gui, BoxGUI: Add, Text, x22 y5 w180 h30 , Press Ctrl+NumberPad 2 to
	Gui, BoxGUI: Add, Text, x22 y20 w180 h30 , change colors of The BOX
	Gui, BoxGUI: Color,, %Vis2Color%
	Gui, BoxGUI: Add, Edit, vMenuBox x52 y35 w65 h15 ,
	Gui, BoxGUI: Show, x%BoxVarX% y%BoxVarY% h50 w161, 
	Gui_AddPicture("x184 y60 w100 h30",  "FF FF 99" ) ; background
	Gui, Add, Text, xp yp wp hp c000000 gOptionReturn BackgroundTrans Center 0x200 E0x200, Return to Minecraft
	Gui_AddPicture("x22 y60 w70 h30", "FF 00 00" ) ; background
	Gui, Add, Text, xp yp wp hp cFFFFFF gQuitter BackgroundTrans Center 0x200 E0x200, Quit
	Gui, Show, x%X_MCW% y%Y_MCW% h95 w322, Option Menu
	Return 
	}

	Slide:
	GuiControlGet, MySlider
	Return 
	boxSlide:
	GuiControlGet, Sizeslide
	Return	

	;======================================================================



	;=======================================================================
	;Additional Stuff
	;Add Picture to Buttons
	;-------------------------------------------------------------------------------
	Gui_AddPicture(Options, Colour) { ; hex RGB with spaces
	;-------------------------------------------------------------------------------
	    FileName := A_Temp "\" Colour ".bmp"
	    Handle := DllCall("CreateFile", "Str", FileName, "Int", 0x40000000
		   , "Int", 0, "Int", 0, "Int", 4, "Int", 0, "Int", 0)

	    ;---------------------------------------------------------------------------
	    Picture =
	    ;---------------------------------------------------------------------------
		   ( Join LTrim
			  42 4D 3A 00 | 00 00 00 00 | 00 00 36 00 | 00 00 28 00
			  00 00 01 00 | 00 00 01 00 | 00 00 01 00 | 18 00 00 00
			  00 00 04 00 | 00 00 00 00 | 00 00 00 00 | 00 00 00 00
			  00 00 00 00 | 00 00
		   )

	    Picture .= SubStr(Colour, 7, 2)
			  .  SubStr(Colour, 4, 2)
			  .  SubStr(Colour, 1, 2) "00"
	    StringReplace, Picture, Picture, |,, All
	    StringReplace, Picture, Picture, %A_Space%,, All

	    Loop, % StrLen(Picture) // 2 {
		   StringLeft, Hex, Picture, 2
		   StringTrimLeft, Picture, Picture, 2
		   DllCall("WriteFile", "Int", Handle, "CharP", "0x" Hex
			  , "Int", 1, "IntP", BytesWritten, "Int", 0)
	    }
	    DllCall("CloseHandle", "Int", Handle)
	    Gui, Add, Picture, %Options%, %FileName%
	    FileDelete, %FileName%
	}


	#SingleInstance force

	;;; Known issues:
	;;;
	;;; - Weird results for windows with custom decorations such as
	;;; Chrome, or programs with a Ribbon interface.
	;;; - Emacs will be maximized behind instead of in front of
	;;; the taskbar. Workaround: WinHide ahk_class Shell_TrayWnd
	ToggleFakeFullscreen()
	{
	CoordMode Screen, Window
	static WINDOW_STYLE_UNDECORATED := -0xC40000
	static savedInfo := Object() ;; Associative array!
	WinGet, id, ID, A
	if (savedInfo[id])
	{
	inf := savedInfo[id]
	WinSet, Style, % inf["style"], ahk_id %id%
	SysGet, mon, Monitor, %mon%
	Send {ESC}
	WinMove, ahk_id %id%,, % inf["x"], % inf["y"], % inf["width"], % inf["height"]
	Sleep 50
	Send {ESC}
	savedInfo[id] := ""
	}
	else
	{
	savedInfo[id] := inf := Object()
	WinGet, ltmp, Style, A
	inf["style"] := ltmp
	WinGetPos, ltmpX, ltmpY, ltmpWidth, ltmpHeight, ahk_id %id%
	inf["x"] := ltmpX
	inf["y"] := ltmpY
	inf["width"] := ltmpWidth
	inf["height"] := ltmpHeight
	Send {ESC}
	WinSet, Style, %WINDOW_STYLE_UNDECORATED%, ahk_id %id%
	Sleep 50
	Send {ESC}
	mon := GetMonitorActiveWindow()
	SysGet, mon, Monitor, %mon%
	Send {ESC}
	Sleep 10
	WinMove, A,, %monLeft%, %monTop%, monRight - monLeft, monBottom - monTop
	Sleep 10
	Send {ESC}
	}
	}

	GetMonitorAtPos(x,y)
	{
	;; Monitor number at position x,y or -1 if x,y outside monitors.
	SysGet monitorCount, MonitorCount
	i := 0
	while(i < monitorCount)
	{
	SysGet area, Monitor, %i%
	if ( areaLeft <= x && x <= areaRight && areaTop <= y && y <= areaBottom )
	{
	return i MsgBox I
	}
	i := i+1
	}
	return -1 MsgBox -1
	}

	GetMonitorActiveWindow(){
	;; Get Monitor number at the center position of the Active window.
	WinGetPos x,y,width,height, A
	return GetMonitorAtPos(x+width/2, y+height/2)
	}

	F11::ToggleFakeFullscreen()
	;====================================================================


	^p:: ;QUIT
	Quitter:
	Gui, Destroy	
	ExitApp

	GuiClose:
	ExitApp


	Exit:
	Gdip_DeletePen(pPen)
	SelectObject(hdc, obm)
	DeleteObject(hbm)
	DeleteDC(hdc)
	Gdip_DeleteGraphics(G)
	Gdip_DeleteGraphics(G1)
	Gdip_DeleteGraphics(GPen)
	Gdip_Shutdown(pToken)
	ExitApp
	return
	Return
	ExitApp



	^!r::Reload