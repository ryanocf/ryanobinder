F4::
    Organizer("Die {5C646C}F4{FFFFFF} Taste wird vom Keybinder blockiert{5C646C}!")
return

lOwn1:
    if (IsInChat()) {
        return
    }
    
    IniRead, FSpruch, configs\misc.ini, Faction, FSpruch, "GANGFIGHTKILL"
    IniRead, GSpruch, configs\misc.ini, Faction, GSpruch, false

    Zone := calculateZone(getCoordinates()[1], getCoordinates()[2], getCoordinates()[3])
    City := calculateCity(getCoordinates()[1], getCoordinates()[2], getCoordinates()[3])

    stats := getKD()
    stats["Kills"]++
    stats["dKills"]++
    IniWrite, % stats["Kills"], configs\stats.ini, Globals, kills
    IniWrite, % stats["dKills"], configs\stats.ini, Daily, kills
    
    if (!GSpruch) {
        return
    }

    if (Zone == "" OR Zone == "Unbekannt")
    {
        SendChat("/fc " FSpruch " in einem Interior in " lastzone " | Kill Nr. " stats["Kills"] " - Heute: " stats["dKills"])
    } else {
        SendChat("/fc " FSpruch " in " Zone " | Kill Nr. " stats["Kills"] " - Heute: " stats["dKills"])
    }
    sleep 100
    print_dkd("L")
return

lOwn2:
    if (IsInChat())
        return
    
    IniRead, FSpruch, configs\misc.ini, Faction, FSpruch, "GANGFIGHTKILL"
    IniRead, GSpruch, configs\misc.ini, Faction, GSpruch, false

    Zone := calculateZone(getCoordinates()[1], getCoordinates()[2], getCoordinates()[3])
    City := calculateCity(getCoordinates()[1], getCoordinates()[2], getCoordinates()[3])

    stats := getKD()
    stats["Tode"]++
    stats["dTode"]++
    IniWrite, % stats["Tode"], configs\stats.ini, Globals, deaths
    IniWrite, % stats["dTode"], configs\stats.ini, Daily, deaths
    
    if (!GSpruch) {
        return
    }
    
    if (Zone == "" OR Zone == "Unbekannt")
    {
        SendChat("/fc Ich bin in einem Interior in " lastzone " gestorben. | Tod Nr. " stats["Tode"] " - Heute: " stats["dTode"])
    } else {
        SendChat("/fc Ich bin in " Zone " gestorben. | Tod Nr. " stats["Tode"] " - Heute: " stats["dTode"])
    }
    sleep 100
    print_dkd("L")
return

lOwn3:
    if (IsInChat())
        return
    
    SendInput, t
    SendInput, {Up}
    SendInput, {enter}
return

lOwn4:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn4))
return

lOwn5:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn5))
return

lOwn6:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn6))
return

lOwn7:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn7))
return

lOwn8:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn8))
return

lOwn9:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn9))
return

lOwn10:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn10))
return

lOwn11:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn11))
return

lOwn12:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn12))
return

lOwn13:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn13))
return

lOwn14:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn14))
return

lOwn15:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn15))
return

lOwn16:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn16))
return

lOwn17:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn17))
return

lOwn18:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn18))
return

lOwn19:
    if (IsInChat())
        return
    
    SendChat(convertvar(BOwn19))
return

lOwn20:
    if (IsInChat())
        return

    SendChat(convertvar(BOwn20))
return

F12::
    Suspend, Permit
    if (A_IsSuspended == 1)
    {
        Organizer("» Der Keybinder wurde {5C646C}aktiviert! «")
    } else {
        Organizer("» Der Keybinder wurde {5C646C}deaktiviert! «")
    }
    Suspend, Toggle
return

lWPOwn1:
    if (IsInChat())
        return
    
    weapon_arr := []
    Loop 5 {
        if (wp1w%A_Index% == 1) {
            continue
        }
        weapon_arr.Push(waffenlager_arr[wp1w%A_Index% - 1])
    }
    if (weapon_arr.Length() < 1) {
        Organizer("{5C646C}FEHLER!{FFFFFF} Du hast keine Waffen in diesem Weaponpack{5C646C}!")
        return
    }
    sleep 300
    SendChat("/waffenlager")
    sleep 100
    Send, {Down 1}
    Send, {Enter}
    sleep 100
    if (isDialogOpen()) {
        output := getDialogLines()
        getWeapon(weapon_arr, output)
    }
return

