:?:/stand::
{
    print_stand("L")
}
return

:?:/kstand::
{
    print_stand("K")
}
return

:?:/fcstand::
{
    print_stand("/fc")
}
return

:?:/dabei::
{
    print_dabei("L")
}
return

:?:/kdabei::
{
    print_dabei("K")
}
return

:?:/fcdabei::
{
    print_dabei("/fc")
}
return

:?:/box::
{
    print_box("L")
}
return

:?:/kbox::
{
    print_box("K")
}
return

:?:/fcbox::
{
    print_box("/fc")
}
return

:?:/nd::
{
    SendInput {end}+{home}{Del}{Esc}
    SendChat("/Nimmdrogen")
}
return

:?:/ns::
{
    SendInput {end}+{home}{Del}{Esc}
    SendChat("/Nimmspice")
}
return

:?:/ah::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    SendChat("/accept hitman")
}
return

:?:/hr::
{
    SendInput {end}+{home}{Del}{Esc}
    SendChat("/hrelease")
}

:?:/sniper::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    SendChat("/waffenlager")
    sleep 100
    Send, {Down 1}
    Send, {Enter}
    sleep 100
    if (isDialogOpen()) {
        output := getDialogLines()
        getWeapon(["sniper"], output)
    }
}
return

:?:/deagle::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    SendChat("/wmenu")
    sleep 100
    Send, {Down 6}
    sleep 150
    Send, {Enter}
}
return

:?:/schaufel::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    SendChat("/wmenu")
    sleep 100
    Send, {Down 2}
    sleep 150
    Send, {Enter}
}
return

:?:/sr::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    SendChat("/wmenu")
    sleep 100
    Send, {Enter}
}
return

:?:/mp5::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    SendChat("/wmenu")
    sleep 100
    Send, {Down 8}
    sleep 150
    Send, {Enter}
}
return

:?:/m4::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    if (isPlayerInRangeOfPoint(295.5281, -80.2421, 1001.5156, 10) OR isPlayerInRangeOfPoint(312.1109, -165.9126, 999.6010, 10) OR isPlayerInRangeOfPoint(296.3344, -38.0339, 1001.5156, 10)) {
        SendChat("/wmenu")
        sleep 100
        Send, {Down 9}
        sleep 150
        Send, {Enter}
    } else {
        SendChat("/waffenlager")
        sleep 100
        Send, {Down 1}
        Send, {Enter}
        sleep 100
        if (isDialogOpen()) {
            output := getDialogLines()
            getWeapon(["m4"], output)
        }
    }
}
return

:?:/ak::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    if (isPlayerInRangeOfPoint(295.5281, -80.2421, 1001.5156, 10) OR isPlayerInRangeOfPoint(312.1109, -165.9126, 999.6010, 10) OR isPlayerInRangeOfPoint(296.3344, -38.0339, 1001.5156, 10))
    {
        SendChat("/wmenu")
        sleep 100
        Send, {Down 10}
        sleep 150
        Send, {Enter}
    } else {
        SendChat("/waffenlager")
        sleep 100
        Send, {Down 1}
        Send, {Enter}
        sleep 100
        if (isDialogOpen()) {
            output := getDialogLines()
            getWeapon(["ak-47"], output)
        }
    }
}
return

:?:/rifle::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    if (isPlayerInRangeOfPoint(295.5281, -80.2421, 1001.5156, 10) OR isPlayerInRangeOfPoint(312.1109, -165.9126, 999.6010, 10) OR isPlayerInRangeOfPoint(296.3344, -38.0339, 1001.5156, 10))
    {
        SendChat("/wmenu")
        sleep 100
        Send, {Down 11}
        sleep 150
        Send, {Enter}
    } else {
        SendChat("/waffenlager")
        sleep 100
        Send, {Down 1}
        Send, {Enter}
        sleep 100
        if (isDialogOpen()) {
            output := getDialogLines()
            getWeapon(["cuntgun"], output)
        }
    }
}
return

