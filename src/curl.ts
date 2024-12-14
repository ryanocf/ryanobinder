interface ICurlResponse {
    statusLine: string,
    status: number,
    headers: { [key: string]: any },
    body: any
}

class Curl
{
    constructor () {}

    private defaultHeaders = {
        'User-Agent': `${window.NL_APPID}`
    }

    private formatResponse(res: string) {
        const [headersRaw, ...bodyPartsRaw] = res.split('\r\n\r\n');
        let body = bodyPartsRaw.join('\r\n\r\n'); 

        // Parse headers
        const headerLines = headersRaw.split('\r\n');
        const statusLine = headerLines.shift();
        const status = Number(statusLine.split(/\s/)[1]);
        const headers = {};

        headerLines.forEach(line => {
            const [key, value] = line.split(/:\s(.+)/);
            if (key && value) {
                headers[key.trim()] = value.trim();
            }
        });

        if (headers?.['Content-Type']?.includes('application/json')) {
            body = JSON.parse(body)
        }
      
        return { statusLine, status, headers, body };
    }

    private formatHeaders(headers: { [key: string]: any }): string {
        let headersFormatted = '';

        for (let [key, value] of Object.entries(headers)) {
            headersFormatted += `-H "${key}: ${value}" `;
        }

        for (let [key, value] of Object.entries(this.defaultHeaders)) {
            headersFormatted += `-H "${key}: ${value}" `;
        }

        return headersFormatted;
    }

    public async get(url: string, headers: { [key: string]: any } = {}): Promise<ICurlResponse> {
        return await this.run(`-s -i ${this.formatHeaders(headers)} ${url}`);
    }

    public async post(url: string, data: any, headers: { [key: string]: any } = {}): Promise<ICurlResponse> {
        return await this.run(`-s -i -X POST ${this.formatHeaders(headers)} ${url} -d "${data}"`);
    }

    public async binary(url: string, output: string): Promise<Uint8Array> {
        const temp = await Neutralino.os.getEnv('TEMP');
        await this.run(`-s ${url} --output ${temp}/${output}`, true);

        const file = await Neutralino.filesystem.readBinaryFile(`${temp}/${output}`);
        return new Uint8Array(file);
    }

    private async run(args: string, binary: boolean = false): Promise<any> {
        let cmd = await Neutralino.os.spawnProcess(`curl.exe ${args}`);

        return new Promise (async (resolve, reject) => {
            let data = '';
            let instance!: any;

            await Neutralino.events.on('spawnedProcess', instance = async (evt) => {
                if(cmd.id !== evt.detail.id) {
                    return
                }

                switch (evt.detail.action) {
                    case 'stdOut':
                        if (evt.detail.data !== 0) {
                            data += evt.detail.data
                        }
                        break;

                    case 'stdErr':
                        console.log(evt.detail)
                        break;

                    case 'exit':
                        if (evt.detail.data === 0) {
                            const formatted = this.formatResponse(data);
                            resolve(formatted);
                        } else {
                            reject(`Error trying to cURL with: 'curl.exe ${args}'`)
                        }

                        await Neutralino.events.off('spawnedProcess', instance);
                        return;
                        break;
                }
            });
        });
    }
}

export default Curl;