getChatWindowLine(message, index, arr, hwid) {
    global
    For i, o in chatTriggers {
        if (RegExMatch(message, "O)" o.msg, match)) {
            o.callback.Call(match)
        }
    }

    if (RegExMatch(message, "^Du hast die Zielperson (.*) erfolgreich getötet. Kopfgeld: \$(.*)$", auftragsuccess_) || RegExMatch(message, "^Du hast ein Verbrechen begangen! \((.*)\) Reporter: (.*)$", wantedkill_) || RegExMatch(message, "^\-\>GANGFIGHTKILL\<\- (.*) Gangfightkill an (.*) \(3P\. an die (.*)\)$", gfkilled_) || RegExMatch(message, "^\-\>BIZFIGHTKILL\<\- (.*) Bizfightkill an (.*) \(1 Kill an die (.*)\)$", bizkilled_))
    {
        if (getID() != getPlayerIdByName(gfkilled_1, true) && getID() != getPlayerIdByName(bizkilled_1, true) && auftragsuccess_1 == "" && !(InStr(wantedkill_1, "Mord") && wantedkill_2 == "Polizeizentrale"))
            return

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
    }
}

setupChatWindow() {
    global chatTriggers := [
    (Join
        {
            "msg": "^Du hast dein Handy (.*).$",
            "callback": Func("chatHandyToggle")
        },
        {
            "msg": "^Dein Handy ist bereits (.*).$",
            "callback": Func("chatHandyToggle")
        },
        {
            "msg": "^\[SMS\]: (.*), Von: (.*) \(Nr. (.*)\)$",
            "callback": Func("chatSMS")
        },
        {
            "msg": "^\[FS-CHAT\] (.*) sagt: (.*)$",
            "callback": Func("chatFS")
        },
        {
            "msg": "^\* KFZ-Mechatroniker (.*) hat dir angeboten, dein Fahrzeug für \$(.*) aufzutanken\.$",
            "callback": Func("chatMechanicOffer")
        },
        {
            "msg": "^Du hast deine Maske (\w+)",
            "callback": Func("chatMaskToggle")
        },
        {
            "msg": "^Du hast den Auftrag erfolgreich angenommen\. \(Zielperson: (.*), Kopfgeld: \$(.*)\)$",
            "callback": Func("chatContractAccept")
        },
        {
            "msg": "^Deine Zielperson (.*) hat den Server verlassen.$",
            "callback": Func("chatContractAbort")
        },
        {
            "msg": "^Dein Auftraggeber (.*) hat den Server verlassen. Auftrag beendet.$",
            "callback": Func("chatContractAbort")
        },
        {
            "msg": "^(.*) hat den Auftrag von (.*) auf (.*) wieder freigegeben.$",
            "callback": Func("chatContractAbort2")
        },
        {
            "msg": "^Du hast die Befreiung von (.*) angenommen. \(-\$(.*)\)$",
            "callback": Func("chatAttorneyAccept")
        },
        {
            "msg": "^Tippe nun \'\/Accept Anwalt\' um die Befreiung anzunehmen.$",
            "callback": Func("chatAttorneyOffer")
        },
        {
            "msg": "^Du hast dich ergeben! Pro Wanted werden dir (\d+) Sekunden Haftstrafe angerechnet.\(Summe: (.*)\)$",
            "callback": Func("chatCopSurrendered")
        },
        {
            "msg": "^\* Da du dich gestellt hast, wirst du je Wanted (\d+) Sekunden anstatt (\d+) Sekunden je Wanted sitzen!$",
            "callback": Func("chatCopSurrendered")
        },
        {
            "msg": "^Du bist noch für (\d+) Sekunden \[(.*)\] im Gefängnis \((.*)\)\.$",
            "callback": Func("chatAttorneyRequest")
        },
        {
            "msg": "^\*\* (.*) schiesst mit seinem Tazer auf (.*)\. \*\*$",
            "callback": Func("chatCopTasered")
        },
        {
            "msg": "^Sie stehen an einer Zollstation, der Zollübergang kostet \$(.*)! Befehl: \/Zoll$",
            "callback": Func("chatCustomsOffer")
        }
    )]
}

chatHandyToggle(param) {
    global
    if (param.1 == "angeschaltet") {
        handy := true
    }
    else if (param.1 == "ausgeschaltet") {
        handy := false
    }
}

chatSMS(param) {
    global
    if (getPlayerName() == param.2 || param.3 == "") {
        return
    }

    smsname := param.2
    smsnumber := param.3
}

chatFS(param) {
    global
    if (getPlayerName() == param.1) {
        return
    }

    fsname := param.1
}

chatMechanicOffer(param)
{
    global
    Organizer("Du kannst den Refill mit der Taste {5C646C}<{FFFFFF} annehmen{5C646C}!")
    KeyWait, <, D T10
    if !ErrorLevel
    {
        SendChat("/accept refill")
    }

    return
}