lWPOwn2:
    if (IsInChat())
        return
    
    weapon_arr := []
    Loop 5 {
        if (wp2w%A_Index% == 1) {
            continue
        }
        weapon_arr.Push(waffenlager_arr[wp2w%A_Index% - 1])
    }
    if (weapon_arr.Length() < 1) {
        Organizer("{5C646C}FEHLER!{FFFFFF} Du hast keine Waffen in diesem Weaponpack{5C646C}!")
        return
    }
    sleep 300
    SendChat("/waffenlager")
    sleep 100
    Send, {Down 1}
    Send, {Enter}
    sleep 100
    if (isDialogOpen()) {
        output := getDialogLines()
        getWeapon(weapon_arr, output)
    }
return

lWPOwn3:
    if (IsInChat())
        return
    
    weapon_arr := []
    Loop 5 {
        if (wp3w%A_Index% == 1) {
            continue
        }
        weapon_arr.Push(waffenlager_arr[wp3w%A_Index% - 1])
    }
    if (weapon_arr.Length() < 1) {
        Organizer("{5C646C}FEHLER!{FFFFFF} Du hast keine Waffen in diesem Weaponpack{5C646C}!")
        return
    }
    sleep 300
    SendChat("/waffenlager")
    sleep 100
    Send, {Down 1}
    Send, {Enter}
    sleep 100
    if (isDialogOpen()) {
        output := getDialogLines()
        getWeapon(weapon_arr, output)
    }
return

lWPOwn4:
    if (IsInChat())
        return
    
    weapon_arr := []
    Loop 5 {
        if (wp4w%A_Index% == 1) {
            continue
        }
        weapon_arr.Push(waffenlager_arr[wp4w%A_Index% - 1])
    }
    if (weapon_arr.Length() < 1) {
        Organizer("{5C646C}FEHLER!{FFFFFF} Du hast keine Waffen in diesem Weaponpack{5C646C}!")
        return
    }
    sleep 300
    SendChat("/waffenlager")
    sleep 100
    Send, {Down 1}
    Send, {Enter}
    sleep 100
    if (isDialogOpen()) {
        output := getDialogLines()
        getWeapon(weapon_arr, output)
    }
return

~Enter::
    if (OverlayMove == true)
    {
        if (ovzahl == 1)
        {
            ovzahl := 0
            IniWrite, %HPX%, configs\overlay.ini, HP, x
            IniWrite, %HPY%, configs\overlay.ini, HP, y
            Organizer("HP-Overlay wurde {5C646C}gespeichert!")
            OverlayMove := false
        }
        if (ovzahl == 2)
        {
            ovzahl := 0
            IniWrite, %AX%, configs\overlay.ini, Armor, x
            IniWrite, %AY%, configs\overlay.ini, Armor, y
            Organizer("Armor-Overlay wurde {5C646C}gespeichert!")
            OverlayMove := false
        }
        ; if (ovzahl == 3)
        ; {
        ;     ovzahl := 0
        ;     IniWrite, %GX%, configs\overlay.ini, Enemy, x
        ;     IniWrite, %GY%, configs\overlay.ini, Enemy, y
        ;     Organizer("Gegner-Overlay wurde {5C646C}gespeichert!")
        ;     OverlayMove := false
        ; }
        if (ovzahl == 4)
        {
            ovzahl := 0
            IniWrite, %VX%, configs\overlay.ini, Vehicle, x
            IniWrite, %VY%, configs\overlay.ini, Vehicle, y
            Organizer("Vehicle-Overlay wurde {5C646C}gespeichert!")
            OverlayMove := false
        }
        if (ovzahl == 5)
        {
            ovzahl := 0
            IniWrite, %OX%, configs\overlay.ini, Position, x
            IniWrite, %OY%, configs\overlay.ini, Position, y
            Organizer("Positions-Overlay wurde {5C646C}gespeichert!")
            OverlayMove := false
        }
        if (ovzahl == 6)
        {
            ovzahl := 0
            IniWrite, %MX%, configs\overlay.ini, Mask, x
            IniWrite, %MY%, configs\overlay.ini, Mask, y
            Organizer("Mask-Overlay wurde {5C646C}gespeichert!")
            OverlayMove := false
        }
    }
