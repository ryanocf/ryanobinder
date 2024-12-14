
/* DEFAULTS */
import { Component } from '@angular/core';
/**/

/* IMPORTS */
import { AfterViewInit, OnInit } from '@angular/core';
import { SharedModule } from 'src/app/app.module';
import { RouterLink, RouterLinkActive } from '@angular/router';

    /* SERVICES */
    import { UserService } from 'src/app/services/user/user.service';
    import { UtilityService } from 'src/app/services/utility/utility.service';
    /**/

    /* PRIMENG */
    import { RippleModule } from 'primeng/ripple';
    import { ContextMenuModule } from 'primeng/contextmenu';
    import { MessageService } from 'primeng/api';
    import { MenuItem } from 'primeng/api/menuitem';
    /**/

    /* OTHER */
    import anime from 'animejs'
    /**/

/**/

@Component({
    selector: 'app-sidebar',
    standalone: true,
    imports: [
        SharedModule,
        RouterLink,
        RouterLinkActive,
        RippleModule,
        ContextMenuModule
    ],
    templateUrl: './sidebar.component.html',
    styleUrl: './sidebar.component.scss'
})
export class SidebarComponent implements OnInit, AfterViewInit {
    constructor(
        public userService: UserService,
        private messageService: MessageService,
        private utilityService: UtilityService
    ) {}

    public items = [
        {
            label: 'Home',
            description: 'Stats & Links',
            icon: 'mdi mdi-36px mdi-home-variant-outline',
            routerLink: '/',
        },
        {
            label: 'Keybinds',
            description: 'Dynamic / Static Hotkeys',
            icon: 'mdi mdi-36px mdi-keyboard-variant',
            routerLink: '/keybinds'
        },
        {
            label: 'Textbinds',
            description: 'Chat Shortcuts',
            icon: 'mdi mdi-36px mdi-text',
            routerLink: '/textbinds'
        },
        {
            label: 'Overlay',
            description: 'Visuals on Screen',
            icon: 'mdi mdi-36px mdi-monitor-shimmer',
            routerLink: '/overlay'
        },
        {
            label: 'Miscellaneous',
            description: 'Functions & Systems',
            icon: 'mdi mdi-36px mdi-cog',
            routerLink: '/misc'
        },
        // {
        //     label: 'Admin Panel',
        //     description: 'Manage Users & Application',
        //     icon: 'mdi mdi-36px mdi-crown-outline',
        //     routerLink: '/admin'
        // }
    ];
    
    public activeItem = this.items[0];
    public open: 1 | 0 | -1 = 1;

    public contextItems: MenuItem[] = [
        {
            label: 'Reload',
            icon: 'mdi mdi-reload',
            command: async () => {
                const cached: string = this.userService.avatar;
                this.userService.avatar = await this.userService.getRawAvatar(this.userService.forum).catch((e) => {
                    this.messageService.add({ severity: 'warn', summary: 'Warning', detail: this.utilityService.formatError(e), life: 5000 });
                    return this.userService.avatar;
                });

                if (cached !== this.userService.avatar) {
                    await Neutralino.storage.setData('avatar', this.userService.avatar)
                }
            }
        }
    ]

    public toggle(event: Event) {
        const target = (event.target as HTMLElement);
        const icon = target.querySelector('.mdi') || target;

        if (icon.classList.contains('mdi-lock-outline')) {
            icon.classList.add('mdi-lock-open-variant-outline');
            icon.classList.remove('mdi-lock-outline');
        }
        else {
            icon.classList.add('mdi-lock-outline');
            icon.classList.remove('mdi-lock-open-variant-outline');
        }
    }

    public sidebarEnterCallback(anim: { [key: string]: anime.AnimeInstance }): void {
        if (
            !document
            .querySelector('.sidebar-static-icon > .mdi')
            .classList
            .contains('mdi-lock-open-variant-outline') ||
            this.open == 1
        )
        {
            return;
        }

        if (this.open != -1) {
            anim['.sidebar'].play();
            anim['.sidebar-toggler-icon'].play();
            anim['.sidebar-content'].play();
            anim['#content'].play();

            this.open = -1;
            setTimeout(() => {
                this.open = 1;
            }, 200)
        }
    }

    public sidebarLeaveCallback(anim: any): void {
        if (
            !document
            .querySelector('.sidebar-static-icon > .mdi')
            .classList
            .contains('mdi-lock-open-variant-outline') ||
            this.open == 0
        )
        {
            return;
        }

        if (this.open != -1) {
            anim['.sidebar'].play();
            anim['.sidebar-toggler-icon'].play();
            anim['.sidebar-content'].play();
            anim['#content'].play();

            this.open = -1;
            setTimeout(() => {
                this.open = 0;
            }, 200)
        }
    }
    
    ngOnInit(): void {}

    ngAfterViewInit(): void {
        let sidebarEl = document.getElementsByClassName('sidebar')[0];
        //let contentEl = document.getElementById('content');

        let enterAnim = {
            '.sidebar': anime({
                targets: '.sidebar',
                left: ['-250px', '0px'],
                easing: 'easeInOutQuad',
                duration: 200,
                autoplay: false
            }),

            '.sidebar-toggler-icon': anime({
                targets: '.sidebar-toggler-icon',
                opacity: [1, 0],
                easing: 'easeInOutQuad',
                duration: 200,
                autoplay: false
            }),

            '.sidebar-content': anime({
                targets: '.sidebar-content',
                opacity: [0, 1],
                easing: 'easeInOutQuad',
                duration: 200,
                autoplay: false
            }),

            '#content': anime({
                targets: '#content',
                left: ['40px', '290px'],
                width: ['930px', '680px'],
                easing: 'easeInOutQuad',
                duration: 200,
                autoplay: false
            })
        }

        let leaveAnim = {
            '.sidebar': anime({
                targets: '.sidebar',
                left: ['0px', '-250px'],
                easing: 'easeInOutQuad',
                duration: 200,
                autoplay: false
            }),

            '.sidebar-toggler-icon': anime({
                targets: '.sidebar-toggler-icon',
                opacity: [0, 1],
                easing: 'easeInOutQuad',
                duration: 200,
                autoplay: false
            }),

            '.sidebar-content': anime({
                targets: '.sidebar-content',
                opacity: [1, 0],
                easing: 'easeInOutQuad',
                duration: 200,
                autoplay: false
            }),
    
            '#content': anime({
                targets: '#content',
                left: ['290px', '40px'],
                width: ['680px', '930px'],
                easing: 'easeInOutQuad',
                duration: 200,
                autoplay: false
            })
        }

        sidebarEl.addEventListener('mouseenter', () => {
            this.sidebarEnterCallback(enterAnim)
        });

        sidebarEl.addEventListener('mouseleave', () => {
            this.sidebarLeaveCallback(leaveAnim)
        });
    }
}