:?:/shot::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    if (isPlayerInRangeOfPoint(295.5281, -80.2421, 1001.5156, 10) OR isPlayerInRangeOfPoint(312.1109, -165.9126, 999.6010, 10) OR isPlayerInRangeOfPoint(296.3344, -38.0339, 1001.5156, 10))
    {
        SendChat("/wmenu")
        sleep 100
        Send, {Down 7}
        sleep 150
        Send, {Enter}
    } else {
        SendChat("/waffenlager")
        sleep 100
        Send, {Down 1}
        Send, {Enter}
        sleep 100
        if (isDialogOpen()) {
            output := getDialogLines()
            getWeapon(["shotgun"], output)
        }
    }
}
return

:?:/weste::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    if (isPlayerInRangeOfPoint(295.5281, -80.2421, 1001.5156, 10) OR isPlayerInRangeOfPoint(312.1109, -165.9126, 999.6010, 10) OR isPlayerInRangeOfPoint(296.3344, -38.0339, 1001.5156, 10))
    {
        SendChat("/wmenu")
        sleep 100
        Send, {Down 3}
        sleep 150
        Send, {Enter}
    } else {
        SendChat("/waffenlager")
        sleep 100
        Send, {Down 1}
        Send, {Enter}
        sleep 100
        if (isDialogOpen()) {
            output := getDialogLines()
            getWeapon(["Schutzweste/HP"], output)
        }
    }
}
return

:?:/sp::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    if (isPlayerInRangeOfPoint(295.5281, -80.2421, 1001.5156, 10) OR isPlayerInRangeOfPoint(312.1109, -165.9126, 999.6010, 10) OR isPlayerInRangeOfPoint(296.3344, -38.0339, 1001.5156, 10))
    {
        SendChat("/wmenu")
        sleep 100
        Send, {Down 5}
        sleep 150
        Send, {Enter}
    } else {
        SendChat("/waffenlager")
        sleep 100
        Send, {Down 1}
        Send, {Enter}
        sleep 100
        if (isDialogOpen()) {
            output := getDialogLines()
            getWeapon(["silenced pistol"], output)
        }
    }
}
return

:?:/basi::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    if (isPlayerInRangeOfPoint(295.5281, -80.2421, 1001.5156, 10) OR isPlayerInRangeOfPoint(312.1109, -165.9126, 999.6010, 10) OR isPlayerInRangeOfPoint(296.3344, -38.0339, 1001.5156, 10))
    {
        SendChat("/wmenu")
        sleep 100
        Send, {Down}
        sleep 150
        Send, {Enter}
    } else {
        SendChat("/waffenlager")
        sleep 100
        Send, {Down 1}
        Send, {Enter}
        sleep 100
        if (isDialogOpen()) {
            output := getDialogLines()
            getWeapon(["bat"], output)
        }
    }
}
return

:?:/golf::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    SendChat("/waffenlager")
    sleep 100
    Send, {Down 1}
    Send, {Enter}
    sleep 100
    if (isDialogOpen()) {
        output := getDialogLines()
        getWeapon(["golf club"], output)
    }
}
return

:?:/9mm::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    SendChat("/wmenu")
    sleep 150
    Send, {Down 4}
    sleep 150
    Send, {Enter}
}
return

:?:/setkills::
{
    Sendinput / Kills:{space}
    Input newKills, V I M, {enter}
    SendInput {end}+{home}{Del}{esc}
    if newKills is not number
    {
        Organizer("{5C646C}FEHLER!{FFFFFF} Verwende dafür Zahlen{5C646C}!")
    } else {
        IniWrite, %newKills%, configs\stats.ini, Globals, kills
        Organizer("» Kills auf {5C646C}" newKills "{FFFFFF} gesetzt. {5C646C}«")
    }
}
return

:?:/settode::
{
    Sendinput / Tode:{space}
    Input newDeaths, V I M, {enter}
    SendInput {end}+{home}{Del}{esc}
    if newDeaths is not number
    {
        Organizer("{5C646C}FEHLER!{FFFFFF} Verwende dafür Zahlen{5C646C}!")
    } else {
        IniWrite, %newDeaths%, configs\stats.ini, Globals, Tode
        Organizer("» Tode auf {5C646C}" newDeaths "{FFFFFF} gesetzt. {5C646C}«")
    }
}
return

