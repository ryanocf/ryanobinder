/* DEFAULTS */
import { Component } from '@angular/core';
/**/

/* IMPORTS */
import { OnDestroy, OnInit } from '@angular/core';
import { SharedModule } from 'src/app/app.module';

    /* SERVICES */
    import { FilesService } from 'src/app/services/files/files.service';
    /**/

    /* RXJS */
    import { Observable, Subscription } from 'rxjs';
    /**/

    /* PRIMENG */
    import { InputSwitchChangeEvent, InputSwitchModule } from 'primeng/inputswitch';
    import { InputTextModule } from 'primeng/inputtext';
    import { AccordionModule } from 'primeng/accordion';
    import { RippleModule } from 'primeng/ripple';
    /**/

    /* OTHERS */
    import ini from 'ini';
    /**/

/**/

interface IMisc {
    label: string,
    description: string,
    ahk: string,
    items: {
        label: string,
        description: string,
        state: boolean,
        ahk: string,
        extra?: {
            element?: 'input',
            content?: string,
            ahk: string
        }
    }[]
}

@Component({
    selector: 'app-misc',
    standalone: true,
    imports: [
        SharedModule,
        InputSwitchModule,
        RippleModule,
        AccordionModule,
        InputTextModule
    ],
    templateUrl: './misc.component.html',
    styleUrl: './misc.component.scss'
})
export class MiscComponent implements OnInit, OnDestroy {
    constructor(
        private filesService: FilesService,
    ) {}

    private subscriptions: Subscription[] = [];

    private misc$: Observable<any> = this.filesService.misc$;
    public misc!: any;

    public miscList: IMisc[] = [
        {
            label: 'Generell',
            description: 'Universell für alle',
            ahk: 'General',
            items: [
                {
                    label: 'Verlustanzeige',
                    description: 'Zeigt erlittenen Schaden im Chat an',
                    state: false,
                    ahk: 'verlust'
                },
                {
                    label: 'Automatisch Helm',
                    description: 'Setzt beim aufsteigen eines Motorrads den Helm an/auf',
                    state: false,
                    ahk: 'autohelm'
                },
                {
                    label: 'Blitzerschutz',
                    description: 'Bremst das Fahrzeug kurz vor Blitzern runter',
                    state: false,
                    ahk: 'blitzercheck'
                },
                {
                    label: 'Automatisch /motor & /licht',
                    description: 'Sendet automatisch /motor & /licht beim einsteigen eines Fahrzeugs',
                    state: false,
                    ahk: 'autoML'
                },
                {
                    label: 'Tanken per Knopfdruck',
                    description: 'Mit der Taste < an Tankstellen automatisch tanken',
                    state: false,
                    ahk: 'offerrefill'
                },
                {
                    label: 'Zoll per Knopfdruck',
                    description: 'Mit der Taste < Zollstationen automatisch bezahlen',
                    state: false,
                    ahk: 'offercustoms'
                }
            ]
        },
        {
            label: 'Fraktion',
            description: 'Für alle Fraktionen',
            ahk: 'Faction',
            items: [
                {
                    label: 'Killspruch',
                    description: 'Sendet Killspruch in den /fc Chat',
                    state: false,
                    ahk: 'GSpruch',
                    extra: {
                        element: 'input',
                        content: '',
                        ahk: 'FSpruch'
                    }
                }
            ]
        },
        {
            label: 'Hitman',
            description: '🥷',
            ahk: 'Hitman',
            items: [
                {
                    label: 'Automatisch finden',
                    description: 'Sucht beim Annehmen eines Auftrags das Opfer',
                    state: false,
                    ahk: 'autodete'
                },
                {
                    label: 'Automatisch Maske',
                    description: 'Setzt beim Annehmen eines Auftrags die Maske auf',
                    state: false,
                    ahk: 'automaske'
                },
                {
                    label: 'Automatisch Screen',
                    description: 'Erstellt beim Annehmen eines Auftrags einen Screenshot',
                    state: false,
                    ahk: 'autoscreen'
                },
                {
                    label: 'Handystatus [aus]',
                    description: 'Schaltet beim Annehmen eines Auftrags das Handy aus',
                    state: false,
                    ahk: 'autohandy'
                },
            ]
        }
    ];

    public switchStateChanged(event: InputSwitchChangeEvent, iCategory: number, iItem: number): void {
        this.miscList[iCategory].items[iItem].state = event.checked;
        this.saveMisc();
    }

    public inputContentChanged(event: Event, iCategory: number, iItem: number): void {
        const target = event.target as HTMLInputElement;
        this.miscList[iCategory].items[iItem].extra.content = target.value;
        this.saveMisc();
    }

    private updateMisc(): void {
        this.miscList.forEach((category, iCategory) => {
            category.items.forEach((item, iItem) => {
                this.miscList[iCategory].items[iItem].state = this.misc[category.ahk][item.ahk] === '1' ? true : false;

                const extraAhk = this.miscList[iCategory].items[iItem]?.extra?.ahk
                switch (this.miscList[iCategory].items[iItem]?.extra?.element) {
                    case 'input':
                        this.miscList[iCategory].items[iItem].extra.content = this.misc[category.ahk][extraAhk];
                        break;

                    default:
                        break;
                }
            })
        });
    }

    private async saveMisc(): Promise<void> {
        this.miscList.forEach((category, iCategory) => {
            category.items.forEach((item, iItem) => {
                this.misc[category.ahk][item.ahk] = item.state ? '1' : '0';

                const extraAhk = this.miscList[iCategory].items[iItem]?.extra?.ahk
                switch (this.miscList[iCategory].items[iItem]?.extra?.element) {
                    case 'input':
                        this.misc[category.ahk][extraAhk] = this.miscList[iCategory].items[iItem].extra.content;
                        break;

                    default:
                        break;
                }
            });
        })

        await this.filesService.saveFile(`${window.NL_CWD}/data/configs`, 'misc.ini', ini.stringify(this.misc));
    }

    ngOnInit(): void {
        this.subscriptions.push(
            this.misc$.subscribe({
                next: (res) => {
                    this.misc = res;
                    this.updateMisc();
                }
            })
        );
    }

    ngOnDestroy(): void {
        this.subscriptions.forEach(sub => sub.unsubscribe());
    }
}
