export interface IResponse<T = any> {
    success: boolean,   // Easy access to success or failure of request
    status: number,     // HTTP status code
    reason: string,     // API_{FOLDER}_{FILE}_{FUNC}_{DETAIL}
    detail: string,     // Human-readable explaination
    instance: string,   // URI
    response?: T,       // Response from server with type
    additional?: any[], // collection of additional text
}