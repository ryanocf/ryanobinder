/* DEFAULTS */
import { Injectable } from '@angular/core';
/**/

@Injectable({
  providedIn: 'root'
})
export class HotkeysService {

    constructor() { }

    private _allowedKeys = [
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'f1', 'f2', 'f3', 'f4', 'f5', 'f6', 'f7', 'f8', 'f9', 'f10', 'f11', 'f12',
        '.', ',', '-', '<', 'ß', '´', 'alt', 'ctrl', '⇧', 'ä', 'ö', 'ü', 'Ä', 'Ö', 'Ü',
        'NP(0)', 'NP(1)', 'NP(2)', 'NP(3)', 'NP(4)', 'NP(5)', 'NP(5)', 'NP(6)', 'NP(7)', 'NP(8)', 'NP(9)', 'NP(+)', 'NP(-)', 'NP(*)', 'NP(/)'
    ];

    private _replacementKeys = {
        '⌃': 'ctrl',
        '⌥': 'alt',
        '\'': 'Ä',
        '`': 'Ö',
        ';': 'Ü',
        'â': '<',
        '[': 'ß',
        ']': '´',
        'num_0': 'NP(0)',
        'num_1': 'NP(1)',
        'num_2': 'NP(2)',
        'num_3': 'NP(3)',
        'num_4': 'NP(4)',
        'num_5': 'NP(5)',
        'num_6': 'NP(6)',
        'num_7': 'NP(7)',
        'num_8': 'NP(8)',
        'num_9': 'NP(9)',
        'num_add': 'NP(+)',
        'num_subtract': 'NP(-)',
        'num_multiply': 'NP(*)',
        'num_divide': 'NP(/)',
    }

    private _exportKeys = {
        'ctrl': '^',
        'alt': '!',
        '⇧': '+',
        'NP(0)': 'NumpadIns',
        'NP(1)': 'NumpadEnd',
        'NP(2)': 'NumpadDown',
        'NP(3)': 'NumpadPgDn',
        'NP(4)': 'NumpadLeft',
        'NP(5)': 'NumpadClear',
        'NP(6)': 'NumpadRight',
        'NP(7)': 'NumpadHome',
        'NP(8)': 'NumpadUp',
        'NP(9)': 'NumpadPgUp',
        'NP(+)': 'NumpadAdd',
        'NP(-)': 'NumpadSub',
        'NP(*)': 'NumpadMult',
        'NP(/)': 'NumpadDiv',
    }

    public get allowedKeys(): string[] {
        return this._allowedKeys;
    }

    public get replacementKeys(): { [key: string]: string } {
        return this._replacementKeys;
    }

    public get exportKeys(): { [key: string]: string } {
        return this._exportKeys;
    }

    public translateHotkey(keys: string[], ex: boolean = false): string[] {
        let replaced = keys.map((k) => {
            if (Object.keys(this.replacementKeys).includes(k)) {
                k = this.replacementKeys[k];
            }

            if (ex && Object.keys(this.exportKeys).includes(k)) {
                k = this.exportKeys[k];
            }

            return k;
        });

        return replaced;
    }

    public translateAHK(keys: string[]) {
        let replaced = keys.map((k) => {
            if (Object.values(this.exportKeys).includes(k)) {
                k = Object.entries(this.exportKeys).find(([x, y]) => y == k)[0];
            }

            return k;
        })

        return replaced;
    }
}
