/* DEFAULTS */
import { Component } from '@angular/core';
/**/

/* IMPORTS */
import { AfterViewInit, OnDestroy, OnInit } from '@angular/core';
import { SharedModule } from 'src/app/app.module';

    /* SERVICES */
    import { UserService } from 'src/app/services/user/user.service';
    import { UtilityService } from 'src/app/services/utility/utility.service';
    import { FilesService } from 'src/app/services/files/files.service';
    /**/

    /* RXJS */
    import { Observable, Subscription } from 'rxjs';
    /**/

    /* PRIMENG */
    import { ButtonModule } from 'primeng/button';
    /**/

    /* OTHERS */
    /**/

/**/

@Component({
    selector: 'app-home',
    standalone: true,
    imports: [
        SharedModule,
        ButtonModule
    ],
    templateUrl: './home.component.html',
    styleUrl: './home.component.scss'
})
export class HomeComponent implements OnInit, AfterViewInit, OnDestroy {
    constructor(
        public userService: UserService,
        private utilityService: UtilityService,
        private filesService: FilesService
    ) {}

    private subscriptions: Subscription[] = [];

    private stats$: Observable<any> = this.filesService.stats$;
    public stats!: any;

    private serverInfo$: Observable<any> = this.userService.serverInfo$;
    public serverInfo!: any;

    public dmStats = [
        {
            icon: 'mdi mdi-target',
            total: 0,
            today: 0
        },
        {
            icon: 'mdi mdi-coffin',
            total: 0,
            today: 0
        },
        {
            icon: 'mdi mdi-approximately-equal',
            total: 0,
            today: 0
        },
        {
            icon: 'mdi mdi-chart-line',
            total: '0.00',
            today: '0.00'
        }
    ]

    public globalStats = [
        {
            label: 'Players Online',
            content: '?/?'
        },
        {
            label: 'Keybinder Users',
            content: '?'
        },
        {
            label: 'Level',
            content: '?'
        },
        {
            label: 'Respektpunkte',
            content: '?/?'
        }
    ];

    public async openUrl(url: string): Promise<void> {
        await Neutralino.os.open(url);
    }

    ngOnInit(): void {
        this.subscriptions.push(
            this.stats$.subscribe({
                next: (res) => {
                    this.stats = res;

                    if (Object.keys(res).length <= 0) {
                        return;
                    }

                    let level = this.stats['Globals']['level'];
                    let rp = this.stats['Globals']['rp'].split('/');
                    
                    this.globalStats[2].content = `${Number(level) || '?'}`;
                    this.globalStats[3].content = `${Number(rp[0]) || '?'}/${Number(rp[1]) || '?'}`;

                    let kills = Number(this.stats['Globals']['kills']);
                    let deaths = Number(this.stats['Globals']['deaths']);
                    let diff = kills - deaths;
                    let kd = Number(kills / (deaths === 0 ? 1 : deaths)).toFixed(2);

                    let tkills = Number(this.stats['Daily']['kills']);
                    let tdeaths = Number(this.stats['Daily']['deaths']);
                    let tdiff = tkills - tdeaths;
                    let tkd = Number(tkills / (tdeaths === 0 ? 1 : tdeaths)).toFixed(2);

                    this.dmStats[0].total = kills;
                    this.dmStats[0].today = tkills;

                    this.dmStats[1].total = deaths 
                    this.dmStats[1].today = tdeaths

                    this.dmStats[2].total = diff;
                    this.dmStats[2].today = tdiff;

                    this.dmStats[3].total = kd;
                    this.dmStats[3].today = tkd;
                }
            }),
            this.serverInfo$.subscribe({
                next: (res) => {
                    this.serverInfo = res;

                    const current = typeof this.serverInfo?.core?.pc !== 'number' ? '?' : this.serverInfo?.core?.pc;
                    const max = typeof this.serverInfo?.core?.pm !== 'number' ? '?' : this.serverInfo?.core?.pm

                    this.globalStats[0].content = `${current}/${max}`;
                }
            })
        )
    }

    ngAfterViewInit(): void { }

    ngOnDestroy(): void {
        this.subscriptions.forEach(sub => sub.unsubscribe());
    }
}
