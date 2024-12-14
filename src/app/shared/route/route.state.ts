/* IMPORTS */
import { Injectable } from '@angular/core';
import { SetRoute, SetRouteUrl } from './route.actions';

    /* TYPES */
    import { IRoute } from '.';
    /**/

    /* STORE */
    import { State, Action, StateContext } from '@ngxs/store';
    /**/

/**/

@State<IRoute>({
    name: 'route',
    defaults: {
        url: '',
        paths: []
    }
})
@Injectable()
export class RouteState {

    constructor() {}

    @Action(SetRoute)
    public SetRoute({ setState }: StateContext<IRoute>, { payload }: SetRoute) {
        payload.paths = payload.paths.filter(x => x !== '');
        setState(payload);
    }
    
    @Action(SetRouteUrl)
    public SetRouteUrl({ patchState }: StateContext<IRoute>, { payload }: SetRouteUrl) {
        patchState({ url: payload });
    }
}