:?:/settageskills::
{
    Sendinput / Tages Kills:{space}
    Input newdKills, V I M, {enter}
    SendInput {end}+{home}{Del}{esc}
    if newdKills is not number
    {
        Organizer("{5C646C}FEHLER!{FFFFFF} Verwende dafür Zahlen{5C646C}!")
    } else {
        IniWrite, %newdKills%, configs\stats.ini, Daily, kills
        Organizer("» Tages Kills auf {5C646C}" newdKills "{FFFFFF} gesetzt. {5C646C}«")
    }
}
return

:?:/settagestode::
{
    Sendinput / Tages Tode:{space}
    Input newdTode ,V I M, {enter}
    SendInput {end}+{home}{Del}{esc}
    if newdTode is not number
    {
        Organizer("{5C646C}FEHLER!{FFFFFF} Verwende dafür Zahlen{5C646C}!")
    } else {
        IniWrite, %newdTode%, configs\stats.ini, Daily, deaths
        Organizer("» Tages Tode auf {5C646C}" newdTode "{FFFFFF} gesetzt. {5C646C}«")
    }
}
return

:?:/syncstats::
{
    stats := read_stats(["Morde", "Tode"])
    IniWrite % stats["Morde"], configs\stats.ini, Globals, kills
    IniWrite % stats["Tode"], configs\stats.ini, Globals, deaths

    Organizer("Stats synced{5C646C}!" )
}
return

:?:/kd::
{
    print_kd("L")
}
return

:?:/kkd::
{
    print_kd("K")
}
return

:?:/fckd::
{
    print_kd("/fc")
}
return

:?:/dkd::
{
    print_dkd("L")
}
return

:?:/kdkd::
{
    print_dkd("K")
}
return

:?:/fcdkd::
{
    print_dkd("/fc")
}
return

:?:/cd::
{
    SendInput {end}+{home}{Del}{esc}
    Organizer("Du kannst den Countdown mit der Taste {5C646C}<{FFFFFF} abbrechen{5C646C}!")
    sleep 300
    SendChat("» 3 « ")
    KeyWait, <, D T1
    if !ErrorLevel {
        SendChat("Countdown abgebrochen")
        return
    }
    SendChat("» 2 « ")
    KeyWait, <, D T1
    if !ErrorLevel {
        SendChat("Countdown abgebrochen")
        return
    }
    SendChat("» 1 « ")
    KeyWait, <, D T1
    if !ErrorLevel {
        SendChat("Countdown abgebrochen")
        return
    }
    SendChat("» GO « ")
}
return

