const os = require("os");
const fs = require("fs");
const path = require("path");
const log = require("electron-log");
const electron = require("electron");
const { protocol, app, shell, net, session } = electron;

const URL_MAIN = "https://www.shararam.ru/";
const BKG_COLOR = "#60b3b3";
const WIN_WIDTH = 1320;
const WIN_HEIGHT = 740;
const SHARARAM_UA = "Shararam/2.0.6";

class Main {
    constructor() {
        log.transports.file.level = "debug";
        log.info(`${app.getName()} ${app.getVersion()} starting`);

        this._pathNatives = path.join(process.resourcesPath, "natives");
        if (!fs.existsSync(this._pathNatives))
            this._pathNatives = path.join(__dirname, "natives");
    
        this._pathSwf = path.join(process.resourcesPath, "swf");
        if (!fs.existsSync(this._pathSwf))
            this._pathSwf = path.join(__dirname, "swf");

        this._initFlash();
    }

    _initFlash() {
        const pluginName = os.arch() === "ia32" ? "pepflashplayer_32.dll" : "pepflashplayer.dll";
        app.commandLine.appendSwitch("ppapi-flash-path", path.join(this._pathNatives, pluginName));
        app.commandLine.appendSwitch("ppapi-flash-version", "23.0.0.164");
    }

    _registerProtocol() {
        protocol.interceptBufferProtocol("https", async (req, callback) => {
            const request = net.request({
                url: req.url,
                method: req.method,
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
                    let body = Buffer.concat(data);
                    body = this._processRequest(req, body);
                    callback({
                        statusCode: res.statusCode,
                        headers: res.headers,
                        data: body
                    });
                });
                res.on("error", () => {
                    callback({ error: -100 });
                });
            });

            request.on("error", () => {
                callback({ error: -104 });
            });
        });
    }

    _processRequest(req, data) {
        const url = new URL(req.url);
        switch (url.hostname) {
            case "www.shararam.ru":
            case "shararam.ru":
                if (url.pathname.endsWith(".swf")) {
                    log.debug(`Intercepting SWF request: ${url.pathname}`);
                    const localPath = path.join(this._pathSwf, url.pathname.slice(1).replace(/^fs\//, ""));
                    if (fs.existsSync(localPath)) {
                        log.debug(`Found patch for ${url.pathname}, sending local file`);
                        return fs.readFileSync(localPath);
                    }
                    log.debug(`Patch not found, sending server file`);
                }
        }
        return data;
    }

    _onStart() {
        const instanceLock = app.requestSingleInstanceLock();
        if (instanceLock) {
            app.on("second-instance", () => this._onSecondInstance());
            app.on("ready", () => this._onReady());
            app.on("window-all-closed", () => {
                app.quit();
            });

            app.on("browser-window-created", (_e, wnd) => {
                wnd.setMenuBarVisibility(false);
            });
        } else {
            app.quit();
        }
    }

    _onSecondInstance() {
        this._tryActivateWindow(this._wndMain);
    }

    _onReady() {
        this._registerProtocol();
        this._createStartupWindow();
    }

    _createStartupWindow() {
        this._createTray();
        this._createMainWindow();
    }

    _createMainWindow() {
        if (this._wndMain)
            throw new Error("Main window already exists");

        this._wndMain = new electron.BrowserWindow({
            width: WIN_WIDTH,
            height: WIN_HEIGHT,
            webPreferences: {
                webSecurity: false,
                plugins: true,
                nodeIntegration: false,
                allowRunningInsecureContent: true,
                allowDisplayingInsecureContent: true,
                experimentalFeatures: true,
                nativeWindowOpen: true,
                affinity: "window"
            },
            backgroundColor: BKG_COLOR
        });

        this._wndMain.maximize();

        this._wndMain.on("hide", () => this._onWndMainHide());
        this._wndMain.on("show", () => this._onWndMainShow());

        this._wndMain.webContents.setUserAgent(
            this._wndMain.webContents.getUserAgent()
                .replace(`${app.name}/${app.getVersion()}`, SHARARAM_UA)
        );
        this._wndMain.loadURL(URL_MAIN);
    }

    _onWndMainHide() {
        this._wndMain.webContents.audioMuted = true;
    }

    _onWndMainShow() {
        this._wndMain.webContents.audioMuted = false;
    }

    _createTray() {
        const contextMenu = electron.Menu.buildFromTemplate([
            {
                label: "Очистить кэш",
                click: () => this._onTrayClearCache()
            }, {
                label: "Открыть папку патчей",
                click: () => this._onTrayOpenPatchFolder()
            }, {
                type: "separator"
            }, {
                label: "Закрыть",
                click: () => this._onTrayClose()
            }
        ]);

        this._tray = new electron.Tray(`${__dirname}/shararam.ico`);
        this._tray.setToolTip("Шарарам*");
        this._tray.setContextMenu(contextMenu);
        this._tray.on("click", () => this._showMainWindow());
    }

    _onTrayClearCache() {
        session.defaultSession.clearCache();
    }

    _onTrayOpenPatchFolder() {
        shell.openPath(this._pathSwf);
    }

    _onTrayClose() {
        app.quit();
    }

    start = () => this._onStart();
}

(() => {
    new Main().start();
})();