
; ------------------
; scripted by ryano
; ryano.cf
; ------------------

#SingleInstance, Force
#Persistent
OnExit, Close
#NoEnv
SetBatchLines -1
SetKeyDelay -1

;@Ahk2Exe-SetMainIcon D:\save\selfmade-binders\Hitman-Binder\Hitman-Binder.ico
;@Ahk2Exe-AddResource D:\save\selfmade-binders\Hitman-Binder\Hitman-Binder.ico, 160
;@Ahk2Exe-AddResource D:\save\selfmade-binders\Hitman-Binder\Hitman-Binder.ico, 206
;@Ahk2Exe-AddResource D:\save\selfmade-binders\Hitman-Binder\Hitman-Binder.ico, 207
;@Ahk2Exe-AddResource D:\save\selfmade-binders\Hitman-Binder\Hitman-Binder.ico, 208
;;@Ahk2Exe-SetCompanyName ryano.cc
;;@Ahk2Exe-SetDescription ryano.cc
;;@Ahk2Exe-SetFileVersion 1.9.2.0
;;@Ahk2Exe-SetInternalName ryano.cc
;;@Ahk2Exe-SetCopyright © ryano.cf All rights reserved.
;;@Ahk2Exe-SetOrigFilename Hitman-Binder
;;@Ahk2Exe-SetProductName Hitman-Binder
;;@Ahk2Exe-SetProductVersion 1.9.2.0

SetWorkingDir, %A_ScriptDir%\..

#include udf.ahk

global sampcac_mode := false
global sampdll_base_address := 0
global gta_process := ""
global gta_title := ""
global gta_class := "Grand theft auto San Andreas"
global gta_path := ""
global gta_pid := 0
global gta_folder := ""
global curtime := ""
FormatTime, curtime,, HH:mm:ss tt
global debug := false

if (!A_IsCompiled) {
    debug := true
}

SetTimer, CheckParent, 500
gosub CheckParent
; SetTimer updoot, 100

; Gui,Main: Font, s12, Arial
; Gui,Main: Color, 000000, 111111
; Gui,Main: Add, Text, x10 y10 w290 h30 cWhite +BackgroundTrans va0, Active:`t %activeTitle%
; Gui,Main: Add, Text, x10 y40 w290 h30 cWhite +BackgroundTrans va1, Title:`t %gta_title%
; Gui,Main: Add, Text, x10 y70 w290 h30 cWhite +BackgroundTrans va2, Class:`t %gta_class%
; Gui,Main: Add, Text, x10 y100 w290 h30 cWhite +BackgroundTrans va3, Process:`t %gta_process%
; Gui,Main: Add, Text, x10 y130 w290 h30 cWhite +BackgroundTrans va4, PID:`t %gta_pid%
; Gui,Main: Add, Text, x10 y160 w290 h30 cWhite +BackgroundTrans va5, Path:`t %gta_path%
; Gui,Main: Add, Text, x10 y190 w290 h30 cWhite +BackgroundTrans va6, Folder:`t %gta_folder%
; Gui,Main: Add, Text, x10 y220 w290 h30 cWhite +BackgroundTrans va7, Title:`t %gta_title%
; Gui,Main: Add, Text, x10 y250 w290 h30 cWhite +BackgroundTrans va8, Time:`t %curtime%
; Gui,Main: Add, Text, x10 y280 w290 h30 cWhite +BackgroundTrans va9, hGTA:`t %hGTA%
; Gui,Main: Add, Text, x10 y310 w290 h30 cWhite +BackgroundTrans va10, dwSAMP:`t %dwSAMP%
; Gui,Main: Add, Text, x10 y340 w290 h30 cWhite +BackgroundTrans va11, pMemory:`t %pMemory%
; Gui,Main: Show, center w300 h380, made by ryano

init_sampcac() {
    global
    sampcac_mode := true
    Run *RunAs %A_WorkingDir%\dll\sampcac-loader.exe
    sleep 5000

    FileReadLine, sampdll_base_address, %gta_folder%\samp.dat, 1
}

WinWaitActive, ahk_class %gta_class%

if (sampcac_mode) {
    while (gta_title == "GTA: San Andreas" || gta_title == "") {
        WinGetTitle, gta_title, ahk_class %gta_class%
        sleep 1000
    }
} else {
    while (gta_title != "GTA:SA:MP") {
        WinGetTitle, gta_title, ahk_class %gta_class%
        sleep 1000
    }
}