:?:/wp::
{
    SendInput / Waffenpack:{Space}
    Input, pack, V I M, {Enter}
    SendInput {end}+{home}{Del}{esc}
    if (pack > 4 || pack < 1) {
        Organizer("{5C646C}FEHLER!{FFFFFF} Es gibt nur Weaponpack 1-4{5C646C}!")
        return
    }
    weapon_arr := []
    Loop 5 {
        if (wp%pack%w%A_Index% == 1) {
            continue
        }
        weapon_arr.Push(waffenlager_arr[wp%pack%w%A_Index% - 1])
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
}
return

:?:/finden::
{
    SendInput /finden{Space}
    Input, fuser, V I M, {Enter}
    SendInput {end}+{home}{Del}{Esc}

    finden_arr := calculate_finden_user(fuser)
    fusername := finden_arr[1]
    if (fusername == -1 || finden_arr == -1)
        return

    find_command := "self"
    Organizer("Suche nach " colors.primary fusername colors.white " gestartet.")
    SetTimer finden, % detektiv_interval[finden_arr[2]]
    gosub finden
}
return

:?:/fcfinden::
{
    SendInput /finden{Space}
    Input, fuser, V I M, {Enter}
    SendInput {end}+{home}{Del}{Esc}

    finden_arr := calculate_finden_user(fuser)
    fusername := finden_arr[1]
    if (fusername == -1 || finden_arr == -1)
        return

    find_command := "fc"
    SendChat("/fc Suche nach " fusername " gestartet.")
    SetTimer finden, % detektiv_interval[finden_arr[2]]
    gosub finden
}
return

:?:/kfinden::
{
    SendInput /finden{Space}
    Input, fuser, V I M, {Enter}
    SendInput {end}+{home}{Del}{Esc}

    finden_arr := calculate_finden_user(fuser)
    fusername := finden_arr[1]
    if (fusername == -1 || finden_arr == -1)
        return

    find_command := "k"
    SendChat("Suche nach " fusername " gestartet.")
    SetTimer finden, % detektiv_interval[finden_arr[2]]
    gosub finden
}
return

:?:/zeigen::
{
    SendInput /zeigen{Space}
    Input, fzeig, V I M, {Space}
    Input, fuser, V I M, {Enter}
    SendInput {end}+{home}{Del}{Esc}

    zeigen_arr := calculate_finden_user(fzeig)
    fzeigen := zeigen_arr[1]
    if (fzeigen == -1 || zeigen_arr == -1)
        return

    finden_arr := calculate_finden_user(fuser)
    fusername := finden_arr[1]
    if (fusername == -1 || finden_arr == -1)
        return

    find_command := "show"
    Organizer("Suche nach " colors.primary fusername colors.white " gestartet.")
    SetTimer finden, % detektiv_interval[finden_arr[2]]
    gosub finden
}
return

:?:/stop::
{
    SendInput {end}+{home}{Del}{Esc}
    if (!find_command) {
        Exception("Du suchst nach niemanden")
        return
    }

    if (find_command == "self" || find_command == "show")
        Organizer("Die Suche nach " colors.primary fusername colors.white " wurde abgebrochen.")
    else if (find_command == "k")
        SendChat("Die Suche nach " fusername " wurde abgebrochen.")
    else if (find_command == "fc")
        SendChat("/fc Die Suche nach " fusername " wurde abgebrochen.")

    find_command := false
}
return

:?:/crespawn::
{
    SendInput {end}+{home}{Del}{Esc}
    Organizer("Du kannst den Carrespawn mit der Taste {5C646C}<{FFFFFF} abbrechen{5C646C}!")
    SendChat("/fc » CARRESPAWN • IN • 30 Sekunden «")
    KeyWait, <, D T15
    If !ErrorLevel {
        SendChat("/fc Carrespawn abgebrochen")
        return
    }
    SendChat("/fc » CARRESPAWN • IN • 15 Sekunden «")
    KeyWait, <, D T10
    If !ErrorLevel {
        SendChat("/fc Carrespawn abgebrochen")
        return
    }
    SendChat("/fc » CARRESPAWN • IN • 5 Sekunden «")
    KeyWait, <, D T5
    If !ErrorLevel {
        SendChat("/fc Carrespawn abgebrochen")
        return
    }
    SendChat("/respawncars")
}
return

:?:/cclearchat::
{
    SendInput {end}+{home}{Del}{Esc}
    Loop 30
    {
        AddChatMessage("")
    }
}
return

:?:/atm::
{
    SendInput {end}+{home}{Del}{Esc}
    SendChat("/automat")
}
return

:?:/setskill::
{
    Organizer("{5C646C}» » {FFFFFF}Set-Skill {5C646C}« «")
    Organizer("1. Detektiv-Skill")
    Organizer("2. Huren-Skill")
    Organizer("3. Anwalt-Skill")
    Organizer("4. Gangfight-Skill")
    Organizer("5. Drogen-Skill")
    Organizer("6. Waffenteile-Skill")
    SendInput / Zahl:{space} Drücke 'Space' nach der Eingabe{home}{right 7}
    Input, skillzahl, V I M, {space}
    SendInput {end}+{home}{Del}{Esc}
    if (skillzahl == 1) {
        SendInput, tDetektiv-Skill:{space}
        Input, deteskill, V I M, {enter}
        SendInput {end}+{home}{Del}{Esc}
        if (deteskill > 0 AND deteskill < 6) {
            IniWrite, %deteskill%, configs\settings.ini, Skill, detective
            Organizer("Detektiv-Skill wurde auf {5C646C}" deteskill "{FFFFFF} gesetzt.")
        } else {
            Organizer("{5C646C}FEHLER!{FFFFFF} Der Detektiv-Skill existiert nur von Skill 1 - 5{5C646C}!")
            IniWrite, 1, configs\settings.ini, Skill, detective
        }
    }
    else if (skillzahl == 2) {
        SendInput, tHuren-Skill:{space}
        Input, hureskill, V I M, {enter}
        SendInput {end}+{home}{Del}{Esc}
        if (hureskill > 0 AND hureskill < 6) {
            IniWrite, %hureskill%, configs\settings.ini, Skill, whore
            Organizer("Huren-Skill wurde auf {5C646C}" hureskill "{FFFFFF} gesetzt.")
        } else {
            Organizer("{5C646C}FEHLER!{FFFFFF} Der Huren-Skill existiert nur von Skill 1 - 5{5C646C}!")
            IniWrite, 1, configs\settings.ini, Skill, whore
        }
    }
    else if (skillzahl == 3) {
        SendInput, tAnwalt-Skill:{space}
        Input, anwaltskill, V I M, {enter}
        SendInput {end}+{home}{Del}{Esc}
        if (anwaltskill > 0 AND anwaltskill < 7) {
            IniWrite, %anwaltskill%, configs\settings.ini, Skill, attorney
            Organizer("Anwalt-Skill wurde auf {5C646C}" anwaltskill "{FFFFFF} gesetzt.")
        } else {
            Organizer("{5C646C}FEHLER!{FFFFFF} Der Anwalt-Skill existiert nur von Skill 1 - 6{5C646C}!")
            IniWrite, 1, configs\settings.ini, Skill, attorney
        }
    }
    else if (skillzahl == 4) {
        SendInput, tGangfight-Skill:{space}
        Input, gangfightskill, V I M, {enter}
        SendInput {end}+{home}{Del}{Esc}
        if (gangfightskill > 0 AND gangfightskill < 11) {
            IniWrite, %gangfightskill%, configs\settings.ini, Skill, gf
            Organizer("Gangfight-Skill wurde auf {5C646C}" gangfightskill "{FFFFFF} gesetzt.")
        } else {
            Organizer("{5C646C}FEHLER!{FFFFFF} Der Gangfight-Skill existiert nur von Skill 1 - 10{5C646C}!")
            IniWrite, 1, configs\settings.ini, Skill, gf
        }
    }
    else if (skillzahl == 5) {
        SendInput, tDrogen-Skill:{space}
        Input, drogenskill, V I M, {enter}
        SendInput {end}+{home}{Del}{Esc}
        if (drogenskill > 0 AND drogenskill < 6) {
            IniWrite, %drogenskill%, configs\settings.ini, Skill, drugs
            Organizer("Drogen-Skill wurde auf {5C646C}" drogenskill "{FFFFFF} gesetzt.")
        } else {
            Organizer("{5C646C}FEHLER!{FFFFFF} Der Drogen-Skill existiert nur von Skill 1 - 5{5C646C}!")
            IniWrite, 1, configs\settings.ini, Skill, drugs
        }
    }
    else if (skillzahl == 6) {
        SendInput, tWaffenteile-Skill:{space}
        Input, waffenteileskill, V I M, {enter}
        SendInput {end}+{home}{Del}{Esc}
        if (waffenteileskill > 0 AND waffenteileskill < 6) {
            IniWrite, %waffenteileskill%, configs\settings.ini, Skill, wp
            Organizer("Waffenteile-Skill wurde auf {5C646C}" waffenteileskill "{FFFFFF} gesetzt.")
        } else {
            Organizer("{5C646C}FEHLER!{FFFFFF} Der Waffenteile-Skill existiert nur von Skill 1 - 5{5C646C}!")
            IniWrite, 1, configs\settings.ini, Skill, wp
        }
    }
}
return

:?:/wl::
{
    SendInput {end}+{home}{Del}{Esc}
    SendChat("/Waffenlager")
}
return

:?:/drein::
{
    SendInput, /safebox drogen reinlegen{space}
}
return

:?:/srein::
{
    SendInput, /safebox spice reinlegen{space}
}
return

:?:/wrein::
{
    SendInput, /safebox waffenteile reinlegen{space}
}
return

:?:/crein::
{
    SendInput, /safebox wantedcodes reinlegen{space}
}
return

:?:/draus::
{
    SendInput, /safebox drogen rausnehmen{space}
}
return

:?:/sraus::
{
    SendInput, /safebox spice rausnehmen{space}
}
return

:?:/wraus::
{
    SendInput, /safebox waffenteile rausnehmen{space}
}
return

:?:/craus::
{
    SendInput, /safebox wantedcodes rausnehmen{space}
}
return

:?:/kb::
{
    SendInput {end}+{home}{Del}{Esc}
    SendChat("/kanister benutzen")
}
return

:?:/kk::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    SendChat("/tankshop")
    sleep 100
    Send, {Down 4}
    Send, {Enter}
}
return

