#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive ahk_exe Substance Designer.exe

; ----- --- HOW TO --- -----

; to add simple hotkeys, just type in the key followed by :: and the instructions.
; e.g.: 
;		b:: 
;			SOME INSTRUCTIONS
;		Return


; If you want different behavior depending on wether or now modifier keys are pressed down,
; use the function NodeFunction declared at the bottom of this script.

; The easiest way to create a new hotkey is by using the NodeFunction.
; Parameters are as follows: Hotkey, NodeName, ShiftNodeName, ControlNodeName, AltNodeName.
; Only the first two parameters are necessary.
; If in doubt, try to copy an existing hotkey and modify parts of it.




; ----- Commenting -----
^f::
	Send, {space}frame{enter}
Return

~c & ~LButton::
	Send, {space}comment{enter}
Return



; ----- Atomic Nodes -----

~*b::
	NodeFunction("b, Blend, Blur, Blur HQ")
Return

~*h::
	NodeFunction("h, Histogram Scan, Histogram Range")
Return

~*l::
	NodeFunction("l, Levels")
Return

~*w::
	NodeFunction("w, Warp, Directional Warp")
Return

~*t::
	NodeFunction("t, Transform 2D")
Return

~*n::
	NodeFunction("n, Normal, Normal Sobel")
Return

~*u::
	NodeFunction("u, Uniform Color, Normal Color")
Return

~*p::
	NodeFunction("p, Perlin")
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

		Sleep, 500
	}
}

DisableSend:
enableSend := 0
Return