return
^up::
    if (OverlayMove == true)
    {
        if (ovzahl == 1)
        {
            HPY := HPY - 1.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_HPdraw, HPX, HPY)
            } else {
                TextSetPos(overlays["HP-Overlay"], HPX, HPY)
            }
        }
        if (ovzahl == 2)
        {
            AY := AY - 1.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_Armordraw, AX, AY)
            } else {
                TextSetPos(overlays["Armor-Overlay"], AX, AY)
            }
        }
        ; if (ovzahl == 3)
        ; {
        ;     GY := GY - 1.00
        ;     TextSetPos(overlays["Gegner-Overlay"], GX, GY)
        ; }
        if (ovzahl == 4)
        {
            VY := VY - 1.00
            TextSetPos(overlays["Vehicle-Overlay"], VX, VY)
        }
        if (ovzahl == 5)
        {
            OY := OY - 1.00
            TextSetPos(overlays["Pos-Overlay"], OX, OY)
        }
        if (ovzahl == 6)
        {
            MY := MY - 1.00
            TextSetPos(overlays["Mask-Overlay"], MX, MY)
        }
    }
return
^down::
    if (OverlayMove == true)
    {
        if (ovzahl == 1)
        {
            HPY := HPY + 1.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_HPdraw, HPX, HPY)
            } else {
                TextSetPos(overlays["HP-Overlay"], HPX, HPY)
            }
        }
        if (ovzahl == 2)
        {
            AY := AY + 1.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_Armordraw, AX, AY)
            } else {
                TextSetPos(overlays["Armor-Overlay"], AX, AY)
            }
        }
        ; if (ovzahl == 3)
        ; {
        ;     GY := GY + 1.00
        ;     TextSetPos(overlays["Gegner-Overlay"], GX, GY)
        ; }
        if (ovzahl == 4)
        {
            VY := VY + 1.00
            TextSetPos(overlays["Vehicle-Overlay"], VX, VY)
        }
        if (ovzahl == 5)
        {
            OY := OY + 1.00
            TextSetPos(overlays["Pos-Overlay"], OX, OY)
        }
        if (ovzahl == 6)
        {
            MY := MY + 1.00
            TextSetPos(overlays["Mask-Overlay"], MX, MY)
        }
    }
return
^left::
    if (OverlayMove == true)
    {
        if (ovzahl == 1)
        {
            HPX := HPX - 1.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_HPdraw, HPX, HPY)
            } else {
                TextSetPos(overlays["HP-Overlay"], HPX, HPY)
            }
        }
        if (ovzahl == 2)
        {
            AX := AX - 1.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_Armordraw, AX, AY)
            } else {
                TextSetPos(overlays["Armor-Overlay"], AX, AY)
            }
        }
        ; if (ovzahl == 3)
        ; {
        ;     GX := GX - 1.00
        ;     TextSetPos(overlays["Gegner-Overlay"], GX, GY)
        ; }
        if (ovzahl == 4)
        {
            VX := VX - 1.00
            TextSetPos(overlays["Vehicle-Overlay"], VX, VY)
        }
        if (ovzahl == 5)
        {
            OX := OX - 1.00
            TextSetPos(overlays["Pos-Overlay"], OX, OY)
        }
        if (ovzahl == 6)
        {
            MX := MX - 1.00
            TextSetPos(overlays["Mask-Overlay"], MX, MY)
        }
    }
return
^right::
    if (OverlayMove == true)
    {
        if (ovzahl == 1)
        {
            HPX := HPX + 1.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_HPdraw, HPX, HPY)
            } else {
                TextSetPos(overlays["HP-Overlay"], HPX, HPY)
            }
        }
        if (ovzahl == 2)
        {
            AX := AX + 1.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_Armordraw, AX, AY)
            } else {
                TextSetPos(overlays["Armor-Overlay"], AX, AY)
            }
        }
        ; if (ovzahl == 3)
        ; {
        ;     GX := GX + 1.00
        ;     TextSetPos(overlays["Gegner-Overlay"], GX, GY)
        ; }
        if (ovzahl == 4)
        {
            VX := VX + 1.00
            TextSetPos(overlays["Vehicle-Overlay"], VX, VY)
        }
        if (ovzahl == 5)
        {
            OX := OX + 1.00
            TextSetPos(overlays["Pos-Overlay"], OX, OY)
        }
        if (ovzahl == 6)
        {
            MX := MX + 1.00
            TextSetPos(overlays["Mask-Overlay"], MX, MY)
        }
    }