:?:/ka::
{
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    SendChat("/kofferraumansehen")
}
return

:?:/idsms::
{
    SendInput / User(ID/Name):{space}
    Input suser, V I M, {enter}
    SendInput {end}+{home}{Del}{Esc}
    sleep 300
    if suser is integer
    {
        susername := getPlayerNameById(suser)
        if (susername == -1 OR susername == "") {
            Organizer("{5C646C}FEHLER!{FFFFFF} Der User ist nicht online{5C646C}!")
            return
        }
        SendChat("/nummer " getPlayerIdByName(susername))
        sleep 100
        Organizer("Du sendest eine SMS an {5C646C}" susername)
    }
    else if suser is not integer
    {
        susername := getPlayerNameById(getPlayerIdByName(suser))
        if (susername == -1 OR susername == "") {
            Organizer("{5C646C}FEHLER!{FFFFFF} Der User ist nicht online{5C646C}!")
            return
        }
        SendChat("/nummer " getPlayerIdByName(susername))
        sleep 100
        Organizer("Du sendest eine SMS an {5C646C}" susername)
    }
    Loop, read, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
    {
        if (RegExMatch(A_LoopReadLine, "Name: \{FFFFFE\}(.*) \{FF6731\}\|\{0077FF\} Nummer: \{FFFFFE\}(\w*)", number)) {
            SendInput, t^a/sms %number2%{space}
        }
    }
}
return

