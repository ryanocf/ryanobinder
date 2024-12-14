updoot:
    FormatTime, curtime,, HH:mm:ss tt
    GuiControl, Main:, a0, Active:`t %activeTitle%
    GuiControl, Main:, a1, Title:`t %gta_title%
    GuiControl, Main:, a2, Class:`t %gta_class%
    GuiControl, Main:, a3, Process:`t %gta_process%
    GuiControl, Main:, a4, PID:`t %gta_pid%
    GuiControl, Main:, a5, Path:`t %gta_path%
    GuiControl, Main:, a6, Folder:`t %gta_folder%
    GuiControl, Main:, a7, Title:`t %gta_title%
    GuiControl, Main:, a8, Time:`t %curtime%
    GuiControl, Main:, a9, hGTA:`t %hGTA%
    GuiControl, Main:, a10, dwSAMP:`t %dwSAMP%
    GuiControl, Main:, a11, pMemory:`t %pMemory%
return

CheckParent:
    if (debug) {
        return
    }

    processes := GetProcessList()
    binder := false
    gta := false
    for index, element in processes
    {
        if (RegExMatch(element, "^ryanobinder v\d+\.\d+.\d+(-alpha|-beta)*.exe$") || element == "neutralino-win_x64.exe") {
            binder := true
        }

        if (element == "gta_sa.exe") {
            gta := true
        }
    }

    if (!binder || !gta) {
        SoundBeep
        SoundBeep
        goto Close
    }
return

UpdateData:
    if (OverlayMove) {
        return
    }

    keybindsLoad()
    optionsLoad()
    weaponpackLoad()
    gegnerLoad()
    overlayLoad()
return
    
Start:
    if (!updateTextLabelData()) {
        sleep 200
        goto Start
        return
    }
    credits =
    (LTrim
    {5C646C}__________[Hitman-Binder]__________{FFFFFF}
    {FFFFFF}
    Danke an alle die dabei waren.
    Lucas - Marlon - Marco - Anthony
    Valmir - Kaan - Kaan II - Momo
    Mert - Nico - Ferhat - Luran
    {5C646C}___________________________________{FFFFFF}
    Special thanks an Urs für die Idee.
    )
    for key, value in oTextLabelData
    {
        if (InStr(value.TEXT, "[Hitman-Binder]"))
            text_labels.Push(value)
    }
    for key, value in text_labels
    {
        deleteTextLabel(value)
    }
    text_label_id := createTextLabel(credits, 0xFFFFFFFF, 1481.0367, -1751.7877, 16.0000, 10.0, 0)
    text_labels.Push(text_label_id)
return

Close:
    DestroyAllVisual()
    deleteTextDraw(Overlay_HPdraw)
    deleteTextDraw(Overlay_Armordraw)
    for key, value in text_labels
    {
        deleteTextLabel(value)
    }
    ExitApp
return

InitOverlay:
    if (!WinActive(gta_title)) {
        return
    }

    if (!ov_hModule) {
        StartOverlay()
    }

    SetParam("use_window", "1")
    SetParam("window", gta_title)

    if (OverlayAktiv == true || OverlayOn == true) {
        return
    }
    DestroyAllVisual()
    deleteTextDraw(Overlay_HPdraw)
    deleteTextDraw(Overlay_Armordraw)
    if (HPC == true) {
        if (textdraws == true) {
            Overlay_HPdraw := createTextDraw("~w~" . GetPlayerHealth(), HPX, HPY, 0xFFFFFFFF, 1, HPSize / 10, (HPSize / 10) * 3)
        } else {
            overlays["HP-Overlay"] := TextCreate(HPFont, HPSize, 1, 0, HPX, HPY, 0xFF "" HPF, "", 1, 1)
        }
    }
    if (AC == true) {
        if (textdraws == true) {
            Overlay_Armordraw := createTextDraw("~w~" . GetPlayerArmor(), AX, AY, 0xFFFFFFFF, 1, ASize / 10, (ASize / 10) * 3)
        } else {
            overlays["Armor-Overlay"] := TextCreate(AFont, ASize, 1, 0, AX, AY, 0xFF "" AF, "", 1, 1)
        }
    }
    ; if (GC == true) {
    ;     overlays["Gegner-Overlay"] := TextCreate(GFont, GSize, 1, 0, GX, GY, 0xFF "" GF, "Loading...",1 ,1)
    ; }
    if (VC == true) {
        overlays["Vehicle-Overlay"] := TextCreate(VFont, VSize, 1, 0, VX, VY, 0xFF "" VF, "", 1, 1)
    }
    if (OC == true) {
        overlays["Pos-Overlay"] := TextCreate(OFont, OSize, 1, 0, OX, OY, 0xFF "" OF, "", 1, 1)
    }
    if (MC == true) {
        overlays["Mask-Overlay"] := TextCreate(MFont, MSize, 1, 0, MX, MY, 0xFF "" MF, "", 1, 1)
    }
    OverlayAktiv := True
    OverlayOn := True
