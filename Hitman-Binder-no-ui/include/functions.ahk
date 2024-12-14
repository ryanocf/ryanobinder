keybindsLoad()
{
    global
    Loop 20
    {
        _Own%A_Index% := Own%A_Index%
        IniRead, Own%A_Index%, configs\hotkeys.ini, Hotkeys, Own%A_Index%

        if (_Own%A_Index% != Own%A_Index%) {
            
            if (_Own%A_Index% != "") {
                Ownnum := _Own%A_Index%
                Hotkey, %Ownnum%, lOwn%A_Index%, Off
            }

            if (Own%A_Index% != "") {
                Own%A_Index% := "~" Own%A_Index%

                Ownnum := Own%A_Index%
                Hotkey, %Ownnum%, lOwn%A_Index%, On
            }
        }

        IniRead, BOwn%A_Index%, configs\hotkeys.ini, Contents, BOwn%A_Index%
    }

    IniRead, autoML, configs\misc.ini, General, autoML, false
    return
}

optionsLoad()
{
    global
    IniRead, FSpruch, configs\misc.ini, Faction, FSpruch, "GANGFIGHTKILL"
    IniRead, GSpruch, configs\misc.ini, Faction, GSpruch, false
    IniRead, verlust, configs\misc.ini, General, verlust, false
    IniRead, autohelm, configs\misc.ini, General, autohelm, false
    IniRead, offerrefill, configs\misc.ini, General, offerrefill, false
    IniRead, offercustoms, configs\misc.ini, General, offercustoms, false
    IniRead, autodete, configs\misc.ini, Hitman, autodete, false
    IniRead, automaske, configs\misc.ini, Hitman, automaske, false
    IniRead, blitzercheck, configs\misc.ini, General, blitzercheck, false
    IniRead, autoscreen, configs\misc.ini, Hitman, autoscreen, false
    IniRead, autohandy, configs\misc.ini, Hitman, autohandy, false
    return
}

weaponpackLoad()
{
    Loop, 5
    {
        IniRead, wp1w%A_Index%, configs\settings.ini, WP, wp1w%A_Index%
        IniRead, wp2w%A_Index%, configs\settings.ini, WP, wp2w%A_Index%
        IniRead, wp3w%A_Index%, configs\settings.ini, WP, wp3w%A_Index%
        IniRead, wp4w%A_Index%, configs\settings.ini, WP, wp4w%A_Index%
    }

    
    Loop 4
    {
        _WPOwn%A_Index% := WPOwn%A_Index%
        IniRead, WPOwn%A_Index%, configs\hotkeys.ini, Hotkeys, WPOwn%A_Index%

        if (_WPOwn%A_Index% != WPOwn%A_Index%) {
            
            if (_WPOwn%A_Index% != "") {
                WPnum := _WPOwn%A_Index%
                Hotkey, %WPnum%, lWPOwn%A_Index%, Off
            }

            if (Own%A_Index% != "") {
                WPOwn%A_Index% := "~" WPOwn%A_Index%

                WPnum := WPOwn%A_Index%
                Hotkey, %WPnum%, lWPOwn%A_Index%, On
            }
        }
    }
    return
}

gegnerLoad()
{
    global
    IniRead, ballassw, configs\settings.ini, Startwar, ballassw, false
    IniRead, gsfsw, configs\settings.ini, Startwar, gsfsw, false
    IniRead, vagossw, configs\settings.ini, Startwar, vagossw, false
    IniRead, aztecassw, configs\settings.ini, Startwar, aztecassw, false
    IniRead, triadensw, configs\settings.ini, Startwar, triadensw, false
    IniRead, outlawzsw, configs\settings.ini, Startwar, outlawzsw, false
    IniRead, yakuzasw, configs\settings.ini, Startwar, yakuzasw, false
    IniRead, lcnsw, configs\settings.ini, Startwar, lcnsw, false
    IniRead, copsw, configs\settings.ini, Startwar, copsw, false
    IniRead, ndsw, configs\settings.ini, Startwar, ndsw, false
    ; IniRead, gegnermessage, configs\misc.ini, Faction, gegnermessage
    return
}

