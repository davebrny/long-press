/*
[script info]
version     = 1.0.1
description = long press a key to send an alternate symbol or string
author      = davebrny
source      = https://github.com/davebrny/long-press
*/

#noEnv
#singleInstance, force
sendMode input

menu, tray, icon, % a_scriptDir "\long press.ico"
menu, tray, add,
menu, tray, add, Start with Windows, start_with_windows
menu, tray, % fileExist(a_startup "\long press.lnk") ? ("check") : ("unCheck"), Start with Windows

iniRead, press_duration, % a_scriptDir "\settings.ini" , settings, press_duration
iniRead, spam_start,     % a_scriptDir "\settings.ini" , settings, spam_start
iniRead, active_list,    % a_scriptDir "\settings.ini" , settings, active_list

fileRead, file_contents, % a_scriptDir "\" active_list ".ini"    ;# get ini section manually
stringGetPos, pos, file_contents, % "[long press]"
stringMid, ini_section, file_contents, pos + 13

loop, parse, ini_section, `n, `r    ;# get ini key and value
    {
    if (a_loopField = "")
        continue

    occurrence := (inStr(a_loopField, "=", , 1) = 1) ? ("L2") : ("")  ; (if key name is the equals symbol, then L2)
    stringGetPos, pos, a_loopField, =, % occurrence
    stringMid, ini_key, a_loopField, pos, , L
    stringMid, ini_value, a_loopField, pos + 2
    ini_key   := trim(ini_key)
    ini_value := trim(regExReplace(ini_value, "^;.*$|\s+;.*$"))  ; strip comments
    if (ini_value = "")
        continue

    scancode := format("SC{:x}", getKeySC(ini_key))  ; convert key to scancode
    LP_%scancode% := ini_value                       ; save alt key in LP_SC2B
    hotkey, ~%ini_key%, long_press
    }

file_contents := ""
ini_section   := ""

return  ; end of auto-execute ------------------------------------------------







long_press:
stringTrimLeft, key, a_thisHotkey, 1  ; trim ~ symbol
keyWait, % key
if (a_timeSinceThisHotkey > press_duration) and (a_timeSinceThisHotkey < spam_start)
    {
    scancode := "LP_" . format("SC{:x}", getKeySC(key))
    stored_value := %scancode%
    if isLabel(stored_value)
        goSub, % stored_value
    else send, % "{backspace}" . stored_value
    }
return



start_with_windows:     ; tray menu label
if fileExist(a_startup "\long press.lnk")
    fileDelete, % a_startup "\long press.lnk"
else fileCreateShortcut, % a_scriptFullPath, % a_startup "\long press.lnk"
menu, tray, % fileExist(a_startup "\long press.lnk") ? ("check") : ("unCheck"), Start with Windows
return



#include, %a_scriptDir%\commands.ahk