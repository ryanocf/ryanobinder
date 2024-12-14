import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TextbindsComponent } from './textbinds.component';

describe('TextbindsComponent', () => {
  let component: TextbindsComponent;
  let fixture: ComponentFixture<TextbindsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TextbindsComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(TextbindsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
