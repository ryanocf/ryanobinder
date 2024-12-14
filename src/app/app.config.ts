/* DEFAULTS */
import { ApplicationConfig } from '@angular/core';
import { provideRouter } from '@angular/router';
import { routes } from './app.routes';
/**/

/* IMPORTS */
import { APP_INITIALIZER, importProvidersFrom } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { environment } from 'src/environments/environment';

    /* PROVIDERS */
    import { withEnabledBlockingInitialNavigation, withInMemoryScrolling } from '@angular/router';
    import { NgxsModuleOptions, NgxsModule } from '@ngxs/store';
    import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
    import { MessageService, PrimeNGConfig } from 'primeng/api';
    import { HttpClient, provideHttpClient, withFetch, withInterceptors, withNoXsrfProtection } from '@angular/common/http';
    import { MARKED_OPTIONS, provideMarkdown } from 'ngx-markdown';
    /**/

    /* STORE */
    import { RouteState } from './shared/route/route.state';
    /**/

/**/

const ngxsConfig: NgxsModuleOptions = {
    developmentMode: !environment.production,
    selectorOptions: {
        suppressErrors: false,
        injectContainerState: false
    },
    compatibility: {
        strictContentSecurityPolicy: true
    },
};

const initializeAppFactory = (primeConfig: PrimeNGConfig) => () => {
    // ......
    primeConfig.ripple = true;
};


export const appConfig: ApplicationConfig = {
    providers: [
        importProvidersFrom(
            BrowserModule,
            NgxsModule.forRoot([
                RouteState
            ], ngxsConfig)
        ),
        provideAnimationsAsync(),
        provideRouter(
            routes,
            withEnabledBlockingInitialNavigation(),
            withInMemoryScrolling({
                anchorScrolling: 'enabled',
            })
        ),
        MessageService,
        provideHttpClient(
            withNoXsrfProtection(),
            withFetch(),
            withInterceptors([])
        ),
        provideMarkdown({
            loader: HttpClient,
            markedOptions: {
                provide: MARKED_OPTIONS,
                useValue: {
                    gfm: true,
                    breaks: true,
                    pedantic: false,
                },
            },
        }),
        {
            provide: APP_INITIALIZER,
            useFactory: initializeAppFactory,
            deps: [PrimeNGConfig],
            multi: true,
        },
    ]
};
