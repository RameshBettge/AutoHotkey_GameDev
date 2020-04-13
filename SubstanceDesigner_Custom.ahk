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

~LButton::
	NodeFunction("h", "Histogram Scan")
	NodeFunction("l", "Levels")
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

; NodeFunction_Complex
; {
; 	enableSend_Complex := !enableSend

; 	If (GetKeyState("LButton","D")  && GetKeyState(hotkey, "p"))
; 	{
; 			Send, {space}%NodeName%{enter}
; 			sleep, globalSleepTimer
; 	}

; 	SetTimer, DisableSend_Complex, 50
; }

; DisableSend_Complex:
; enableSend_Complex := 0
; Return



~w::
	If GetKeyState("LButton","D")
	{
		NodeName = warp
		if(GetKeyState("Shift", "D"))
		{
			NodeName = directionalWarp
		}
		Send, {space}%NodeName%{enter}	
		sleep, 500
	}
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


~b & ~LButton::
	Send, {space}blend{enter}
Return

^b::
	Send, {space}blend{enter}
Return

+^b::
	Send, {space}blur{enter}
Return

!b::
	Send, {space}blur hq grayscale{enter}
Return

+^!b::
	Send, {space}blur hq color{enter}
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

