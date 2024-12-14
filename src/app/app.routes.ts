/* DEFAULTS */
import { Routes } from '@angular/router';
/**/

/* IMPORTS */

    /* ROUTES */
    import { HomeComponent } from './routes/home/home.component';
    import { KeybindsComponent } from './routes/keybinds/keybinds.component';
    import { TextbindsComponent } from './routes/textbinds/textbinds.component';
    import { OverlayComponent } from './routes/overlay/overlay.component';
    import { MiscComponent } from './routes/misc/misc.component';
    /**/
/**/

export const routes: Routes = [
    { path: '', component: HomeComponent },
    { path: 'keybinds', component: KeybindsComponent },
    { path: 'textbinds', component: TextbindsComponent },
    { path: 'overlay', component: OverlayComponent },
    { path: 'misc', component: MiscComponent },
];
