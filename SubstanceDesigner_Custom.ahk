﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive ahk_exe Substance Designer.exe

; ----- --- ! HOW TO USE ! --- -----

; to add simple hotkeys, just type in the key followed by :: and the instructions.
; e.g.: 
;		b:: 
;			SOME INSTRUCTIONS
;		Return


; If you want different behavior depending on wether or now modifier keys are pressed down,
; use the function NodeFunction declared at the bottom of this script.
; Additional calls to the NodeFunction can be added in NodeFunctionCalls.

; Parameters are as follows: Hotkey, NodeName, ShiftNodeName, ControlNodeName, AltNodeName.
; If in doubt, try to copy one existing hotkey and modify parts of it.


SetTimer, NodeFunctionCalls, 5

LastHotkeyUsed = ""

; ----- Atomic Nodes -----
NodeFunctionCalls:

	if(CanAcceptHotkey())
	{
		NodeFunction("b, Blend, Blur, Blur HQ")

		NodeFunction("h, Histogram Scan, Histogram Range")

		NodeFunction("l, Levels")

		NodeFunction("w, Warp, Directional Warp")

		NodeFunction("t, Transform 2D")

		NodeFunction("n, Normal, Normal Sobel")

		NodeFunction("u, Uniform Color, Normal Color")

		NodeFunction("p, Perlin")
	}
Return



; ----- Commenting -----
^f::
	Send, {space}frame{enter}
Return

~c & ~LButton::
	Send, {space}comment{enter}
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



; ----- ----- ----- Functions ----- ----- -----

; Debug Log LastHotkeyUsed
^+t::
	MsgBox %LastHotkeyUsed%
Return


CanAcceptHotkey()
{
	global LastHotkeyUsed
	canAcceptHotkey := true

	; Check if a hotkey had been pressed. For some reason, an empty string is evaluated as '..'
	if(StrLen(LastHotkeyUsed) == 1)
	{
		GetKeyState("b", "p")

		if(!GetKeyState(LastHotkeyUsed, "p"))
		{
			; Hotkey has been released. LastHotkeyUsed-variable is reset.
			LastHotkeyUsed = ""
		}
		else 
		{
			canAcceptHotkey := false
		}
	}

	return canAcceptHotkey
}

NodeFunction(inputString)
{
	; -- parse all inputs
	parameterArray := StrSplit(inputString, ", ")

	hotkey = % parameterArray[1]
	baseName = % parameterArray[2]
	shiftName = % parameterArray[3]
	controlName = % parameterArray[4]
	altName = % parameterArray[5]

	; -- Only do something if the hotkey and the left mouse button are pressed.
	If (GetKeyState("LButton","D")  && GetKeyState(hotkey, "p"))
	{
		; -- Which NodeName is used depends on which modifier key is pressed.
		NodeName = %baseName%
		if(StrLen(shiftName) > 0 && GetKeyState("Shift", "P"))
		{
			NodeName = %shiftName%
		}
		if(StrLen(controlName) > 0 && GetKeyState("Control", "P"))
		{
			NodeName = %controlName%
		}
		if(StrLen(altName) > 0 && GetKeyState("Alt", "P"))
		{
			NodeName = %altName%
		}

		; -- send the input
		Send, {space}%NodeName%{enter}

		; Declare that lastHotkeyUsed references a global variable.
		global LastHotkeyUsed
		LastHotkeyUsed := hotkey
	}
}
