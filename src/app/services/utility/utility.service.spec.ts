import { TestBed } from '@angular/core/testing';

import { UtilityService } from './utility.service';
import { AppModule } from 'src/app/app.module';
import { Location } from '@angular/common';

describe('UtilityService', () => {
    let service: UtilityService;
    let loc: Location;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [
                AppModule
            ]
        });
        service = TestBed.inject(UtilityService);
        loc = TestBed.inject(Location)
    });

    it('should be created', () => {
        expect(service).toBeTruthy();
    });
});