:?:/re::
{
    if (smsname == "") {
        Organizer("{5C646C}FEHLER!{FFFFFF} Du hast seit dem Keybinder start keine SMS erhalten{5C646C}!")
        SendInput {end}+{home}{Del}{esc}
        return
    }
    if (getPlayerName() != smsname) {
        Organizer("Du sendest eine SMS an {5C646C}" smsname)
        SendInput /sms %smsnumber%{space}
    } else {
        SendInput /sms{space}
    }
}
return

:?:/fssms::
{
    Sendinput / Freund(ID/Name):{space}
    Input friend, V I M, {enter}
    SendInput {end}+{home}{Del}{esc}
    sleep 300
    if friend is integer
    {
        friend := getPlayerNameById(friend)
        if (friend == -1 OR friend == "")
        {
            Organizer("{5C646C}FEHLER!{FFFFFF} Dein Freund ist nicht online{5C646C}!")
            return
        }
        Organizer("Du sendest eine Message an {5C646C}" friend)
    }
    else if friend is not integer
    {
        friend := getPlayerNameById(getPlayerIdByName(friend))
        if (friend == -1 OR friend == "")
        {
            Organizer("{5C646C}FEHLER!{FFFFFF} Dein Freund ist nicht online{5C646C}!")
            return
        }
        Organizer("Du sendest eine Message an {5C646C}" friend)
    }
    SendInput, t^a/fschat %friend%{space}
}
return

:?:/fsre::
{
    if (fsname == "") {
        Organizer("{5C646C}FEHLER!{FFFFFF} Du hast seit dem Keybinder start keine Message erhalten{5C646C}!")
        SendInput {end}+{home}{Del}{esc}
        return
    }
    if (getPlayerName() != fsname) {
        Organizer("Du sendest eine Message an {5C646C}" fsname)
        SendInput /fschat %fsname%{space}
    } else {
        SendInput /fschat{space}
    }
}
return

:?:/anwalt::
{
    SendInput {end}+{home}{Del}{Esc}
    lawyer_needed := true
    lawyer_needed_command := true
    SendChat("/jailtime")
}
return

