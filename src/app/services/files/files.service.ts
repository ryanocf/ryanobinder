/* DEFAULTS */
import { Injectable } from '@angular/core';
/**/

/* IMPORTS */
import { environment } from 'src/environments/environment';

    /* SERVICES */
    import { HotkeysService } from '../hotkeys/hotkeys.service';
    /**/

    /* RXJS */
    import { BehaviorSubject } from 'rxjs';
    /**/

    /* OTHERS */
    import ini from 'ini';
    /**/

/**/

@Injectable({
    providedIn: 'root'
})
export class FilesService {

    constructor(
        private hotkeysService: HotkeysService
    ) {
        Neutralino.events.on('watchFile', async (evt) => {
            if (evt.detail.id !== this._folderWatcherId) {
                return;
            }

            if (this._files.find((file => file.filename == evt.detail.filename)) === undefined) {
                return;
            }

            switch (evt.detail.action) {
                case 'add':
                case 'delete':
                case 'moved':
                    break;

                case 'modified':
                    if (evt.detail.filename.slice(-4) !== '.ini') {
                        break;
                    }

                    const content = await Neutralino.filesystem.readFile(`${evt.detail.dir}/${evt.detail.filename}`);
                    this[evt.detail.filename.replace('.ini', '')] = ini.parse(content);                    
                    break;
            }
        });
    }

    private _init = false;
    private _folderWatcherId!: number;

    private gtaId = 0;
    private gtaName = 'gta_sa';
    private binderId = 0;
    
    private _stats = new BehaviorSubject({
        Date: {
            day: "01",
            month: "01",
            year: "1990",
            date: "01.01.1990"
        },
        Globals: {
            kills: "0",
            deaths: "0",
            level: "0",
            rp: "0/0"
        },
        Daily: {
            kills: "0",
            deaths: "0"
        }
    });
    public stats$ = this._stats.pipe();

    private _overlay = new BehaviorSubject<{ [key: string]: any }>({
        Globals: {
            textdraws: "0"
        },
        HP: {
            status: "0",
            x: "717",
            y: "93",
            size: "6",
            color: "FFFFFF",
            font: "Arial"
        },
        Armor: {
            status: "0",
            x: "717",
            y: "63",
            size: "6",
            color: "FFFFFF",
            font: "Arial"
        },
        Position: {
            status: "0",
            x: "686",
            y: "101",
            size: "6",
            color: "FFFFFF",
            font: "Arial"
        },
        Vehicle: {
            status: "0",
            x: "8",
            y: "373",
            size: "6",
            color: "FFFFFF",
            font: "Arial"
        },
        Mask: {
            status: "0",
            x: "602",
            y: "421",
            size: "6",
            color: "FFFFFF",
            font: "Arial"
        },
        // Enemy: {
        //     status: "0",
        //     x: "765",
        //     y: "93",
        //     size: "6",
        //     color: "FFFFFF",
        //     font: "Arial"
        // }
    });
    public overlay$ = this._overlay.pipe();

    private _hotkeys = new BehaviorSubject<{ [key: string]: any }>({
        Hotkeys: {
            Own1: "",
            Own2: "",
            Own3: "",
            Own4: "",
            Own5: "",
            Own6: "",
            Own7: "",
            Own8: "",
            Own9: "",
            Own10: "",
            Own11: "",
            Own12: "",
            Own13: "",
            Own14: "",
            Own15: "",
            Own16: "",
            Own17: "",
            Own18: "",
            Own19: "",
            Own20: "",
            WPOwn1: "",
            WPOwn2: "",
            WPOwn3: "",
            WPOwn4: ""
        },
        Contents: {
            BOwn1: "",
            BOwn2: "",
            BOwn3: "",
            BOwn4: "",
            BOwn5: "",
            BOwn6: "",
            BOwn7: "",
            BOwn8: "",
            BOwn9: "",
            BOwn10: "",
            BOwn11: "",
            BOwn12: "",
            BOwn13: "",
            BOwn14: "",
            BOwn15: "",
            BOwn16: "",
            BOwn17: "",
            BOwn18: "",
            BOwn19: "",
            BOwn20: ""
        }
    });
    public hotkeys$ = this._hotkeys.pipe();

