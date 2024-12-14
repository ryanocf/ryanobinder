/* DEFAULTS */
import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component';
/**/

/* IMPORTS */
import { enableProdMode } from '@angular/core';
import { environment } from './environments/environment';

import Curl from './curl';

    /* OTHERS */
    import * as neutralinojs from '@neutralinojs/lib';
    import { polyfillCountryFlagEmojis } from "country-flag-emoji-polyfill";
    /**/

/**/

polyfillCountryFlagEmojis();

if (environment.production) {
    enableProdMode();
}

bootstrapApplication(AppComponent, appConfig)
    .catch((err) => console.error(err));

Neutralino.events.on('ready', async () => {
    await Neutralino.window.show();
    const vars = Object.entries(window)
    .filter(([k, v]) => k.startsWith('NL_'))
    .reduce((obj, w) => {
        obj[w[0]] = w[1];
        return obj
    }, {})
    console.info(
        `dump window`,
        vars
    )
});

Neutralino.init();
declare global {
    interface Window {
        curl: Curl;
        
        NL_NAME: string
    }
}
window.curl = new Curl();