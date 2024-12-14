/* DEFAULTS */
import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
/**/

/* IMPORTS */
import { OnDestroy, OnInit } from '@angular/core'
import { SharedModule } from './app.module';
import { NavigationEnd, Router, RouterEvent } from '@angular/router';
import { MarkdownComponent } from 'ngx-markdown';
import { environment } from 'src/environments/environment';

    /* SERVICES */
    import { UserService } from './services/user/user.service';
    import { FilesService } from './services/files/files.service';
    /**/

    /* RXJS */
    import { filter } from 'rxjs';
    /**/

    /* STORE */
    import { Store } from '@ngxs/store';
    import { SetRoute } from './shared/route/route.actions';
    /**/

    /* PRIMENG */
    import { ToastModule } from 'primeng/toast';
    import { ConfirmationService, MessageService } from 'primeng/api';
    import { DialogModule } from 'primeng/dialog';
    import { SelectButtonModule } from 'primeng/selectbutton';
    import { ButtonModule } from 'primeng/button';
    import { ConfirmDialogModule } from 'primeng/confirmdialog';
    /**/

    /* ROUTES */
    import { NavbarComponent } from './components/navbar/navbar.component';
    import { SidebarComponent } from './components/sidebar/sidebar.component';
    import { LoadingComponent } from './components/loading/loading.component';
    import { SetupComponent } from './components/setup/setup.component';
    /**/

/**/

@Component({
    selector: 'app-root',
    standalone: true,
    imports: [
        SharedModule,
        RouterOutlet,
        ToastModule,
        DialogModule,
        SelectButtonModule,
        ButtonModule,
        MarkdownComponent,
        ConfirmDialogModule,

        NavbarComponent,
        SidebarComponent,
        LoadingComponent,
        SetupComponent
    ],
    providers: [
        ConfirmationService
    ],
    templateUrl: './app.component.html',
    styleUrl: './app.component.scss',
    styles: [':host { position: relative; }']
})
export class AppComponent implements OnInit, OnDestroy {
    constructor(
        private router: Router,
        private store: Store,
        public userService: UserService,
        private filesService: FilesService,
        private confirmationService: ConfirmationService,
        private messageService: MessageService
    ) {
        this.router.events.pipe(
            filter((e: any): e is NavigationEnd => e instanceof NavigationEnd)
        ).subscribe((e: RouterEvent) => {
            this.currentRoute = e.url;
            const splitRoute = this.currentRoute.split('/').filter((x) => x !== '');

            this.store.dispatch([
                new SetRoute({
                    url: this.currentRoute,
                    paths: splitRoute
                })
            ]);
        });
    }

    public root!: HTMLElement;
    public currentRoute: string = '/';
    private _init = false;

    public languageOptions = [
        { label: '🇩🇪', value: 'de' },
        { label: '🇺🇸', value: 'en' }
    ];
    public language = this.languageOptions[0];

    public updateVisible = false;
    public termsVisible = false;

    public time = 0;

    private async init(): Promise<void> {
        if (this._init) {
            return;
        }

        this._init = true;
        const timer = setInterval(() => {
            this.time++;
        }, 1)

        await this.userService.setup();
        clearInterval(timer);
    }

    public async agreeTerms(): Promise<void> {
        this.termsVisible = false;
        await Neutralino.storage.setData('terms', 'true');

        await this.checkUpdate();
    }

    public async declineTerms(): Promise<void> {
        await Neutralino.app.killProcess();
    }

    private async checkTerms(): Promise<void> {
        const terms = await Neutralino.storage.getData('terms').catch((e) => false);
        
        if (!Boolean(terms)) {
            this.termsVisible = true;
        } else {
            await this.checkUpdate();
        }
    }

    private async checkUpdate(): Promise<void> {
        let manifest = await Neutralino.updater.checkForUpdates(`${environment.endpoint}/ryanobinder/manifest.json`);
        const file = await Neutralino.filesystem.readFile(`${window.NL_CWD}/update.json`);
        const fileJson = JSON.parse(file);

        if (fileJson['binderVersion'] != manifest.data.binderVersion) {
            const res = await this.filesService.downloadFile(
                `${environment.endpoint}/ryanobinder/files/${environment.binderName}.exe`,
                `${window.NL_CWD}/data/files`,
                `${environment.binderName}.exe`,
                true
            );
            this.messageService.add({
                severity: res ? 'success' : 'error',
                summary: res ? 'Success' : 'Error',
                detail: `${res ? 'Updated' : 'Failed to update'} binder to version ${manifest.data.binderVersion}`, life: 5000
            });
            if (res) {
                await Neutralino.filesystem.writeFile(`${window.NL_CWD}/update.json`, `{ "binderVersion": "${manifest.data.binderVersion}" }`);
            }
        }

        if (manifest.version != window.NL_APPVERSION) {
            this.confirmationService.confirm({
                header: 'Update',
                icon: 'mdi mdi-update',
                message: `Neue Version ${manifest.version} verfügbar!`,
                acceptLabel: 'Download',
                acceptIcon: 'pi pi-download mr-2',
                acceptButtonStyleClass: 'font-bold',
                rejectLabel: 'Abbruch',
                rejectIcon: 'none',
                rejectButtonStyleClass: 'p-button-text',
                closeOnEscape: false,
                accept: async () => {
                    await Neutralino.updater.install();
                    await Neutralino.app.restartProcess();
                },
                reject: async () => {
                    await Neutralino.app.killProcess();
                }
            })
        } else {
            await this.init();
        }
    }

    async ngOnInit(): Promise<void> {
        await this.checkTerms();

        // const files = await Neutralino.resources.getFiles();
        // console.log("Files: ", files)
    }
    
    ngOnDestroy(): void {}
}