return
!up::
    if (OverlayMove == true)
    {
        if (ovzahl == 1)
        {
            HPY := HPY - 3.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_HPdraw, HPX, HPY)
            } else {
                TextSetPos(overlays["HP-Overlay"], HPX, HPY)
            }
        }
        if (ovzahl == 2)
        {
            AY := AY - 3.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_Armordraw, AX, AY)
            } else {
                TextSetPos(overlays["Armor-Overlay"], AX, AY)
            }
        }
        ; if (ovzahl == 3)
        ; {
        ;     GY := GY - 3.00
        ;     TextSetPos(overlays["Gegner-Overlay"], GX, GY)
        ; }
        if (ovzahl == 4)
        {
            VY := VY - 3.00
            TextSetPos(overlays["Vehicle-Overlay"], VX, VY)
        }
        if (ovzahl == 5)
        {
            OY := OY - 3.00
            TextSetPos(overlays["Pos-Overlay"], OX, OY)
        }
        if (ovzahl == 6)
        {
            MY := MY - 3.00
            TextSetPos(overlays["Mask-Overlay"], MX, MY)
        }
    }
return
!down::
    if (OverlayMove == true)
    {
        if (ovzahl == 1)
        {
            HPY := HPY + 3.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_HPdraw, HPX, HPY)
            } else {
                TextSetPos(overlays["HP-Overlay"], HPX, HPY)
            }
        }
        if (ovzahl == 2)
        {
            AY := AY + 3.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_Armordraw, AX, AY)
            } else {
                TextSetPos(overlays["Armor-Overlay"], AX, AY)
            }
        }
        ; if (ovzahl == 3)
        ; {
        ;     GY := GY + 3.00
        ;     TextSetPos(overlays["Gegner-Overlay"], GX, GY)
        ; }
        if (ovzahl == 4)
        {
            VY := VY + 3.00
            TextSetPos(overlays["Vehicle-Overlay"], VX, VY)
        }
        if (ovzahl == 5)
        {
            OY := OY + 3.00
            TextSetPos(overlays["Pos-Overlay"], OX, OY)
        }
        if (ovzahl == 6)
        {
            MY := MY + 3.00
            TextSetPos(overlays["Mask-Overlay"], MX, MY)
        }
    }
return
!left::
    if (OverlayMove == true)
    {
        if (ovzahl == 1)
        {
            HPX := HPX - 3.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_HPdraw, HPX, HPY)
            } else {
                TextSetPos(overlays["HP-Overlay"], HPX, HPY)
            }
        }
        if (ovzahl == 2)
        {
            AX := AX - 3.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_Armordraw, AX, AY)
            } else {
                TextSetPos(overlays["Armor-Overlay"], AX, AY)
            }
        }
        ; if (ovzahl == 3)
        ; {
        ;     GX := GX - 3.00
        ;     TextSetPos(overlays["Gegner-Overlay"], GX, GY)
        ; }
        if (ovzahl == 4)
        {
            VX := VX - 3.00
            TextSetPos(overlays["Vehicle-Overlay"], VX, VY)
        }
        if (ovzahl == 5)
        {
            OX := OX - 3.00
            TextSetPos(overlays["Pos-Overlay"], OX, OY)
        }
        if (ovzahl == 6)
        {
            MX := MX - 3.00
            TextSetPos(overlays["Mask-Overlay"], MX, MY)
        }
    }
return
!right::
    if (OverlayMove == true)
    {
        if (ovzahl == 1)
        {
            HPX := HPX + 3.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_HPdraw, HPX, HPY)
            } else {
                TextSetPos(overlays["HP-Overlay"], HPX, HPY)
            }
        }
        if (ovzahl == 2)
        {
            AX := AX + 3.00
            if (textdraws == true)
            {
                moveTextDraw(Overlay_Armordraw, AX, AY)
            } else {
                TextSetPos(overlays["Armor-Overlay"], AX, AY)
            }
        }
        ; if (ovzahl == 3)
        ; {
        ;     GX := GX + 3.00
        ;     TextSetPos(overlays["Gegner-Overlay"], GX, GY)
        ; }
        if (ovzahl == 4)
        {
            VX := VX + 3.00
            TextSetPos(overlays["Vehicle-Overlay"], VX, VY)
        }
        if (ovzahl == 5)
        {
            OX := OX + 3.00
            TextSetPos(overlays["Pos-Overlay"], OX, OY)
        }
        if (ovzahl == 6)
        {
            MX := MX + 3.00
            TextSetPos(overlays["Mask-Overlay"], MX, MY)
        }
    }
return