return

OverlayTimer:    
    if (!WinActive(gta_title)) {
        if (OverlayAktiv) {
            DestroyAllVisual()
            OverlayAktiv := false
            OverlayOn := false
        }
    } else {
        if (!OverlayAktiv) {
            gosub, InitOverlay
            return
        }
        if (HPC == true) {
            if (textdraws == true) {
                if (getPlayerHealth() < 0 OR getPlayerHealth() > 200) {
                    updateTextDraw(Overlay_HPdraw, "~w~100")
                } else {
                    updateTextDraw(Overlay_HPdraw, "~w~" . getPlayerHealth())
                }
            } else {
                if (getPlayerHealth() < 0 OR getPlayerHealth() > 200) {
                    TextSetString(overlays["HP-Overlay"], "HP: " getPlayerHealth() " | ID: " getId() " | Ping: " getPlayerPingById(getId()) " | Hit: -")
                } else {
                    if ((getPlayerHealth() + getPlayerArmor()) <= 46) {
                        hit := 1
                    }
                    else if ((getPlayerHealth() + getPlayerArmor()) <= 92) {
                        hit := 2
                    }
                    else if ((getPlayerHealth() + getPlayerArmor()) <= 138) {
                        hit := 3
                    }
                    else if ((getPlayerHealth() + getPlayerArmor()) <= 184) {
                        hit := 4
                    }
                    else if ((getPlayerHealth() + getPlayerArmor()) <= 230) {
                        hit := 5
                    }
                    TextSetString(overlays["HP-Overlay"], "HP: " getPlayerHealth() " | ID: " getId() " | Ping: " getPlayerPingById(getId()) " | Hit: " hit)
                }
            }
        }
        if (AC == true) {
            if (textdraws == true) {
                if (getPlayerArmor() != 0) {
                    if (ArmorOverlay == false) {
                        Overlay_Armordraw := createTextDraw("~w~" "100", AX, AY, 0xFFFFFFFF, 1, ASize / 10, (ASize / 10) * 3)
                        ArmorOverlay := true
                    }
                    updateTextDraw(Overlay_Armordraw, "~w~" getPlayerArmor())
                } else {
                    deleteTextDraw(Overlay_Armordraw)
                    ArmorOverlay := false
                }
            } else {
                if (getPlayerArmor() != 0) {
                    if (ArmorOverlay == false) {
                        TextSetShown(overlays["Armor-Overlay"], true)
                        ArmorOverlay := true
                    }
                    TextSetString(overlays["Armor-Overlay"], getPlayerArmor())
                } else {
                    TextSetShown(overlays["Armor-Overlay"], false)
                    ArmorOverlay := false
                }
            }
        }
        if (VC == true) {
            if (GetVehicleEngineState() == true) {
                EngineState := "{04B404}angeschaltet{FFFFFF}"
            } 
            else if (GetVehicleEngineState() == false) {
                EngineState := "{DF0101}ausgeschaltet{FFFFFF}"
            }
            if (isVehicleLocked() == true) {
                LockedState := "{04B404}abgeschlossen{FFFFFF}"
            } 
            else if (isVehicleLocked() == false) {
                LockedState := "{DF0101}aufgeschlossen{FFFFFF}"
            }
            if (isPlayerInAnyVehicle() == true AND getVehicleHealth() > 0) {
                if (VehOverlay == false) {
                    TextSetShown(overlays["Vehicle-Overlay"], true)
                    VehOverlay := true
                }
                if (getVehicleHealth() < 351) {
                    TextSetString(overlays["Vehicle-Overlay"], "Fahrzeug: " getVehicleModelName() " hat {DF0101}" Round(getVehicleHealth(),0) "{FFFFFF} DL`nMotor: " EngineState " | State: " LockedState)
                } else {
                    TextSetString(overlays["Vehicle-Overlay"], "Fahrzeug: " getVehicleModelName() " hat " Round(getVehicleHealth(),0) "{FFFFFF} DL`nMotor: " EngineState " | State: " LockedState)
                }
            } else {
                TextSetShown(overlays["Vehicle-Overlay"], false)
                VehOverlay := false
            }
        }
        if (OC == true) {
            Zone := calculateZone(getCoordinates()[1], getCoordinates()[2], getCoordinates()[3])
            City := calculateCity(getCoordinates()[1], getCoordinates()[2], getCoordinates()[3])
            if (Zone == "" OR Zone == "Unbekannt") {
                TextSetString(overlays["Pos-Overlay"], "Interior in " lastzone)
            } else {
                TextSetString(overlays["Pos-Overlay"], Zone)
            }
        }
        if (MC == true) {
            TextSetString(overlays["Mask-Overlay"], masklabel ? "Maske: {00CD00}An!" : "Maske: {DF0101}Aus!")
        }
    }
