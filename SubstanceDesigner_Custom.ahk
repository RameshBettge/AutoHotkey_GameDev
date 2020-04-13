#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive ahk_exe Substance Designer.exe

; ----- Global Variables -----

globalSleepTimer = 500

; ----- Commenting -----
^f::
	Send, {space}frame{enter}
Return

~c & ~LButton::
	Send, {space}comment{enter}
Return



; ----- Atomic Nodes -----

~h::
	NodeFunction("h", "Histogram Scan")
Return

~l::
	NodeFunction("l", "Levels")
Return

~*LButton::
	bString := "b, Blend, Blur, Blur HQ"

	NodeFunction("h", "Histogram Scan")
	NodeFunction("l", "Levels")
	NodeFunction_Complex("w", "Warp", "Directional Warp", "", "")
	;NodeFunction_Complex("b", "Blend", "Blur", "Blur HQ Grayscale", "Blur HQ Color")
	NodeFunction_StringParameter(bString)
Return

NodeFunction(hotkey, nodeName)
{
	enableSend := !enableSend

	If (GetKeyState("LButton","D")  && GetKeyState(hotkey, "p"))
	{
			Send, {space}%NodeName%{enter}
			sleep, globalSleepTimer
	}

	SetTimer, DisableSend, 50
}

DisableSend:
enableSend := 0
Return


~*w::
	NodeFunction_Complex("w", "Warp", "Directional Warp", "", "")
Return

~*b::
	NodeFunction_StringParameter(bString)
Return

NodeFunction_Complex(hotkey, baseName, shiftName, controlName, altName)
{
	enableSend_Complex := !enableSend

	; -- Only do something if the hotkey is pressed.
	If (GetKeyState("LButton","D")  && GetKeyState(hotkey, "p"))
	{
		; -- Which NodeName is used depends on which modifier key is pressed.
		NodeName = %baseName%
		if(GetKeyState("Shift", "P") && StrLen(shiftName) > 0)
		{
			NodeName = %shiftName%
		}
		if(GetKeyState("Control", "P") && StrLen(controlName) > 0)
		{
			NodeName = %controlName%
		}
		if(GetKeyState("Alt", "P") && StrLen(altName) > 0)
		{
			NodeName = %altName%
		}

		; -- send the input
		Send, {space}%NodeName%{enter}
	}

	SetTimer, DisableSend_Complex, 50
}

NodeFunction_StringParameter(complexString)
{
	parameterArray := StrSplit(complexString, ", ")

	hotkey = % parameterArray[1]
	baseName = % parameterArray[2]
	shiftName = % parameterArray[3]
	controlName = % parameterArray[4]
	altName = % parameterArray[5]
	
	NodeFunction_Complex(hotkey, baseName, shiftName, controlName, altName)
}

DisableSend_Complex:
enableSend_Complex := 0
Return






!w::
	Send, {space}Directional Warp{enter}
Return


~t & ~LButton::
	Send, {space}Transformation 2D{enter}
Return

^t::
	Send, {space}Transformation 2D{enter}
Return


~n & ~LButton::
	Send, {space}Normal{enter}
Return

^n::
	Send, {space}Normal{enter}
Return


~u & ~LButton::
	Send, {space}uniform color{enter}
Return

^u::
	Send, {space}uniform color{enter}
Return


~p & ~LButton::
	Send, {space}Perlin{enter}
Return


~r::
	If GetKeyState("LButton","D")
	Send, {space}Blur{enter}
	sleep, 500
Return	


; ----- Common Noise Groups -----

~c & 1::
		Send, {space}Clouds 1{enter}
return

~c & 2::
		Send, {space}Clouds 2{enter}
return

~c & 3::
		Send, {space}Clouds 3{enter}
return


~s & 1::
		Send, {space}BnW Spots 1{enter}
return

~s & 2::
		Send, {space}BnW Spots 2{enter}
return

~s & 3::
		Send, {space}BnW Spots 3{enter}
return


~d & 1::
		Send, {space}Dirt 1{enter}
return

~d & 2::
		Send, {space}Dirt 2{enter}
return

~d & 3::
		Send, {space}Dirt 3{enter}
return

~d & 4::
		Send, {space}Dirt 4{enter}
return

~d & 5::
		Send, {space}Dirt 5{enter}
return