    private _misc = new BehaviorSubject<{ [key: string]: any }>({
        General: {
            verlust: "0",
            autohelm: "0",
            blitzercheck: "0",
            autoML: "0",
            offerrefill: "0",
            offercustoms: "0"
        },
        Faction: {
            FSpruch: "",
            GSpruch: "0"
        },
        Hitman: {
            autodete: "0",
            automaske: "0",
            autoscreen: "0",
            autohandy: "0"
        },
    });
    public misc$ = this._misc.pipe();

    private _settings = new BehaviorSubject<{ [key: string]: any }>({
        WP: {
            wp1w1: "1",
            wp1w2: "1",
            wp1w3: "1",
            wp1w4: "1",
            wp1w5: "1",
            wp2w1: "1",
            wp2w2: "1",
            wp2w3: "1",
            wp2w4: "1",
            wp2w5: "1",
            wp3w1: "1",
            wp3w2: "1",
            wp3w3: "1",
            wp3w4: "1",
            wp3w5: "1",
            wp4w1: "1",
            wp4w2: "1",
            wp4w3: "1",
            wp4w4: "1",
            wp4w5: "1"
        },
        Skill: {
            detective: "0",
            whore: "0",
            attorney: "0",
            gf: "0",
            drugs: "0",
            wp: "0"
        },
        Possession: {
            drugs: "0",
            spice: "0",
            wp: "0",
            codes: "0",
            cookies: "0"
        },
        Safebox: {
            drugs: "0",
            spice: "0",
            wp: "0",
            codes: "0"
        },
        Startwar: {
            ballassw: "0",
            gsfsw: "0",
            vagossw: "0",
            aztecassw: "0",
            triadensw: "0",
            outlawzsw: "0",
            yakuzasw: "0",
            lcnsw: "0",
            copsw: "0",
            ndsw: "0"
        }
    });
    public settings$ = this._settings.pipe();

    private _files = [
        {
            content: ini.stringify(this._stats.value),
            dst: `${window.NL_CWD}/data/configs`,
            filename: 'stats.ini'
        },
        {
            content: ini.stringify(this._overlay.value),
            dst: `${window.NL_CWD}/data/configs`,
            filename: 'overlay.ini'
        },
        {
            content: ini.stringify(this._hotkeys.value),
            dst: `${window.NL_CWD}/data/configs`,
            filename: 'hotkeys.ini'
        },
        {
            content: ini.stringify(this._misc.value),
            dst: `${window.NL_CWD}/data/configs`,
            filename: 'misc.ini'
        },
        {
            content: ini.stringify(this._settings.value),
            dst: `${window.NL_CWD}/data/configs`,
            filename: 'settings.ini'
        },
    ];

    private _binaries = [
        {
            url: `${environment.endpoint}/ryanobinder/dll/API.dll`,
            dst: `${window.NL_CWD}/data/dll`,
            filename: 'API.dll'
        },
        {
            url: `${environment.endpoint}/ryanobinder/dll/dx9_overlay.dll`,
            dst: `${window.NL_CWD}/data/dll`,
            filename: 'dx9_overlay.dll'
        },
        {
            url: `${environment.endpoint}/ryanobinder/dll/sampcac-loader.dll`,
            dst: `${window.NL_CWD}/data/dll`,
            filename: 'sampcac-loader.dll'
        },
        {
            url: `${environment.endpoint}/ryanobinder/dll/sampcac-loader.exe`,
            dst: `${window.NL_CWD}/data/dll`,
            filename: 'sampcac-loader.exe'
        },
        {
            url: `${environment.endpoint}/ryanobinder/files/${environment.binderName}.exe`,
            dst: `${window.NL_CWD}/data/files`,
            filename: `${environment.binderName}.exe`
        }
    ];

    private set stats(obj: any) {
        console.log('set stats to ->', obj)
        this._stats.next(obj);
    }

    private set overlay(obj: any) {
        console.log('set overlay to ->', obj)
        this._overlay.next(obj);
    }
    
