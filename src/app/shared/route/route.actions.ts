/* IMPORTS */

    /* TYPES */
    import { IRoute } from '.';
    /**/
    
/**/

export class SetRoute {
    static readonly type = '[route] set';
    constructor(public payload: IRoute) {}
}
export class SetRouteUrl {
    static readonly type = '[route] set url';
    constructor(public payload: string) {}
}