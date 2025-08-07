# WaraqStation (محطة ورق) — Offline Windows Setup

This folder lets you install and run an Arabic-focused, right-to-left Paperless-ngx stack entirely offline.

## What’s included
- Paperless-ngx with Arabic OCR preinstalled
- Postgres, Redis, Tika, Gotenberg
- Nginx proxy that sets RTL and branding
- Windows scripts to start/stop

## Before you start
1) Install Docker Desktop for Windows (no sign-in required). Restart Windows if prompted.
2) Ensure Virtualization is enabled in BIOS (usually already enabled).

## First run (offline)
1) Open `scripts\windows\Start WaraqStation.bat` (double-click).
2) The script will load images from the `images\` folder and start the app.
3) Your browser will open at `http://localhost:7780`.

Login the first time with:
- Username: `admin`
- Password: `admin123!`

Change the admin password immediately under Settings.

## Daily use
- To start: double‑click `Start WaraqStation.bat`.
- To stop: double‑click `Stop WaraqStation.bat`.
- Drop files to OCR into the `consume` share (see below) or upload via the web UI.

## Folders (persist between runs)
Docker keeps data in internal volumes. If you need to export your documents, use the Paperless “Export” feature from the UI.

## No Internet access
All services are on an internal Docker network with no outbound Internet. The app will work fully offline.

## Arabic OCR
Arabic OCR is built in. If you also need English OCR later, we can provide an alternative image that includes `eng` as well.

## Troubleshooting
- If the page doesn’t open, wait ~30–60 seconds and refresh.
- If Docker says not installed, install Docker Desktop and rerun the start script.
- To reset everything, run `Stop WaraqStation.bat`, then `docker system prune -a` (advanced users), then start again.

## Uninstall
- Run `Stop WaraqStation.bat`.
- Remove images/volumes from Docker Desktop, or run:
  - `docker compose -f docker-compose.yml down -v`