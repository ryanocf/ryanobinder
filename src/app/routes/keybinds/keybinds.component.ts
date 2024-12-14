/* DEFAULTS */
import { Component } from '@angular/core';
/**/

/* IMPORTS */
import { OnDestroy, OnInit } from '@angular/core';
import { SharedModule } from 'src/app/app.module';

    /* SERVICES */
    import { FilesService } from 'src/app/services/files/files.service';
    import { HotkeysService } from 'src/app/services/hotkeys/hotkeys.service';
    /**/

    /* RXJS */
    import { Observable, Subscription } from 'rxjs';
    /**/

    /* PRIMENG */
    import { ButtonModule } from 'primeng/button';
    import { InputTextModule } from 'primeng/inputtext';
    import { RippleModule } from 'primeng/ripple';
    import { TabMenuModule } from 'primeng/tabmenu';
    import { MenuItem } from 'primeng/api';
    /**/

    /* OTHERS */
    import hotkeyjs from 'hotkeys-js';
    import ini from 'ini';
    /**/

/**/

@Component({
    selector: 'app-keybinds',
    standalone: true,
    imports: [
        SharedModule,
        ButtonModule,
        InputTextModule,
        RippleModule,
        TabMenuModule
    ],
    templateUrl: './keybinds.component.html',
    styleUrl: './keybinds.component.scss'
})
export class KeybindsComponent implements OnInit, OnDestroy {
    constructor(
        private filesService: FilesService,
        private hotkeysService: HotkeysService
    ) { }

    private subscriptions: Subscription[] = [];

    private hotkeys$: Observable<any> = this.filesService.hotkeys$;
    public hotkeys!: any;

    public hotkeyList = [];
    public activeHotkeyIndex = -1;
    public activeHotkeyElement!: HTMLElement;

    // public tabList: MenuItem[] = [
    //     {
    //         label: 'Generell',
    //         icon: 'mdi mdi-keyboard-variant'
    //     },
    //     {
    //         label: 'Weaponpack',
    //         icon: 'mdi mdi-pistol'
    //     }
    // ];

    // public activeTabItem = this.tabList[0];

    public activeTabItemChanged($event: MenuItem): void {
        //document.getElementById('scrollContainer').scrollTo({ top: 0 });
    }

    public clickHandler = (event: MouseEvent) => {
        const target = event.target as HTMLElement;
        const exist = target.closest('div[data-hotkey]') as HTMLElement;
        if (exist !== null) {
            return;
        }

        this.activeHotkeyIndex = -1;
        this.activeHotkeyElement = null;
    }

    public setActiveHotkey(event: MouseEvent, i: number) {
        const target = event.target as HTMLElement;

        this.activeHotkeyIndex = i;
        this.activeHotkeyElement = target.closest('div[data-hotkey]');
    }

    private updateHotkeyList(): void {
        this.hotkeyList = [
            {
                key: this.hotkeys['Hotkeys']['Own1'],
                content: '+1 Kill',
                disabled: true
            },
            {
                key: this.hotkeys['Hotkeys']['Own2'],
                content: '+1 Death',
                disabled: true
            },
            {
                key: this.hotkeys['Hotkeys']['Own3'],
                content: 'Repeat last message',
                disabled: true
            }
        ];

        Array(17).fill(0).forEach((x, i) => {
            this.hotkeyList.push({
                key: this.hotkeys['Hotkeys'][`Own${i + 4}`],
                content: this.hotkeys['Contents'][`BOwn${i + 4}`],
                disabled: false
            })
        });
    }

    public hotkeyContentChanged(event: Event, i: number) {
        const target = event.target as HTMLInputElement
        this.hotkeyList[i].content = target.value;
        this.saveHotkeyList();
    } 

    private async saveHotkeyList(): Promise<void> {
        this.hotkeyList.forEach((obj, i) => {
            this.hotkeys['Hotkeys'][`Own${i + 1}`] = this.hotkeysService.translateHotkey(obj.key.split(/\+(.*)/s), true).join('');
            this.hotkeys['Contents'][`BOwn${i + 1}`] = obj.content;
        });

        await this.filesService.saveFile(`${window.NL_CWD}/data/configs`, 'hotkeys.ini', ini.stringify(this.hotkeys));
    }

    ngOnInit(): void {
        this.subscriptions.push(
            this.hotkeys$.subscribe({
                next: (res) => {
                    this.hotkeys = res;
                    this.updateHotkeyList();
                }
            })
        );

        hotkeyjs('*', (event, handler) => {
            const length = hotkeyjs.getPressedKeyCodes().length;
            let keys = this.hotkeysService.translateHotkey(hotkeyjs.getPressedKeyString().sort().reverse());

            if (this.activeHotkeyIndex === -1) {
                return;
            }

            if (keys.includes('backspace') || keys.includes('esc')) {
                this.hotkeyList[this.activeHotkeyIndex].key = ''
                this.activeHotkeyIndex = -1;
                this.activeHotkeyElement = null;
                this.saveHotkeyList();
                return;
            }

            if (!keys.every((k) => this.hotkeysService.allowedKeys.includes(k))) {
                return;
            }

            if (!hotkeyjs.alt && !hotkeyjs.ctrl && !hotkeyjs.shift) {
                keys = [keys[0]];
            }

            if (this.hotkeyList.some((x) => x.key == keys.join('+'))) {
                return;
            }

            if (
                (hotkeyjs.alt || hotkeyjs.ctrl || hotkeyjs.shift) && length === 2 ||
                (!hotkeyjs.alt && !hotkeyjs.ctrl && !hotkeyjs.shift) && length === 1
            ) {
                this.hotkeyList[this.activeHotkeyIndex].key = keys.join('+');
                this.activeHotkeyIndex = -1;
                this.activeHotkeyElement = null;
                this.saveHotkeyList();
            }
        });

        window.addEventListener('click', this.clickHandler);
    }

    ngOnDestroy(): void {
        this.subscriptions.forEach(sub => sub.unsubscribe());
        hotkeyjs.unbind('*');
        window.removeEventListener('click', this.clickHandler);
    }
}
