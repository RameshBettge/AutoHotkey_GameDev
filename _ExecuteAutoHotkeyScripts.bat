@Echo Off
title ExecuteAutoKotkeyScripts
rem This script executes all .ahk in current directory.
rem HOW TO USE:  just put a shortcut into the windows startup folder to automatically enable all shortcuts on bootup.

rem rem is used to create comments
rem echo is used to print out something.
rem Pause is used to pause the script so the prints can be read.

rem following Line searches for all.ahk in current directory and executes them.
for /r %%x in (*.ahk) do start %%x

