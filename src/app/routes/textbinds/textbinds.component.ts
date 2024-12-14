/* DEFAULTS */
import { Component } from '@angular/core';
/**/

/* IMPORTS */
import { SharedModule } from 'src/app/app.module';

    /* PRIMENG */
    import { DropdownChangeEvent, DropdownModule } from 'primeng/dropdown';
    /**/

/**/

@Component({
    selector: 'app-textbinds',
    standalone: true,
    imports: [
        SharedModule,
        DropdownModule
    ],
    templateUrl: './textbinds.component.html',
    styleUrl: './textbinds.component.scss'
})
export class TextbindsComponent {
    constructor() {}

    public tabList = [
        {
            label: 'Alle',
            icon: 'mdi mdi-all-inclusive'
        },
        {
            label: 'Allgemein',
            icon: 'mdi mdi-cloud'
        },
        { 
            label: 'Stats',
            icon: 'mdi mdi-finance'
        },
        {
            label: 'Jobs',
            icon: 'mdi mdi-briefcase'
        },
        {
            label: 'Fraktion',
            icon: 'mdi mdi-account-tie'
        },
        {
            label: 'Waffen',
            icon: 'mdi mdi-pistol'
        },
        {
            label: 'Overlay',
            icon: 'mdi mdi-monitor-shimmer'
        },
    ];

    public selectedFilter = this.tabList[0];