    private set hotkeys(obj: any) {
        Object.entries(obj['Hotkeys']).forEach(([k, v]) => {
            obj['Hotkeys'][k] = this.hotkeysService.translateAHK((v as string).split(/(?=[+^!])|(?<=[+^!])/g)).join('+');
        });

        console.log('set hotkeys to ->', obj)
        this._hotkeys.next(obj);
    }

    private set misc(obj: any) {
        console.log('set misc to ->', obj)
        this._misc.next(obj);
    }
    
    private set settings(obj: any) {
        console.log('set settings to ->', obj)
        this._settings.next(obj);
    }

    private async watchers(): Promise<void> {
        this._folderWatcherId = await Neutralino.filesystem.createWatcher(`${window.NL_CWD}/data/configs`);

        const settingsDir = await Neutralino.filesystem.readDirectory(`${window.NL_CWD}/data/configs`);
        for await (const f of settingsDir) {
            if (f.entry.slice(-4) !== '.ini') {
                continue;
            }

            const content = await Neutralino.filesystem.readFile(f.path);
            this[f.entry.replace('.ini', '')] = ini.parse(content);
        }
    }

    private async moveFiles(src: string, dst: string, force = false): Promise<void> {
        const srcDir = await Neutralino.filesystem.readDirectory(src);
        
        const dstDir = await Neutralino.filesystem.getStats(dst).catch(async (e) => {
            await Neutralino.filesystem.createDirectory(dst);
            return await Neutralino.filesystem.getStats(dst);
        });

        for await (const f of srcDir) {
            if (force) {
                await Neutralino.filesystem.copy(`${src}/${f.entry}`, `${dst}/${f.entry}`);
            } else {
                await Neutralino.filesystem.getStats(`${dst}/${f.entry}`).catch(async (e) => {
                    await Neutralino.filesystem.copy(`${src}/${f.entry}`, `${dst}/${f.entry}`);
                });
            }
        }
    }

    public async createFile(dst: string, filename: string, content: string, force: boolean = false): Promise<void> {
        let dstDir = await Neutralino.filesystem.getStats(dst).catch(async (e) => {
            await Neutralino.filesystem.createDirectory(dst);
            return await Neutralino.filesystem.getStats(dst);
        });

        dstDir = await Neutralino.filesystem.readDirectory(dst);

        if (dstDir.some((x: any) => x.entry == filename) && !force) {
            return;
        }

        await Neutralino.filesystem.writeFile(`${dst}/${filename}`, content);
    }

    public async saveFile(dst: string, filename: string, content: string): Promise<void> {
        return await this.createFile(dst, filename, content, true);
    }

    public async downloadFile(url: string, dst: string, filename: string, force: boolean = false): Promise<boolean> {
        let dstDir = await Neutralino.filesystem.getStats(dst).catch(async (e) => {
            await Neutralino.filesystem.createDirectory(dst);
            return await Neutralino.filesystem.getStats(dst);
        });

        dstDir = await Neutralino.filesystem.readDirectory(dst);

        if (dstDir.some((x: any) => x.entry == filename) && !force) {
            return true;
        }

        const res = await fetch(url, {
            headers: {
                'pragma': 'no-cache',
                'cache-control': 'no-cache'
            }
        });
        if (res.status != 200) {
            return false;
        } 

        const blob = await res.blob();
        const buffer = await blob.arrayBuffer();

        await Neutralino.filesystem.writeBinaryFile(`${dst}/${filename}`, buffer);
        return true;
    }

    private async checkFolders(): Promise<void> {
        for await (let file of this._files) {
            await this.createFile(file.dst, file.filename, file.content);
        }

        for await (let binary of this._binaries) {
            await this.downloadFile(binary.url, binary.dst, binary.filename);
        }

        for await (let unk of [...this._binaries, ...this._files]) {
            await Neutralino.filesystem.getStats(`${unk.dst}/${unk.filename}`).catch((e) => {
                console.error(e);
            });
        }
    }