return

explosiveCheck:
    if (getVehicleHealth() < 251 && getVehicleHealth() > 0 && isPlayerInAnyVehicle()) {
        explosive_interval := 5
        explosive_label_text := "{5C646C}[Hitman-Binder]{FFFFFF}`n{5C646C}" getVehicleModelName() "{FFFFFF} explodiert in: "
        explosive_label := createTextLabel(explosive_label_text explosive_interval, 0xFFFFFFFF, 0, 0, 0, 500.0, 0, 0xFFFF, getVehicleID())
        text_labels.Push(explosive_label)
        SetTimer explosiveLabel, 1000
        SetTimer explosiveCheck, Off
    }
return

explosiveLabel:
    explosive_interval--
    if (!explosive_interval) {
        deleteTextLabel(explosive_label)
        SetTimer explosiveLabel, Off
        SetTimer explosiveCheck, 300
        return
    }
    if (explosive_interval == 2)
        updateTextLabel(explosive_label, explosive_label_text "{e84621}" explosive_interval, 0xFFFFFFFF)
    else if (explosive_interval == 1)
        updateTextLabel(explosive_label, explosive_label_text "{DF0101}" explosive_interval, 0xFFFFFFFF)
    else
        updateTextLabel(explosive_label, explosive_label_text explosive_interval, 0xFFFFFFFF)
return

ExitOverlay:
    DestroyAllVisual()
    deleteTextDraw(Overlay_HPdraw)
    deleteTextDraw(Overlay_Armordraw)
    OverlayAktiv := false
    OverlayOn := false
return

lastzone:
    if (!getPlayerInteriorId() != 0) {
        Zone := calculateZone(getCoordinates()[1], getCoordinates()[2], getCoordinates()[3])
        City := calculateCity(getCoordinates()[1], getCoordinates()[2], getCoordinates()[3])
        lastcity := city
        lastzone := zone
    }

    if (lastzone == "") {
        lastzone := "Unbekannt"
    }

    if (isPlayerDriver() == true) {
        if (oldPlayerDriver == false AND autoML == true) {
            if (getVehicleEngineState() == false) {
                SendChat("/motor")
                SendChat("/licht")
            }
        }
        oldPlayerDriver := true
    } else {
        oldPlayerDriver := false
    }
return

Verlust:
    if (verlust == true) {
        PlayerHealth := getPlayerHealth() + getPlayerArmor()
        PlayerHealthOld -= 5
        lasthealthDamage := 0
        if (PlayerHealth < PlayerHealthOld) {
            PlayerHealthOld += 5
            PlayerHealthOld -= PlayerHealth
            lasthealthDamage := PlayerHealthOld
            if (PlayerHealthOld > 5 AND PlayerHealthOld < 8) {
                wep := "(Sonstige)"
            }
            if (PlayerHealthOld == 8) {
                wep := "(MP5)"
            }
            if (PlayerHealthOld == 9) {
                wep := "(Sonstige)"
            }
            if (PlayerHealthOld == 10) {
                wep := "(M4)"
            }
            if (PlayerHealthOld > 10 AND PlayerHealthOld < 25) {
                wep := "(Sonstige)"
            }
            if (PlayerHealthOld == 25) {
                wep := "(Rifle)"
            }
            if (PlayerHealthOld > 25 AND PlayerHealthOld < 41) {
                wep := "(Sonstige)"
            }
            if (PlayerHealthOld == 41) {
                wep := "(Sniper)"
            }
            if (PlayerHealthOld == 42) {
                wep := "(Sniper)"
            }
            if (PlayerHealthOld > 42 AND PlayerHealthOld < 46) {
                wep := "(Sonstige)"
            }
            if (PlayerHealthOld == 46) {
                wep := "(Deagle)"
            }
            if (PlayerHealthOld == 47) {
                wep := "(Deagle)"
            }
            if (PlayerHealthOld > 47 AND PlayerHealthOld < 51) {
                wep := "(Sonstige)"
            }
            if (PlayerHealthOld == 51) {
                wep := "(Sniper) {DF0101}(Headshot)"
            }
            if (PlayerHealthOld == 52) {
                wep := "(Sniper) {DF0101}(Headshot)"
            }
            if (PlayerHealthOld > 52 AND PlayerHealthOld < 101) {
                wep := "(Sonstige)"
            }
            if (PlayerHealthOld > 500) {
                return
            }
            Organizer("{FFFFFF}Du hast soeben {DF0101}-" PlayerHealthOld " {FFFFFF}HP {FF8200}" wep "{FFFFFF} verloren. Aktuelle HP: {00FF00}" getPlayerHealth() + getPlayerArmor())
        }
        PlayerHealthOld := PlayerHealth
    }
