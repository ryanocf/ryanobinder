<div align="center">
    <img src="src/assets/images/logo.png" width="128px" />
</div>

<div align="center" style="font-size: 32px; font-weight: 500">
    ryanobinder
</div>

---

## Requirements

- node LTS version (nodejs.org)
- pnpm globally installed
- Autohotkey v1

## Prerequisites

- Adjust `manifest.sample.json` to your infrastructure and rename to `manifest.json`
- Adjust `environment.sample.ts`, copy and rename both to `environment.ts`(dev) and `environment.prod.ts`(prod)
- Place neutralino binaries into `neutralino/bin`

## Build

- Compile (Ahk2Exe) Hitman-Binder.ahk
- run `pnpm neutralino:build`
- rename built executable (see Naming Scheme)

### Naming Scheme

Loader: `/^ryanobinder v\d+\.\d+.\d+(-alpha|-beta)*.exe$/ig`

### Folder Structure

```bin
🖥️ client/
├── 📄 resources.neu
├── 💿 ryanobinder v1.0.0.exe
└── 📄 update.json


☁️ server/
├── 📁 dll/
│   ├── 📄 dx9_overlay.dll
│   ├── 📄 sampcac-loader.dll
│   └── 💿 sampcac-loader.exe
├── 📁 files/
│   └── 💿 Hitman-Binder.exe
├── 📄 manifest.json
├── 📄 resources.neu
└── 📄 update.json
```
