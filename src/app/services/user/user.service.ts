/* DEFAULTS */
import { Injectable } from '@angular/core';
/**/

/* IMPORTS */

    /* SERVICES */
    import { UtilityService } from '../utility/utility.service';
    import { FilesService } from '../files/files.service';
    /**/

    /* RXJS */
    import { BehaviorSubject } from 'rxjs';
    /**/

    /* PRIMENG */
    import { MessageService } from 'primeng/api';
    /**/

/**/

@Injectable({
    providedIn: 'root',
})
export class UserService {
    constructor(
        private messageService: MessageService,
        private utilityService: UtilityService,
        private filesService: FilesService
    ) {}

    private _init: boolean = false;

    private _imgMimeType: string = 'data:image/png;base64'
    public defaultAvatar: string = `${this._imgMimeType},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`;

    private _ip: string = '87.106.62.187';
    private _hostname: string = 'samp.lyd-roleplay.de';

    private _username!: string;
    private _forum!: string;
    private _avatar!: string;

    private _serverInfo = new BehaviorSubject<{ [key: string]: any }>({});
    public serverInfo$ = this._serverInfo.pipe();
    private _serverInfoTimeout!: any;
    private _errorHappened = false;

    public get init(): boolean {
        return this._init;
    }

    public get username(): string {
        return this._username;
    }

    public set username(name: string) {
        console.info(`Set username to ${name}`);
        this._username = name;
    }

    public get forum(): string {
        return this._forum;
    }

    public set forum(url: string) {
        console.info(`Set forum to ${url}`);
        this._forum = url;
    }

    public get avatar(): string {
        return this._avatar;
    }

    public set avatar(src: string) {
        console.info(`Set avatar to ${src}`);
        this._avatar = src;
    }

    private set serverInfo(obj: any) {
        console.info(`Set serverInfo to`, obj);
        this._serverInfo.next(obj);
    }

    public async getRawAvatar(url: string) {
        const data = await window.curl.get(`${url}`);
        if (data.status !== 200) {
            throw 'Error trying to get avatar. Default set instead.';
        }

        var el = document.createElement( 'html' );
        el.innerHTML = data.body;

        const what = el.querySelector('.userProfileUser .contentHeaderIcon .userAvatarImage') as HTMLElement;

        const _url = new URL(what.getAttribute('src'));
        const name = _url.pathname.split('/').at(-1);

        const imgData = await window.curl.binary(_url.href, name);
        
        const img = `${this._imgMimeType},${btoa(String.fromCharCode(...imgData))}`;

        return img;
    }

    public async getServerInfo(): Promise<void> {
        try {
            const info = await window.curl.get(`https://api.open.mp/servers/${this._ip}:7777`);
            console.log(info);
            if (info.status !== 200) {
                throw 'Couldn\'t fetch server info';
            }

            this.serverInfo = info.body;
            this._errorHappened = false;
        } catch (e) {
            if (this._errorHappened) {
                return;
            }
            this._errorHappened = true;

            const err = this.utilityService.formatError(e);
            this.messageService.add({ severity: 'error', summary: 'Error', detail: err, life: 5000 });
        }
    }
    
    public async setup(): Promise<void> {
        if (this._init) {
            return;
        }

        try {
            // await this.cryptService.setup();
            // await this.announce();
            await this.filesService.setup();
        } catch (e) {
            console.error(e);
            return;
        }

        const serverInfoHandler = async () => {
            await this.getServerInfo().catch((e) => null);
            this._serverInfoTimeout = setTimeout(serverInfoHandler, 60000);
        }
        await serverInfoHandler();

        try {
            let ipRaw = await window.curl.get(
                `"https://cloudflare-dns.com/dns-query?name=${this._hostname}&cd=true"`,
                { accept: 'application/dns-json' }
            )
            if (ipRaw?.status !== 200) {
                this._ip = JSON.parse(ipRaw?.body)?.Answer?.[0]?.data || this._ip;
                console.error(ipRaw);
            }
        } catch (e) {
            console.error(e);
        }

        try {
            this._username = await Neutralino.storage.getData('username');
            this._forum = await Neutralino.storage.getData('forum');
            this._avatar = await Neutralino.storage.getData('avatar').catch((e) => {
                return '';
            }) || await this.getRawAvatar(this._forum).catch((e) => {
                this.messageService.add({ severity: 'warn', summary: 'Warning', detail: this.utilityService.formatError(e), life: 5000 });
                return this.defaultAvatar;
            });

            if (this._avatar !== this.defaultAvatar) {
                await Neutralino.storage.setData('avatar', this._avatar)
            }
        } catch (e) {
            this._forum = '';
            this._username = '';
            this._avatar = '';

            console.error(e);
        }

        this._init = true;
    }

    public async shutdown(): Promise<void> {
        clearTimeout(this._serverInfoTimeout);
    }
}
