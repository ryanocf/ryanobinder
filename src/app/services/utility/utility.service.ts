/* DEFAULTS */
import { Injectable } from '@angular/core';
/**/

/* IMPORTS */
import { Location } from '@angular/common';

    /* PRIMENG */
    import { Tag } from 'primeng/tag';
    /**/

/**/

interface ILogEntry {
    severity: Tag['severity'],
    value: string
}

@Injectable({
    providedIn: 'root'
})
export class UtilityService {
    constructor(
        private loc: Location,
    ) { }

    private _logs: ILogEntry[] = [];

    public get logs(): ILogEntry[] {
        return this._logs
    }

    public set logs(log: ILogEntry) {
        this._logs.push(log);
    }

    public preventDefault(event: Event): void {
        event.stopPropagation();
        event.preventDefault();
    }

    public formatError(e: any): string {
        if (e instanceof Error) {
            e = e.message;
        } else if (typeof e === 'object') {
            e = JSON.stringify(e);
        } else {
            e = String(e);
        }

        return e;
    }

    public hexToBuffer(hex: string): Uint8Array {
        return new Uint8Array(hex.match(/.{1,2}/g).map(byte => parseInt(byte, 16)));
    }

    public bufferToHex(buf: Uint8Array): string {
        return Array.from(buf, i => i.toString(16).padStart(2, "0")).join('');
    }

    public base64ToBuffer(b64: string): Uint8Array {
        return Uint8Array.from(atob(b64), c => c.charCodeAt(0))
    }

    public BufferToBase64(buf: Uint8Array): string {
        return btoa(buf.reduce(function (data, byte) {
            return data + String.fromCharCode(byte);
        }, ''));
    }
}
