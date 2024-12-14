/* DEFAULTS */
import { Component } from '@angular/core';
/**/

/* IMPORTS */
import { OnDestroy, OnInit } from '@angular/core';
import { SharedModule } from 'src/app/app.module';
import { FormsModule } from '@angular/forms';

    /* SERVICES */
    import { FilesService } from 'src/app/services/files/files.service';
    /**/

    /* RXJS */
    import { Observable, Subscription } from 'rxjs';
    /**/

    /* PRIMENG */
    import { InputSwitchChangeEvent, InputSwitchModule } from 'primeng/inputswitch';
    import { InputTextModule } from 'primeng/inputtext';
    import { InputNumberInputEvent, InputNumberModule } from 'primeng/inputnumber';
    import { RippleModule } from 'primeng/ripple';
    import { ColorPickerChangeEvent, ColorPickerModule } from 'primeng/colorpicker';
    /**/

    /* OTHERS */
    import ini from 'ini';
    /**/

/**/

@Component({
    selector: 'app-overlay',
    standalone: true,
    imports: [
        SharedModule,
        InputSwitchModule,
        InputTextModule,
        InputNumberModule,
        RippleModule,
        FormsModule,
        ColorPickerModule
    ],
    templateUrl: './overlay.component.html',
    styleUrl: './overlay.component.scss'
})
export class OverlayComponent implements OnInit, OnDestroy {
    constructor(
        private filesService: FilesService
    ) {}

    private subscriptions: Subscription[] = [];

    private overlay$: Observable<any> = this.filesService.overlay$;
    public overlay!: any;

    public overlayList = [
        {
            label: 'Health',
            color: '',
            size: '',
            font: '',
            state: false,
            ahk: 'HP'
        },
        {
            label: 'Armor',
            color: '',
            size: '',
            font: '',
            state: false,
            ahk: 'Armor'
        },
        {
            label: 'Position',
            color: '',
            size: '',
            font: '',
            state: false,
            ahk: 'Position'
        },
        {
            label: 'Vehicle',
            color: '',
            size: '',
            font: '',
            state: false,
            ahk: 'Vehicle'
        },
        {
            label: 'Maske',
            color: '',
            size: '',
            font: '',
            state: false,
            ahk: 'Mask'
        },
    ]

    public switchStateChanged(event: InputSwitchChangeEvent, i: number): void {
        this.overlayList[i].state = event.checked;
        this.saveOverlay();
    }

    public colorContentChanged(event: ColorPickerChangeEvent, i: number): void {
        this.overlayList[i].color = String(event.value).replace('#', '');
        this.saveOverlay();
    }

    public sizeContentChanged(event: InputNumberInputEvent, i: number): void {
        this.overlayList[i].size = String(event.value);
        this.saveOverlay();
    }

    public fontContentChanged(event: Event, i: number): void {
        const target = event.target as HTMLInputElement;
        this.overlayList[i].font = target.value;
        this.saveOverlay();
    }

    private updateOverlay(): void {
        this.overlayList.forEach((item, i) => {
            this.overlayList[i] = {
                ...this.overlayList[i],
                state: this.overlay[item.ahk]['status'] === '1' ? true : false,
                color: this.overlay[item.ahk]['color'],
                size: this.overlay[item.ahk]['size'],
                font: this.overlay[item.ahk]['font']
            }
        });
    }

    private async saveOverlay(): Promise<void> {
        this.overlayList.forEach((item, i) => {
            this.overlay[item.ahk]['status'] = item.state ? '1' : '0';
            this.overlay[item.ahk]['color'] = item.color;
            this.overlay[item.ahk]['size'] = item.size;
            this.overlay[item.ahk]['font'] = item.font;
        });

        await this.filesService.saveFile(`${window.NL_CWD}/data/configs`, 'overlay.ini', ini.stringify(this.overlay));
    }

    ngOnInit(): void {
        this.subscriptions.push(
            this.overlay$.subscribe({
                next: (res) => {
                    this.overlay = res;
                    this.updateOverlay();
                }
            })
        );
    }

    ngOnDestroy(): void {
        this.subscriptions.forEach(sub => sub.unsubscribe());
    }
}
