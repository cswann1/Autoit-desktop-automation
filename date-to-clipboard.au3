#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\TEMP\Downloads\Note-icon.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <Clipboard.au3>
#include <Date.au3>

; Program creates a date/timed stamped text string on the computers clipboard.
; Program offerss a toggleable confirmation beep
; Format of data in the clipboard:     YY/MM/DD NDUP hhmm CT




Opt("GUIOnEventMode", 1)


GUICreate("Update Message", 250, 90)
GUICtrlCreateButton("Send to Clipboard", 80, 20, 95, 25)
GUICtrlSetOnEvent (-1, "SendButton")
$togglbeep = GUICtrlCreateCheckbox("Confirmation Beep",30, 50, 185, 25)
GUISetOnEvent ($GUI_EVENT_CLOSE, "CLOSEButton")
GUISetState(@SW_SHOW)


Func SendButton ()
   Local $tCur = _Date_Time_GetLocalTime ()     ;gets local time
   $Tstampstring = _Date_Time_SystemTimeToTimeStr ($tCur)  ; places time-stamp in a string
   $Tstampstring = StringTrimRight($Tstampstring,3)   ; strips off the seconds and the clolon between minutes and seconds leaving HH:MM in a string
   $TstampstringHH = StringTrimRight($Tstampstring,3)  ; strips off colon and minutes leaving HH in a string
   $TstampstringMM = StringTrimLeft ($Tstampstring,3)  ; strips off hours and colon leaving MM in a string
   $Dstampstring = _Date_Time_SystemTimeToDateStr ($tCur,1)  ; takes the date in the desired format and places it in a string YYYY/MM/DD
   $Dstampstring = StringTrimLeft($Dstampstring,2)    ; strips the first 2 digits from the year leaving YY/MM/DD
  ClipPut ($Dstampstring & " NDUP " & $TstampstringHH & $TstampstringMM & " CT")  ; places each compontent in the correct order on the clipboard
  If _IsChecked ($togglbeep) then
   Beep(1000, 100)
  Else
	  EndIf
EndFunc

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc

While 1
   Sleep(100)
WEnd

Func CLOSEButton()
   Exit
   EndFunc