return

Helm:
    if (!autohelm)
        return
    
    if (isVehicleABike() && !helm) {
        SendChat("/helm")
        helm := !helm
    } 
    else if (!isVehicleABike() && helm) {
        SendChat("/helm")
        helm := !helm
    }
return

Blitzer:
    if (!blitzercheck)
        return
    
    Loop 13
    {
        if (IsPlayerInRangeOfPoint2D(BlitzerX[A_Index], BlitzerY[A_Index], 45.0) && getVehicleSpeed() > 87 && !isInChat() && isPlayerDriver() && !IsVehicleAPlane()) {
            while (getVehicleSpeed() > 87)
            {
                if (!blitzer_key) {
                    blitzer_key := true
                    Send {S down}
                }
            }
        }
    }
    if (blitzer_key) {
        blitzer_key := false
        Send {S up}
    }
return

Tot:
    if (getPlayerAnim() != 386 || indeathanim || tasered)
        return
    
    Zone := calculateZone(getCoordinates()[1], getCoordinates()[2], getCoordinates()[3])
    City := calculateCity(getCoordinates()[1], getCoordinates()[2], getCoordinates()[3])

    stats := getKD()
    stats["Tode"]++
    stats["dTode"]++
    IniWrite, % stats["Tode"], configs\stats.ini, Globals, deaths
    IniWrite, % stats["dTode"], configs\stats.ini, Daily, deaths
    
    if (Zone == "" OR Zone == "Unbekannt") {
        SendChat("/fc Ich bin in einem Interior in " lastzone " gestorben. | Tod Nr. " stats["Tode"] " - Heute: " stats["dTode"])
    } else {
        SendChat("/fc Ich bin in " Zone " gestorben. | Tod Nr. " stats["Tode"] " - Heute: " stats["dTode"])
    }
    sleep 100
    print_dkd("L")

    if (masklabel)
        masklabel := false
    
    SendChat("/tottime")
    SetTimer, indeathchecker, 2000
    indeathanim := true
    SetTimer, Tot, Off
return

indeathchecker:
    if (getPlayerAnim() != 386 AND indeathanim == true) {
        SetTimer, Tot, 2000
        indeathanim := false
        tasered := false
        SetTimer, indeathchecker, Off
    }
return

finden:
    if (!WinActive(gta_title))
        return
    
    if (!find_command)
        return
    
    SendChat("/dfinden " fusername)
    SetTimer execute_finden, 500
return

execute_finden:
    execute_find_player_pos := getCoordinates()
    execute_find_redmarker_pos := CoordsFromRedmarker()
    execute_find_dist := getDist(execute_find_player_pos, execute_find_redmarker_pos)
    CZP := calculateZone(execute_find_redmarker_pos[1], execute_find_redmarker_pos[2], execute_find_redmarker_pos[3])
    execute_find_player_text := find_command == "self" || find_command == "show" ? colors.primary fusername colors.white : fusername
    execute_find_location_text := find_command == "self" || find_command == "show" ? colors.primary CZP colors.white : CZP 
    execute_find_interior_text := find_command == "self" || find_command == "show" ? "einem " colors.primary "Interior" colors.white : "einem Interior"
    execute_find_text := "User: " execute_find_player_text " befindet sich in "
    execute_find_text .= CZP == "" || CZP == "Unbekannt" ? execute_find_interior_text : execute_find_location_text
    execute_find_text .= " | Distance: " Round(execute_find_dist) "m."
    
    if (find_command == "self")
        Organizer(execute_find_text)
    
    if (find_command == "k")
        SendChat(execute_find_text)
    
    if (find_command == "fc")
        SendChat("/fc " execute_find_text)
    
    if (find_command == "show") {
        Organizer(execute_find_text)
        SendChat("/dzeigen " fzeigen " " fusername)
    }
    
    SetTimer execute_finden, Off