    public tbList = [
        {
            label: '/setkills',
            description: 'Kills setzen',
            category: 'Stats'
        },
        {
            label: '/settode',
            description: 'Tode setzen',
            category: 'Stats'
        },
        {
            label: '/settageskills',
            description: 'Tageskills setzen',
            category: 'Stats'
        },
        {
            label: '/settagestode',
            description: 'Tagestode setzen',
            category: 'Stats'
        },
        {
            label: '/kd',
            description: 'KD local anzeigen',
            category: 'Stats'
        },
        {
            label: '/fckd',
            description: 'KD im Fraktionschat anzeigen',
            category: 'Stats'
        },
        {
            label: '/kkd',
            description: 'KD im Chat anzeigen',
            category: 'Stats'
        },
        {
            label: '/dkd',
            description: 'TagesKD local anzeigen',
            category: 'Stats'
        },
        {
            label: '/fcdkd',
            description: 'TagesKD im Fraktionschat anzeigen',
            category: 'Stats'
        },
        {
            label: '/kdkd',
            description: 'TagesKD im Chat anzeigen',
            category: 'Stats'
        },
        {
            label: '/stand',
            description: 'Finanzen local anzeigen',
            category: 'Stats'
        },
        {
            label: '/fcstand',
            description: 'Finanzen im Fraktionschat anzeigen',
            category: 'Stats'
        },
        {
            label: '/kstand',
            description: 'Finanzen im Chat anzeigen',
            category: 'Stats'
        },
        {
            label: '/dabei',
            description: 'Güter (dabei) local anzeigen',
            category: 'Stats'
        },
        {
            label: '/fcdabei',
            description: 'Güter (dabei) im Fraktionschat anzeigen',
            category: 'Stats'
        },
        {
            label: '/kdabei',
            description: 'Güter (dabei) im Chat anzeigen',
            category: 'Stats'
        },
        {
            label: '/box',
            description: 'Boxinhalt local anzeigen',
            category: 'Stats'
        },
        {
            label: '/fcbox',
            description: 'Boxinhalt im Fraktionschat anzeigen',
            category: 'Stats'
        },
        {
            label: '/kbox',
            description: 'Boxinhalt im Chat anzeigen',
            category: 'Stats'
        },
        {
            label: '/finden',
            description: 'Deteschleife local anzeigen',
            category: 'Jobs'
        },
        {
            label: '/fcfinden',
            description: 'Deteschleife im Fraktionschat anzeigen',
            category: 'Jobs'
        },
        {
            label: '/kfinden',
            description: 'Deteschleife im Chat anzeigen',
            category: 'Jobs'
        },
        {
            label: '/zeigen',
            description: 'Deteschleife einem anderen User anzeigen',
            category: 'Jobs'
        },
        {
            label: '/stop',
            description: 'Deteschleife stoppen',
            category: 'Jobs'
        },
        {
            label: '/id',
            description: 'Informationen eines Users per ID anzeigen',
            category: 'Allgemein'
        },
        {
            label: '/idsms',
            description: 'SMS per ID schreiben',
            category: 'Allgemein'
        },
        {
            label: '/re',
            description: 'Auf letzte erhaltene SMS antworten',
            category: 'Allgemein'
        },
        {
            label: '/fssms',
            description: 'Freundesnachricht per ID schreiben',
            category: 'Allgemein'
        },
        {
            label: '/fsre',
            description: 'Auf letzte erhaltene Freundesnachricht antworten',
            category: 'Allgemein'
        },
        {
            label: '/ah',
            description: '/accept hitman',
            category: 'Fraktion'
        },
        {
            label: '/hr',
            description: '/hrelease',
            category: 'Fraktion'
        },
        {
            label: '/atm',
            description: '/automat',
            category: 'Allgemein'
        },
        {
            label: '/anwalt',
            description: 'Nach einen Anwalt fragen im Fraktionschat',
            category: 'Jobs'
        },
        {
            label: '/crespawn',
            description: '30 Sekunden Carrespawn Countdown',
            category: 'Fraktion'
        },
        {
            label: '/nd',
            description: '/nimmdrogen',
            category: 'Allgemein'
        },
        {
            label: '/ns',
            description: '/nimmspice',
            category: 'Allgemein'
        },
        {
            label: '/setskill',
            description: 'Jobskills setzen',
            category: 'Stats'
        },
        {
            label: '/ka',
            description: 'Kofferraum ansehen',
            category: 'Allgemein'
        },
        {
            label: '/drein',
            description: 'Drogen in Safebox reinlegen',
            category: 'Allgemein'
        },
        {
            label: '/draus',
            description: 'Drogen aus Safebox rausnehmen',
            category: 'Allgemein'
        },
        {
            label: '/srein',
            description: 'Spice in Safebox reinlegen',
            category: 'Allgemein'
        },
        {
            label: '/sraus',
            description: 'Spice aus Safebox rausnehmen',
            category: 'Allgemein'
        },
        {
            label: '/wrein',
            description: 'Waffenteile in Safebox reinlegen',
            category: 'Allgemein'
        },
        {
            label: '/wraus',
            description: 'Waffenteile aus Safebox rausnehmen',
            category: 'Allgemein'
        },
        {
            label: '/crein',
            description: 'Codes in Safebox reinlegen',
            category: 'Allgemein'
        },
        {
            label: '/craus',
            description: 'Codes aus Safebox rausnehmen',
            category: 'Allgemein'
        },
        {
            label: '/cd',
            description: '/cd',
            category: 'Allgemein'
        },
        {
            label: '/wl',
            description: '/Waffenlager',
            category: 'Allgemein'
        },
        {
            label: '/kb',
            description: 'Kanister benutzen',
            category: 'Allgemein'
        },
        {
            label: '/kk',
            description: 'Kanister kaufen',
            category: 'Allgemein'
        },
        {
            label: '/wp1',
            description: 'Waffenpack I kaufen',
            category: 'Waffen'
        },
        {
            label: '/wp2',
            description: 'Waffenpack II kaufen',
            category: 'Waffen'
        },
        {
            label: '/wp3',
            description: 'Waffenpack III kaufen',
            category: 'Waffen'
        },
        {
            label: '/wp4',
            description: 'Waffenpack IV kaufen',
            category: 'Waffen'
        },
        {
            label: '/weste',
            description: 'Weste kaufen',
            category: 'Waffen'
        },
        {
            label: '/deagle',
            description: 'Deagle kaufen',
            category: 'Waffen'
        },
        {
            label: '/shot',
            description: 'Shotgun kaufen',
            category: 'Waffen'
        },
        {
            label: '/mp5',
            description: 'MP5 kaufen',
            category: 'Waffen'
        },
        {
            label: '/ak',
            description: 'AK47 kaufen',
            category: 'Waffen'
        },
        {
            label: '/m4',
            description: 'M4 kaufen',
            category: 'Waffen'
        },
        {
            label: '/rifle',
            description: 'Rifle kaufen',
            category: 'Waffen'
        },
        {
            label: '/sniper',
            description: 'Sniper kaufen',
            category: 'Waffen'
        },
        {
            label: '/9mm',
            description: '9mm kaufen',
            category: 'Waffen'
        },
        {
            label: '/sp',
            description: 'Silenced Pistol kaufen',
            category: 'Waffen'
        },
        {
            label: '/basi',
            description: 'Baseballschläger kaufen',
            category: 'Waffen'
        },
        {
            label: '/golf',
            description: 'Golfschläger kaufen',
            category: 'Waffen'
        },
        {
            label: '/sr',
            description: 'Schlagring kaufen',
            category: 'Waffen'
        },
        {
            label: '/relog',
            description: 'Reloggen ohne GTA neuzustarten',
            category: 'Allgemein'
        },
        {
            label: '/cclearchat',
            description: 'Clearchat',
            category: 'Allgemein'
        },
        {
            label: '/maske',
            description: '/hitmanmaske',
            category: 'Fraktion'
        },
        {
            label: '/handy',
            description: 'Toggle Handystatus',
            category: 'Fraktion'
        },
        {
            label: '/hw',
            description: '/hitmanwaffen & /gheilen',
            category: 'Fraktion'
        },
        {
            label: '/gw',
            description: '/gangwaffen & /gheilen',
            category: 'Fraktion'
        },
        {
            label: '/mtanken',
            description: 'Automatisch dein Auto tanken',
            category: 'Allgemein'
        },
        {
            label: '/gfi',
            description: '/gangfightinfo',
            category: 'Fraktion'
        },
        {
            label: '/ovhelp',
            description: 'Overlay Hilfe im Chat anzeigen',
            category: 'Overlay'
        },
        {
            label: '/ovmove',
            description: 'Overlay verschieben',
            category: 'Overlay'
        }
    ];

    public dropdownSelectionChanged($event: DropdownChangeEvent): void {
        document.getElementById('scrollContainer').scrollTo({ top: 0 });
    }

    public getFilteredItems(): any {
        if (this.selectedFilter.label === 'Alle') {
            return this.tbList.sort((a, b) => a.label.localeCompare(b.label));
        }

        return this.tbList
            .filter((item) => item.category === this.selectedFilter.label)
            .sort((a, b) => a.label.localeCompare(b.label));
    }
}
