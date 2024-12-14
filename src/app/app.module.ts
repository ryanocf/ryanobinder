
/* DEFAULTS */
import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
/**/

/* IMPORTS */
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

    /* PRIMENG */
    import { RippleModule } from 'primeng/ripple';
    import { StyleClassModule } from 'primeng/styleclass';
    /**/

/**/

@NgModule({
    imports: [
        // ...
    ],
    declarations: [
        // ...
    ],
    exports: [
        CommonModule,
        FormsModule,
        ReactiveFormsModule,

        RippleModule,
        StyleClassModule
    ]
})
export class SharedModule { }