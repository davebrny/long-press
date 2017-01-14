example_label:
send {backspace}    ; delete long press input
msgBox, % a_thisLabel
return


delete_previous_word:
if winActive("ahk_class Notepad")
     send ^+{left}{backspace}
else send ^{backspace}
return


delete_next_word:
if winActive("ahk_class Notepad")
     send ^+{right}{backspace}
else send ^{delete}
return


insert_line_before:
send {backspace}    ; delete long press input
send {home}{enter}{up}
return