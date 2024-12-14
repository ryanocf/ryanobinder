/* DEFAULTS */
import { Component } from '@angular/core';
/**/

/* IMPORTS */
import { OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { SharedModule } from 'src/app/app.module';

    /* SERVICES */
    import { FormService } from 'src/app/services/form/form.service';
    import { UserService } from 'src/app/services/user/user.service';
    import { UtilityService } from 'src/app/services/utility/utility.service';
    /**/

    /* PRIMENG */
    import { MessageService } from 'primeng/api';
    import { ButtonModule } from 'primeng/button';
    import { IconFieldModule } from 'primeng/iconfield';
    import { InputGroupModule } from 'primeng/inputgroup';
    import { InputIconModule } from 'primeng/inputicon';
    import { InputTextModule } from 'primeng/inputtext';
    import { TagModule } from 'primeng/tag';
    /**/

/**/

@Component({
    selector: 'app-setup',
    standalone: true,
    imports: [
        SharedModule,
        InputGroupModule,
        InputTextModule,
        InputIconModule,
        IconFieldModule,
        ButtonModule,
        TagModule
    ],
    templateUrl: './setup.component.html',
    styleUrl: './setup.component.scss'
})
export class SetupComponent implements OnInit {
    constructor(
        private formService: FormService,
        private formBuilder: FormBuilder,
        private messageService: MessageService,
        public userService: UserService,
        private utilityService: UtilityService
    ) {
        this.rootForm = this.formBuilder.group({
            UsernameControl: ['', [
                Validators.required
            ]],
            ForumUrlControl: ['', [ 
                Validators.required
            ]]
        });
    }

    public rootForm!: FormGroup;
    public rootFormLoading: boolean = false;

    public handleSave(): boolean {
        return !this.formService.isFormComplete(this.rootForm) || this.rootFormLoading;
    }

    public async saveData(): Promise<void> {
        this.rootFormLoading = true;

        try {
            const username = this.rootForm.get('UsernameControl')?.value;
            const forum = this.rootForm.get('ForumUrlControl')?.value;

            if (forum.search('lyd-roleplay.de') < 0) {
                throw 'Forum URL must be from lyd-roleplay.de';
            }

            await Neutralino.storage.setData('username', username);
            await Neutralino.storage.setData('forum', forum);
            this.userService.forum = forum;
            this.userService.username = username;

            const base64Img = await this.userService.getRawAvatar(forum).catch((e) => {
                this.messageService.add({ severity: 'warn', summary: 'Warning', detail: this.utilityService.formatError(e), life: 5000 });
                return this.userService.defaultAvatar;
            });

            if (base64Img !== this.userService.defaultAvatar) {
                await Neutralino.storage.setData('avatar', base64Img);
            }
            this.userService.avatar = base64Img;
        } catch (e) {
            this.rootFormLoading = false;
            let err = this.utilityService.formatError(e);
            this.messageService.add({ severity: 'error', summary: 'Error', detail: err, life: 5000 });
        }
    }

    public handleControlError(control: string): string {
        const formControl = this.rootForm.get(control);

        switch (control) {
            case 'UsernameControl':
                return this.formService.getRequiredError(formControl)

            case 'ForumUrlControl':
                return this.formService.getRequiredError(formControl)

            default:
                return '';
        }
    }

    ngOnInit(): void {
        
    }
}
