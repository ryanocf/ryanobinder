/* DEFAULTS */
import { Component } from '@angular/core';
/**/

/* IMPORTS */
import { AfterViewInit, OnDestroy, OnInit } from '@angular/core';
import { SharedModule } from 'src/app/app.module';
import { RouterLink } from '@angular/router';

    /* TYPES */
    import { IRoute } from 'src/app/shared/route';
    /**/

    /* RXJS */
    import { Observable, Subscription } from 'rxjs';
    /**/

    /* STORE */
    import { Select, Store } from '@ngxs/store';
    /**/

    /* PRIMENG */
    import { ButtonModule } from 'primeng/button';
    import { SidebarModule } from 'primeng/sidebar';
    import { TabMenuModule } from 'primeng/tabmenu';
    import { PanelMenuModule } from 'primeng/panelmenu';
    import { SelectButtonModule } from 'primeng/selectbutton';
    /**/

/**/

@Component({
    selector: 'app-navbar',
    standalone: true,
    imports: [
        SharedModule,
        ButtonModule,
        SelectButtonModule,
        SidebarModule,
        TabMenuModule,
        PanelMenuModule
    ],
    providers: [
        Store
    ],
    templateUrl: './navbar.component.html',
    styleUrl: './navbar.component.scss',
    styles: [':host { z-index: 10; position: absolute;}']
})
export class NavbarComponent implements OnInit, AfterViewInit, OnDestroy {
    constructor(
        private store: Store
    ) { }

    private subscriptions: Subscription[] = [];

    @Select() route$!: Observable<IRoute>;
    route!: IRoute;
    
    public appName = `${window.NL_NAME} ${window.NL_APPVERSION}`;
    private ratio = window.devicePixelRatio;
    private dragging = false;
    private posX = 0;
    private posY = 0;

    public async closeWindow(): Promise<void> {
        await Neutralino.app.killProcess();
    }

    public async minimizeWindow(): Promise<void> {
        await Neutralino.window.minimize();
    }

    private dragWindow(): void {
        const draggable = document.getElementById('dragWindow');

        // Listen to mouse down
        draggable.onmousedown = (e: MouseEvent) => {
            this.ratio = window.devicePixelRatio
            
            this.posX = e.pageX * this.ratio, this.posY = e.pageY * this.ratio;
            this.dragging = true;
        }
        
        // Patch for monitors with scaling enabled that somehow still break, allows them to detach from the titlebar anywhere
        window.onmouseup = (e: MouseEvent) => {
            this.dragging = false;
        }
        
        document.onmousemove = (e: MouseEvent) => {
            if (this.dragging) {
                Neutralino.window.move(e.screenX * this.ratio - this.posX, e.screenY * this.ratio - this.posY);
            }
        }
    }

    ngOnInit(): void {
        this.subscriptions.push(
            this.route$.subscribe({
                next: (res) => {
                    this.route = res;
                },
                error: (e) => {},
            }),
        )
    }

    async ngAfterViewInit(): Promise<void> {
        const drag = document.getElementById('dragWindow') as HTMLElement
        await Neutralino.window.setDraggableRegion(drag, { alwaysCapture: true, dragMinDistance: 10 });
        // this.dragWindow();
    }

    ngOnDestroy(): void {
        this.subscriptions.forEach(sub => sub.unsubscribe());
    }
}