:?:/adminrechte::
{
    SendInput {end}+{home}{Del}{Esc}
    AddChatMessage("{aa3333}[BANNED] Du wurdest soeben vom System dauerhaft aus dem Server gebannt. Grund: Cheater")
    AddChatMessage("{aa3333}Sind Sie der Meinung das diese Sperre falsch war? Dann schreiben Sie auf www.LyD-Roleplay.de ein Entbannantrag!")
    AddChatMessage("Server closed the connection.")
    sleep 300
    ShowDialog(0, "Sie wurden Gesperrt", "Ihr Spieler-Account wurde gesperrt!`n`nAufgrund eines Regelverstoßes wurde Ihr Spieleraccount gesperrt!`nSollte dies ein Fehlban sein, schreiben Sie ein Entbannantrag im Forum www.LyD-Roleplay.de`nDie Daten des Banns:`nDauer: Immer`nGrund: Cheater`nVon: System", "Exit")
}
return

:?:/maske::
{
    SendInput {end}+{home}{Del}{Esc}
    SendChat("/hmaske")
}
return

:?:/handy::
{
    SendInput {end}+{home}{Del}{Esc}
    if (handy == true) {
        SendChat("/handystatus aus")
    } else {
        SendChat("/handystatus an")
    }
}
return

:?:/hw::
{
    SendInput {end}+{home}{Del}{Esc}
    SendChat("/hitmanwaffen")
    SendChat("/gheilen")
}
return

:?:/gw::
{
    SendInput {end}+{home}{Del}{Esc}
    SendChat("/gangwaffen")
    SendChat("/gheilen")
}
return

:?:/mtanken::
{
    SendInput {end}+{home}{Del}{Esc}
    tanken(true)
}
return

:?:/gfi::
{
    SendInput {end}+{home}{Del}{Esc}
    SendChat("/gangfightinfo")
}
return

:?:/setweather::
{
    Sendinput / WeatherID:{space}
    Input weather_id, V I M, {enter}
    SendInput {end}+{home}{Del}{esc}
    sleep 300
    if (!setWeatherID(weather_id)) {
        Exception("WeatherID kann nur 0-255 betragen")
        return
    }

    Organizer("WeatherID wurde auf " colors.primary weather_id colors.white " gesetzt.")
}
return

:?:/getweather::
{
    SendInput {end}+{home}{Del}{esc}
    Organizer("Derzeitige WeatherID: " colors.primary getWeatherID())
}
return

:?:/settime::
{
    Sendinput / Time:{space}
    Input hour, V I M, {enter}
    SendInput {end}+{home}{Del}{esc}
    sleep 300
    if (!setTime(hour)) {
        Exception("Time kann nur 0-23 betragen")
        return
    }

    Organizer("Time wurde auf " colors.primary hour colors.white " gesetzt.")
}
return

:?:/gettime::
{
    SendInput {end}+{home}{Del}{esc}
    Organizer("Derzeitige Time: " colors.primary getTime())
}
return

:?:/ovmove::
{
    OverlayMove := true
    Organizer("{5C646C}» » {FFFFFF}Overlay-Move {5C646C}« «")
    Organizer("1. HP-Overlay")
    Organizer("2. Armor-Overlay")
    ; Organizer("3. Gegner-Overlay")
    Organizer("4. Vehicle-Overlay")
    Organizer("5. Pos-Overlay")
    Organizer("6. Mask-Overlay")
    SendInput Zahl:{space} Drücke 'Space' nach der Eingabe{home}{right 6}
    Input, ovzahl, VIM, {space}
    SendInput {end}+{home}{Del}{Esc}
    Organizer("Du kannst nun das {5C646C}" overlay_name[ovzahl] "{FFFFFF} verschieben!")
}
return

:?:/ovhelp::
{
    SendInput {end}+{home}{Del}{Esc}
    Organizer("{5C646C}» » {FFFFFF}Overlay-Help {5C646C}« «")
    Organizer("/ovmove = {5C646C}Movemodus starten")
    Organizer("ALT + Pfeiltasten = {5C646C}schnell")
    Organizer("STRG + Pfeiltasten = {5C646C}langsam")
    Organizer("ENTER = {5C646C}Movemodus beenden")
    Organizer("{DF0101}INFO: Während dem Movemodus darf keine Pfeiltaste belegt sein!")
}
return