overlayLoad()
{
    global
    IniRead, textdraws, configs\overlay.ini, Globals, textdraws
    IniRead, HPC, configs\overlay.ini, HP, status
    IniRead, HPX, configs\overlay.ini, HP, x
    IniRead, HPY, configs\overlay.ini, HP, y
    IniRead, HPSize, configs\overlay.ini, HP, size
    IniRead, AC, configs\overlay.ini, Armor, status
    IniRead, AX, configs\overlay.ini, Armor, x
    IniRead, AY, configs\overlay.ini, Armor, y
    IniRead, ASize, configs\overlay.ini, Armor, size
    ; IniRead, GC, configs\overlay.ini, Enemy, status
    ; IniRead, GX, configs\overlay.ini, Enemy, x
    ; IniRead, GY, configs\overlay.ini, Enemy, y
    ; IniRead, GSize, configs\overlay.ini, Enemy, size
    IniRead, VC, configs\overlay.ini, Vehicle, status
    IniRead, VX, configs\overlay.ini, Vehicle, x
    IniRead, VY, configs\overlay.ini, Vehicle, y
    IniRead, VSize, configs\overlay.ini, Vehicle, size
    IniRead, OC, configs\overlay.ini, Position, status
    IniRead, OX, configs\overlay.ini, Position, x
    IniRead, OY, configs\overlay.ini, Position, y
    IniRead, OSize, configs\overlay.ini, Position, size
    IniRead, MC, configs\overlay.ini, Mask, status
    IniRead, MX, configs\overlay.ini, Mask, x
    IniRead, MY, configs\overlay.ini, Mask, y
    IniRead, MSize, configs\overlay.ini, Mask, size
    IniRead, HPF, configs\overlay.ini, HP, color
    IniRead, AF, configs\overlay.ini, Armor, color
    ; IniRead, GF, configs\overlay.ini, Enemy, color
    IniRead, VF, configs\overlay.ini, Vehicle, color
    IniRead, OF, configs\overlay.ini, Position, color
    IniRead, MF, configs\overlay.ini, Mask, color
    IniRead, HPFont, configs\overlay.ini, HP, font
    IniRead, AFont, configs\overlay.ini, Armor, font
    ; IniRead, GFont, configs\overlay.ini, Enemy, font
    IniRead, VFont, configs\overlay.ini, Vehicle, font
    IniRead, OFont, configs\overlay.ini, Position, font
    IniRead, MFont, configs\overlay.ini, Mask, font

    if (!ov_hModule && (HPC || AC || VC || OC || MC)) {
        SetTimer OverlayTimer, 100
    }
    return
}

print_stand(chat)
{
    SendInput {end}+{home}{Del}{Esc}
    stand := read_stats(["Bargeld", "Bank", "Level", "Respektpunkte"])
    Bargeld := deldollar(stand["Bargeld"])
    Bank := deldollar(stand["Bank"])
    Gesamtvermögen := deldollar(deldot(Bargeld)) + deldollar(deldot(Bank))
    str := "Gesamtvermögen: [$" number_format(Gesamtvermögen) "] - Bargeld: [$" number_format(Bargeld) "] - Bank: [$" number_format(Bank) "] - Level: [" stand["Level"] "(RP: " stand["Respektpunkte"] ")]"
    if (chat == "L")
        Organizer(str)
    else
        SendChat((chat == "K" ? "" : "/fc ") str)

    return true
}

print_dabei(chat)
{
    SendInput {end}+{home}{Del}{Esc}
    blockDialog()
    SendChat("/inventar")
    sleep 100
    output := getDialogLines()
    unblockDialog()
    str := ""
    outputtotallength := output.Length()
    for key, value in output
    {
        if (RegExMatch(value, "^(.*):\s+(\d+)$", entry_) || RegExMatch(value, "^(.*)\s+(\d+)$", entry_)) {
            str .= entry_1 ": [" number_format(entry_2)
            if (entry_1 == "Drogen" || entry_1 == "Spice") {
                str .= "g"
            }
            str .= "]"
            if (outputtotallength != A_Index) {
                str .= " - "
            }
        }
    }
    if (str == "") {
        Exception("Dein Inventar ist leer")
        return false
    }

    if (chat == "L")
        Organizer("DABEI: " str)
    else
        SendChat((chat == "K" ? "" : "/fc ") "DABEI: " str)

    return true
}

print_box(chat)
{
    SendInput {end}+{home}{Del}{Esc}
    stand := read_stats(["Safebox Drogen", "Safebox Spice", "Safebox Waffenteile", "Safebox Wantedcodes"])
    str := "SAFEBOX | Drogen: [" number_format(deldot(stand["Safebox Drogen"])) "g] - Spice: [" number_format(deldot(stand["Safebox Spice"])) "g] - Waffenteile: [" number_format(deldot(stand["Safebox Waffenteile"])) "] - Codes: [" number_format(deldot(stand["Safebox Wantedcodes"])) "]"
    if (chat == "L")
        Organizer(str)
    else
        SendChat((chat == "K" ? "" : "/fc ") str)

    return true
}

print_kd(chat)
{
    SendInput {end}+{home}{Del}{Esc}
    stats := getKD()
    if (chat == "L") {
        Organizer("» Kills: {5C646C}" stats["Kills"] "{ffffff} - Tode: {5C646C}" stats["Tode"] "{ffffff} - Differenz: {5C646C}" stats["Dif"] "{ffffff} - KD: {5C646C}" stats["KD"] " «")
    } else {
        str := "» Kills: " stats["Kills"] " - Tode: " stats["Tode"] " - Differenz: " stats["Dif"] " - KD: " stats["KD"] " «"
        SendChat((chat == "K" ? "" : "/fc ") str)
    }
}