chatMaskToggle(param)
{
    global
    if (param.1 == "aufgezogen") {
        masklabel := true
    }
    else if (param.1 == "abgenommen") {
        masklabel := false
    }

    return
}

chatContractAccept(param)
{ 
    global
    auftrag := true
    Organizer(autodete " - " automaske " - " autoscreen " - " autohandy)

    if (autodete == true) {
        finden_arr := calculate_finden_user(param.1)
        fusername := finden_arr[1]
        auftraguser := finden_arr[1]
        if (fusername != -1 || finden_arr != -1) {
            find_command := "self"
            Organizer("Suche nach " colors.primary fusername colors.white " gestartet.")
            SetTimer finden, % detektiv_interval[finden_arr[2]]
            gosub finden
        }
    }

    if (automaske && !masklabel) {
        SendChat("/hmaske")
    }

    if (autoscreen)  {
        Send, {F8}
    }
    
    if (autohandy && handy) {
        SendChat("/handystatus aus")
        handy := false
    }

    uid := getPlayerIdByName(param.1)
    uping := getPlayerPingById(getPlayerIdByName(param.1))
    ulevel := getPlayerScoreById(getPlayerIdByName(param.1))

    if (uping < 60) {
        cuping := "{00FF00}"
    }
    else if (uping < 100) {
        cuping := "{F7FE2E}"
    }
    else if (uping > 100) {
        cuping := "{DF0101}"
    }
    Organizer("Name: {5C646C}" param.1 "{FFFFFF} - ID: {5C646C}" uid "{FFFFFF} - Ping: " cuping uping "{FFFFFF} - Level: {5C646C}" ulevel)

    if (getPlayerScoreById(getPlayerIdByName(param.1)) < 3) {
        Organizer("{DF0101}ACHTUNG! {FFFFFF}Dieser Spieler ist Level {DF0101}" getPlayerScoreById(getPlayerIdByName(param.1)) " {FFFFFF}und darf nicht getötet werden{DF0101}!")
    }

    return
}

chatContractAbort(param)
{
    global
    auftrag := false
    if (auftraguser != fusername) {
        return
    }

    if (automaske && masklabel) {
        SendChat("/hmaske")
    }

    if (autohandy && !handy) {
        SendChat("/handystatus an")
        handy := true
    }
    
    if (!find_command) {
        return
    }

    Organizer("Die Suche nach " colors.primary fusername colors.white " wurde abgebrochen.")
    find_command := false

    return
}

chatContractAbort2(param)
{
    global
    if (param.1 != getPlayerName()) {
        return
    }

    chatContractAbort(param)
    return
}

chatAttorneyAccept(param)
{
    global
    SendChat("/fc Ich wurde von " param.1 " aus dem Knast geholt.")
    return
}

chatAttorneyOffer(param)
{
    global
    Organizer("Du kannst die Beifreiung mit der Taste {5C646C}<{FFFFFF} annehmen{5C646C}!")
    KeyWait, <, D T10
    if !ErrorLevel {
        SendChat("/accept anwalt")
    }
    
    return
}

chatCopSurrendered(param)
{
    global
    lawyer_needed := true
    SendChat("/jailtime")
    return
}

chatAttorneyRequest(param)
{
    global
    if (!lawyer_needed){
        return
    }

    if (lawyer_needed_command) {
        lawyer_skill_needed := 0
        loop 5
        {
            if (param.1 <= laywer_interval[A_Index]) {
                lawyer_skill_needed++
            }
        }
        SendChat("/fc Ich wurde für " param.2 " eingesperrt. Benötige einen Anwalt Skill " lawyer_skill_needed " am LSPD")
        lawyer_needed := false
        lawyer_needed_command := false
    } else {
        Organizer("Du kannst nach einen Anwalt mit der Taste {5C646C}<{FFFFFF} fragen{5C646C}!")
        KeyWait, <, D T10
        if !ErrorLevel {
            lawyer_skill_needed := 0
            loop 5
            {
                if (param.1 <= laywer_interval[A_Index]) {
                    lawyer_skill_needed++
                }
            }
            SendChat("/fc Ich wurde für " param.2 " eingesperrt. Benötige einen Anwalt Skill " lawyer_skill_needed " am LSPD")
            lawyer_needed := false
        }
    }

    return
}

chatCopTasered(param)
{
    global
    if (param.2 != getPlayerName() || param.2 != "Unbekannt") {
        return
    }
    tasered := true
    return
}

chatCustomsOffer(param)
{
    global
    if (!offercustoms) {
        return
    }
    
    Organizer("Du kannst mit der Taste {5C646C}<{FFFFFF} den Zoll bezahlen{5C646C}!")
    KeyWait, <, D T10
    if !ErrorLevel {
        SendChat("/Zoll")
    }
    return
}