WinGet, gta_process, ProcessName, ahk_class %gta_class%
WinGet, gta_path, ProcessPath, ahk_class %gta_class%
WinGet, gta_pid, PID, ahk_class %gta_class%
gta_folder := StrReplace(gta_path, gta_process, "", "Off")
Loop, Files, %gta_folder%*, F
{
    if (RegExMatch(A_LoopFileName, "sampcac") && A_LoopFileExt == "asi") {
        msgbox, 0x40044, Loader, sampcac wurde gefunden!`nMöchtest du den Binder im sampcac Modus starten?`n`nSchließ KEINE Konsole! Nur MINIMIEREN :)
        IfMsgBox Yes
            init_sampcac()
    }
}

global activeTitle := ""
while (activeTitle != gta_title) {
    WinGetTitle, activeTitle, A
    sleep 1000
}

#If WinActive(gta_title)

global version := "1.9.2"

FormatTime, day, , dd
FormatTime, month, , M
FormatTime, year, , yyyy
FormatTime, date, , dd.MM.yyyy

#include overlayAPI.ahk

global MAX_UINT := 9223372036854775807

global colors := { "primary": "{5C646C}", "white": "{FFFFFF}" }
global newupdate := false
global chatfile := FileOpen(A_MyDocuments "\GTA San Andreas User Files\SAMP\chatlog.txt", "r")
global chatstarted := true
global chatlines := []
global indeathanim := false
global helm := false
global BlitzerX := [2198.3677, 1353.0272, 1350.3053, 1114.7726, 1406.9188, 2024.5199, 1850.0540, 1454.9109, 1251.9711, 1171.8691, 1130.7673, 762.9991, 325.7093]
global BlitzerY := [-1129.3860, -1101.3154, -1387.0458, -1401.1576, -1732.7809, -1752.1558, -1358.6597, -1316.8529, -1144.4275, -947.1182, -1039.1813, -901.5066, -1706.8066]
global lastzone := "Unbekannt"
global masklabel := false
global auftrag := false
global lawyer_needed := false
global lawyer_needed_command := false
global ballasid := [13, 102, 103, 104, 195, 293]
global gsfid := [65, 86, 105, 106, 107, 149, 269, 270, 271]
global vagosid := [108, 109, 110, 292, 298]
global aztecasid := [114, 115, 116, 156, 173, 174, 175, 176, 177]
global triadenid := [111, 117, 118, 120, 208, 210, 224]
global outlawzid := [19, 30, 47, 48, 184, 234]
global yakuzaid := [122, 123, 169, 186, 203, 204, 228]
global lcnid := [46, 112, 113, 124, 125, 126, 127, 223, 263]
global copid := [265, 266, 267, 280, 281, 282, 283, 284, 285, 286, 288, 300, 301, 302, 306, 307, 309, 310, 311]
global ndid := [40, 247, 248, 254, 261, 291]
global handy := true
global tasered := false
global waffenlager_arr := ["sniper", "m4", "ak-47", "cuntgun", "shotgun", "Schutzweste/HP", "silenced pistol", "bat", "golf club"]
global text_labels := []
global detektiv_interval := [80100, 65100, 40100, 25100, 10100]
global lawyer_interval := [1300, 2000, 2300, 3000, 4800, MAX_UINT]
global overlay_name := ["HP-Overlay", "Armor-Overlay", "Gegner-Overlay", "Vehicle-Overlay", "Pos-Overlay", "Mask-Overlay"]
global overlay_internal_name := ["HP", "A", "G", "V", "O", "D"]
global overlays := { "HP-Overlay": 0, "Armor-Overlay": 0, "Gegner-Overlay": 0, "Vehicle-Overlay": 0, "Pos-Overlay": 0, "Mask-Overlay": 0 }
global chatTriggers := []

statsFolder := [ "statistics", "statistics\old", "statistics\old\01_Januar", "statistics\old\02_Februar", "statistics\old\03_März", "statistics\old\04_April", "statistics\old\05_Mai", "statistics\old\06_Juni", "statistics\old\07_Juli", "statistics\old\08_August", "statistics\old\09_September", "statistics\old\10_Oktober", "statistics\old\11_November", "statistics\old\12_Dezember" ]

for index, element in statsFolder
{
    if (InStr(FileExist(element), "D")) {
        continue
    }

    FileCreateDir, %A_WorkingDir%\%element%
}

SetTimer UpdateData, 500
gosub UpdateData

setupChatWindow()
SetTimer ChatTimer, 100

SetTimer CheckDate, 10000
SetTimer lastzone, 100
SetTimer Helm, 500
SetTimer Tot, 1000
SetTimer Blitzer, 100
SetTimer Verlust, 200
SetTimer tanken, 1500
SetTimer explosiveCheck, 300

Menu, Tray, NoStandard
Menu, Tray, Add, Exit, Close

gosub Start

global started := true
Organizer("Keybinder initialisiert{5C646C}!")
return

#include include\chatlines.ahk
#include include\functions.ahk
#include include\timers.ahk
#include include\textbinds.ahk
#include include\keybinds.ahk