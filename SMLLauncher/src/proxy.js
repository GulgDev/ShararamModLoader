const EventHandler = require("events");
const { net } = require("electron");

class ProxyHandler extends EventHandler {
    handle = (req, callback) => {
        const requestInfo = { url: req.url, method: req.method };
        this.emit("request", requestInfo);
        if (requestInfo.response) {
            callback(requestInfo.response);
            return;
        }

        const request = net.request({
            ...requestInfo,
            partition: "persist:fetch",
            useSessionCookies: true
        });
        for (const [header, value] of Object.entries(req.headers))
            if (header !== "Cookie")
                request.setHeader(header, value);
        if (req.uploadData)
            for (const data of req.uploadData)
                request.write(data.bytes);
        request.end();

        request.on("response", (res) => {
            const data = [];
            res.on("data", (chunk) => data.push(chunk));
            res.on("end", () => {
                const response = {
                    statusCode: res.statusCode,
                    headers: res.headers,
                    data: Buffer.concat(data)
                };
                this.emit("response", req, response);
                callback(response);
            });
            res.on("error", () => {
                callback({ error: -100 });
            });
        });

        request.on("error", () => {
            callback({ error: -104 });
        });
    };
}

module.exports = { ProxyHandler };