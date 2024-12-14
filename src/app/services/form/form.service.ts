/* DEFAULTS */
import { Injectable } from '@angular/core';
/**/

/* IMPORTS */
import { AbstractControl, FormGroup, ValidationErrors } from '@angular/forms';
/**/

@Injectable({
    providedIn: 'root'
})
export class FormService {
    constructor() {}

    public getFormValidationErrors(form: FormGroup): any[] {
        const result: any[] = [];
        Object.keys(form.controls).forEach(key => {
            const controlErrors: ValidationErrors | null | undefined = form.get(key)?.errors;

            if (controlErrors) {
                Object.keys(controlErrors).forEach(e => {
                    result.push({
                        control: key,
                        error: e,
                        value: controlErrors[e]
                    });
                });
            }
        });
    
        return result;
    }

    public isFormComplete(form: FormGroup): boolean {
        return this.getFormValidationErrors(form).length < 1;
    }

    public getRequiredError(form: AbstractControl | null): string {
        return form?.hasError('required') ? 'This field is required!' : '';
    }

    public getEmailError(form: AbstractControl | null): string {
        return form?.hasError('email') ? 'You must enter a valid email!' : '';
    }

    public getEmailPatternError(form: AbstractControl | null): string {
        return form?.hasError('emailPattern') ? 'You must enter a valid email!' : '';
    }

    public getPatternError(form: AbstractControl | null): string {
        return form?.hasError('pattern') ? 'You must enter a valid pattern!' : '';
    }

    public getMinLengthError(form: AbstractControl | null): string {
        const error = form?.errors?.['minlength'];
        return form?.hasError('minlength') ? `Your input is too short! Characters needed: ${error.requiredLength - error.actualLength}` : '';
    }

    public getMaxLengthError(form: AbstractControl | null): string {
        const error = form?.errors?.['maxlength'];
        return form?.hasError('maxlength') ? `Your input is too long! Characters too much: ${error.requiredLength - error.actualLength}` : '';
    }

    public getExistError(form: AbstractControl | null): string {
        return form?.hasError('exists') ? 'Provided value does not exist!' : '';
    }

    public exists(check: any[]): (control: AbstractControl) => ValidationErrors | null {
        return (control: AbstractControl): ValidationErrors | null => {
            if (!control.value || typeof control.value === 'undefined') return { required: true };

            if (!check.find(x => x === control.value)) {
                return { exists: true };
            }
            
            return null;
        }
    }
}