print_dkd(chat)
{
    SendInput {end}+{home}{Del}{Esc}
    stats := getKD()
    if (chat == "L") {
        Organizer("» Kills heute: {5C646C}" stats["dKills"] "{ffffff} - Tode: {5C646C}" stats["dTode"] "{ffffff} - Differenz: {5C646C}" stats["dDif"] "{ffffff} - KD: {5C646C}" stats["dKD"] " «")
    } else {
        str := "» Kills heute: " stats["dKills"] " - Tode: " stats["dTode"] " - Differenz: " stats["dDif"] " - KD: " stats["dKD"] " «"
        SendChat((chat == "K" ? "" : "/fc ") str)
    }
}

getKD()
{
    IniRead, Kills, configs\stats.ini, Globals, kills, 0
    IniRead, Tode, configs\stats.ini, Globals, deaths, 0
    IniRead, dKills, configs\stats.ini, Daily, kills, 0
    IniRead, dTode, configs\stats.ini, Daily, deaths, 0
    
    KD := Round(Kills / (Tode == 0 ? 1 : Tode), 2)
    Dif := Kills - Tode
    dKD := Round(dKills / (dTode == 0 ? 1 : dTode), 2)
    dDif := dKills - dTode

    return { "Kills": Kills
            , "Tode": Tode
            , "dKills": dKills
            , "dTode": dTode 
            , "KD": KD
            , "Dif": Dif
            , "dKD": dKD
            , "dDif": dDif }
}

calculate_finden_user(fuser) {
    if (find_command) {
        Exception("Brich deine derzeitige Suche zuerst mit /stop ab")
        return -1
    }
    
    IniRead deteskill, configs\settings.ini, Skill, detective
    if (deteskill > 5 || deteskill < 1) {
        Exception("Lege zuerst deinen Detektivskill mit /setskill fest")
        return -1
    }
    
    if (fuser == "") {
        Exception("ID oder Name eingeben")
        return -1
    }
    
    fuser := RegExMatch(fuser, "\d+") ? getPlayerNameById(fuser) : getPlayerNameById(getPlayerIdByName(fuser))
    if (fuser == "") {
        Exception("Der User konnte nicht gefunden werden")
        return -1
    }
    
    if (fuser == getPlayerName()) {
        Exception("Du kannst dich nicht selber suchen")
        return -1
    }
    
    return [fuser, deteskill]
}

tanken(command := false)
{
    if (!isPlayerDriver())
        return
    
    nearest_label := getNearestLabel()
    if (!RegExMatch(nearest_label.TEXT, "i)Benzin:\s\{\w+\}\$\d+,\s\{\w+\}Super:\s\{\w+\}\$\d+,\s\{\w+\}Diesel:\s\{\w+\}\$\d+"))
        return
    
    dist_label := getDist(getCoordinates(), [nearest_label.XPOS, nearest_label.YPOS, nearest_label.ZPOS])
    if (dist_label > 9.90)
        return
    
    textdraws := readTextDraw("")
    tank_needed := 0
    stoff := ""
    for key, value in textdraws
    {
        if (RegExMatch(value, "i)^(\d+)/(\d+) l$", tank_)) {
            tank_needed := tank_2 - tank_1
        }
        if (RegExMatch(value, "i)Kraftstoff:\s(\w+)", stoff_)) {
            stoff := stoff_1
        }
    }
    
    if (tank_needed < 1 || stoff == "")
        return
    
    if (command) {
        SendChat("/tanken")
        sleep 100
        if (isDialogOpen()) {
            dialog := getDialogLines()
            for key, value in dialog
            {
                if (InStr(value, stoff)) {
                    step := key - 1
                    Send {Down %step%}
                    Send {Enter}
                    sleep 100
                    SendInput %tank_needed%
                    Send {Enter}
                    sleep 100
                    Send {Enter}
                }
            }
            sleep 6000
        }
    } else {
        Organizer("Du kannst mit der Taste {5C646C}<{FFFFFF} tanken{5C646C}!")
        KeyWait, <, D T10
        if !ErrorLevel
        {
            SendChat("/tanken")
            sleep 100
            if (isDialogOpen()) {
                dialog := getDialogLines()
                for key, value in dialog
                {
                    if (InStr(value, stoff)) {
                        step := key - 1
                        Send {Down %step%}
                        Send {Enter}
                        sleep 100
                        SendInput %tank_needed%
                        Send {Enter}
                        sleep 100
                        Send {Enter}
                    }
                }
            }
            sleep 6000
        }
    }
}