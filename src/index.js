const os = require("os");
const fs = require("fs");
const path = require("path");
const log = require("electron-log");
const electron = require("electron");
const { protocol, app, shell, session } = electron;
const { ProxyHandler } = require("./proxy");

const URL_MAIN = "https://www.shararam.ru/";
const BKG_COLOR = "#60b3b3";
const WIN_WIDTH = 1320;
const WIN_HEIGHT = 740;
const SHARARAM_UA = "Shararam/2.0.6";

class Launcher {
    constructor() {
        log.transports.file.level = "debug";
        log.info(`${app.getName()} ${app.getVersion()} starting`);

        this._pathNatives = this._getResourcePath("natives");
        this._pathSwf = this._getResourcePath("swf");
        this._pathMods = this._getResourcePath("mods");

        if (!fs.existsSync(this._pathMods))
            fs.mkdirSync(this._pathMods);

        this._initFlash();
        this._initProxy();
    }

    _getResourcePath(resPath) {
        return app.isPackaged ?
            path.resolve(process.resourcesPath, resPath) :
            path.resolve(__dirname, "..", resPath);
    }

    _initFlash() {
        const pluginName = os.arch() === "ia32" ? "pepflashplayer_32.dll" : "pepflashplayer.dll";
        app.commandLine.appendSwitch("ppapi-flash-path", path.join(this._pathNatives, pluginName));
        app.commandLine.appendSwitch("ppapi-flash-version", "23.0.0.164");
    }

    _initProxy() {
        this._proxy = new ProxyHandler();
        this._proxy.on("request", this._requestHandler);
        this._proxy.on("response", this._responseHandler);
    }

    _registerProtocols() {
        protocol.interceptBufferProtocol("https", this._proxy.handle);
    }

    _requestHandler = (req) => {
        const url = new URL(req.url);
        url.searchParams.delete("noproxy");
        req.url = url.href;

        if (/^(www\.)?shararam\.ru$/.test(url.hostname) && url.pathname.startsWith("/sml/")) {
            log.debug(`SML request: ${url.pathname}`);
            if (url.pathname === "/sml/mods.xml") {
                let xml = "<sml:mods>";
                for (const mod of fs.readdirSync(this._pathMods)) {
                    xml += `<sml:mod path="${mod}" />`;
                }
                xml += "</sml:mods>";
                req.response = { data: Buffer.from(xml) };
            } else if (url.pathname.startsWith("/sml/mods/")) {
                const swfPath = path.join(this._pathMods, url.pathname.replace(/^\/sml\/mods\//g, ""));
                if (!/^$|^\.\.\/?/.test(path.relative(this._pathMods, swfPath)) && fs.existsSync(swfPath))
                    req.response = { data: fs.readFileSync(swfPath) };
                else
                    req.response = { statusCode: 404, data: Buffer.from("Resource not found") };
            }
        }
    };

    _responseHandler = (req, res) => {
        const url = new URL(req.url);
        if (url.searchParams.has("noproxy"))
            return;
        switch (url.hostname) {
            case "www.shararam.ru":
            case "shararam.ru":
                if (url.pathname.endsWith(".swf")) {
                    log.debug(`Intercepting SWF request: ${url.pathname}`);
                    const localPath = path.join(this._pathSwf, url.pathname.slice(1).replace(/^fs\//, ""));
                    if (fs.existsSync(localPath)) {
                        log.debug(`Found patch for ${url.pathname}, sending local file`);
                        res.data = fs.readFileSync(localPath);
                    } else {
                        log.debug(`Patch not found, sending server file`);
                    }
                }
                break;
        }
    };

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
        this._registerProtocols();
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
                .replace(`${app.getName().replace(/ /g, "")}/${app.getVersion()}`, SHARARAM_UA)
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

        this._tray = new electron.Tray(path.join(__dirname, "../res/shararam.ico"));
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

function main() {
    if (require("electron-squirrel-startup")) app.quit();

    const launcher = new Launcher();
    launcher.start();
}

main();