return

tanken:
    if (!offerrefill) {
        return
    }

    tanken(false)
return

ChatTimer:
    if (!WinActive(gta_title)) {
        return
    }
    if (chatfile.Length < chatlines.Length()) {
        chatfile := FileOpen(A_MyDocuments "\GTA San Andreas User Files\SAMP\chatlog.txt", "r")
        chatlines := []
    }
    while(!chatfile.AtEOF) 
    {
        line := chatfile.ReadLine()
        line := RegExReplace(line, "U)^\[\d{2}:\d{2}:\d{2}\] ")
        line := StrReplace(line, "`r`n")
        line := StrReplace(line, "`r")
        line := RegExReplace(line, "{\S{6}}", "")
        if (line != "")  {
            chatlines.Push(line)
            if (!chatstarted)  {
                getChatWindowLine(line, chatlines.Length(), chatlines, hwid)
            }
        }
    }
    chatstarted := false
return

CheckDate:
    IniRead, day, configs\stats.ini, Date, day
    IniRead, month, configs\stats.ini, Date, month
    IniRead, year, configs\stats.ini, Date, year
    IniRead, date, configs\stats.ini, Date, date
    IniRead, Kills, configs\stats.ini, Globals, kills
    IniRead, dKills, configs\stats.ini, Daily, kills
    IniRead, Tode, configs\stats.ini, Globals, deaths
    IniRead, dTode, configs\stats.ini, Daily, deaths
    
    newday := A_DD
    newmonth := A_MM
    newyear := A_YYYY
    newdate := "" A_DD "." A_MM "." A_YYYY ""
    
    if (day != newday) {
        Organizer("Tages Statistik wurde zurückgesetzt{5C646C}!")
        if (month == 1) {
            FileMove, configs\stats.ini, statistics\old\01_Januar\Stats vom %date%.ini
        }
        else if (month == 2) {
            FileMove, configs\stats.ini, statistics\old\02_Februar\Stats vom %date%.ini
        }
        else if (month == 3) {
            FileMove, configs\stats.ini, statistics\old\03_März\Stats vom %date%.ini
        }
        else if (month == 4) {
            FileMove, configs\stats.ini, statistics\old\04_April\Stats vom %date%.ini
        }
        else if (month == 5) {
            FileMove, configs\stats.ini, statistics\old\05_Mai\Stats vom %date%.ini
        }
        else if (month == 6) {
            FileMove, configs\stats.ini, statistics\old\06_Juni\Stats vom %date%.ini
        }
        else if (month == 7) {
            FileMove, configs\stats.ini, statistics\old\07_Juli\Stats vom %date%.ini
        }
        else if (month == 8) {
            FileMove, configs\stats.ini, statistics\old\08_August\Stats vom %date%.ini
        }
        else if (month == 9) {
            FileMove, configs\stats.ini, statistics\old\09_September\Stats vom %date%.ini
        }
        else if (month == 10) {
            FileMove, configs\stats.ini, statistics\old\10_Oktober\Stats vom %date%.ini
        }
        else if (month == 11) {
            FileMove, configs\stats.ini, statistics\old\11_November\Stats vom %date%.ini
        }
        else if (month == 12) {
            FileMove, configs\stats.ini, statistics\old\12_Dezember\Stats vom %date%.ini
        }
        
        IniWrite, %newday%, configs\stats.ini, Date, day
        IniWrite, %newmonth%, configs\stats.ini, Date, month
        IniWrite, %newyear%, configs\stats.ini, Date, year
        IniWrite, %newdate%, configs\stats.ini, Date, date
        IniWrite, %Kills%, configs\stats.ini, Globals, kills
        IniWrite, 0, configs\stats.ini, Daily, kills
        IniWrite, %Tode%, configs\stats.ini, Globals, deaths
        IniWrite, 0, configs\stats.ini, Daily, deaths
    }
return