    private async startProcess(path: string): Promise<number> {
        await Neutralino.filesystem.getStats(path);
        let cmd = await Neutralino.os.spawnProcess(`powershell.exe "Start-Process -FilePath '${path}' -Verb RunAs -PassThru | select id | fl"`);

        return new Promise (async (resolve, reject) => {
            let data = '';
            let instance!: any;

            await Neutralino.events.on('spawnedProcess', instance = async (evt) => {
                if(cmd.id !== evt.detail.id) {
                    return
                }

                switch (evt.detail.action) {
                    case 'stdOut':
                        const match = /^\w+ : (.*)$/g.exec(evt.detail.data);
                        if (match === null) {
                            return;
                        }

                        if (match.length == 2) {
                            data = match[1]
                        }
                        break;

                    case 'stdErr':
                        console.log(evt.detail)
                        break;

                    case 'exit':
                        if (evt.detail.data === 0) {
                            const processId = Number(data);

                            if (Number.isNaN(processId)) {
                                resolve(0);
                            } else {
                                resolve(processId);
                            }
                        } else {
                            reject(`Error trying to start process ${path}`);
                        }

                        await Neutralino.events.off('spawnedProcess', instance);
                        return;
                        break;
                }
            });
        });
    }

    private async checkProcess(name: string): Promise<number> {
        let cmd = await Neutralino.os.spawnProcess(`powershell.exe "Get-Process '${name}' -ErrorAction Ignore | select id | fl"`);

        return new Promise (async (resolve, reject) => {
            let data = '';
            let instance!: any;

            await Neutralino.events.on('spawnedProcess', instance = async (evt) => {
                if(cmd.id !== evt.detail.id) {
                    return
                }

                switch (evt.detail.action) {
                    case 'stdOut':
                        const match = /^\w+ : (.*)$/g.exec(evt.detail.data);
                        if (match === null) {
                            return;
                        }

                        if (match.length == 2) {
                            data = match[1]
                        }
                        break;

                    case 'stdErr':
                        console.log(evt.detail)
                        break;

                    case 'exit':
                        if (evt.detail.data === 0) {
                            const processId = Number(data);

                            if (Number.isNaN(processId)) {
                                resolve(0);
                            } else {
                                resolve(processId);
                            }
                        } else {
                            reject(`Error trying to locate process ${name}`);
                        }

                        await Neutralino.events.off('spawnedProcess', instance);
                        return;
                        break;
                }
            });
        });
    }

    private async closeProcess(name: string): Promise<number> {
        let cmd = await Neutralino.os.spawnProcess(`powershell.exe "Stop-Process '${name}' -ErrorAction Ignore | select id | fl"`);

        return new Promise (async (resolve, reject) => {
            let data = '';
            let instance!: any;

            await Neutralino.events.on('spawnedProcess', instance = async (evt) => {
                if(cmd.id !== evt.detail.id) {
                    return
                }

                switch (evt.detail.action) {
                    case 'stdOut':
                        const match = /^\w+ : (.*)$/g.exec(evt.detail.data);
                        if (match === null) {
                            return;
                        }

                        if (match.length == 2) {
                            data = match[1]
                        }
                        break;

                    case 'stdErr':
                        console.log(evt.detail)
                        break;

                    case 'exit':
                        if (evt.detail.data === 0) {
                            const processId = Number(data);

                            if (Number.isNaN(processId)) {
                                resolve(0);
                            } else {
                                resolve(processId);
                            }
                        } else {
                            reject(`Error trying to locate process ${name}`);
                        }

                        await Neutralino.events.off('spawnedProcess', instance);
                        return;
                        break;
                }
            });
        });
    }

    private async watchProcesses(): Promise<void> {
        this.binderId = await this.checkProcess(environment.binderName).catch((e) => { return 0 });
        this.gtaId = await this.checkProcess(this.gtaName).catch((e) => { return 0 });

        if (!this.binderId && this.gtaId) {
            this.gtaId = await this.startProcess(`${window.NL_CWD}/data/files/${environment.binderName}.exe`);
            console.log(`binder started: ${this.gtaId}`);
        }

        if (this.binderId && !this.gtaId) {
            await this.closeProcess(environment.binderName);
            console.log(`binder destroyed: ${this.binderId}`);
        }
    }

    public async setup(): Promise<void> {
        if (this._init) {
            return;
        }

        await this.checkFolders();
        await this.watchers();

        const handler = async () => {
            await this.watchProcesses().catch(e => null);
            setTimeout(handler, 500)
        }
        await handler();

        this._init = true;
        return;
    }
}
