/* DEFAULTS */
import { Component } from '@angular/core';
/**/

/* IMPORTS */
import { SharedModule } from 'src/app/app.module';

	/* PRIMENG */
	import { ProgressSpinnerModule  } from 'primeng/progressspinner';
	import { ProgressBarModule } from 'primeng/progressbar';
	/**/
/**/

@Component({
	selector: 'app-loading',
	standalone: true,
	imports: [
		SharedModule,
		ProgressSpinnerModule,
		ProgressBarModule
	],
	templateUrl: './loading.component.html',
	styleUrl: './loading.component.scss'
})
export class LoadingComponent {
	constructor() { }
}
