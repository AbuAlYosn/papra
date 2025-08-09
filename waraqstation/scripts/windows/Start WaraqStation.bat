@echo off
setlocal

set SCRIPT_DIR=%~dp0
set ROOT=%SCRIPT_DIR%..\..\
set COMPOSE_FILE=%ROOT%docker-compose.yml

where docker >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
  echo Docker Desktop is not installed. Please install Docker Desktop for Windows and run this again.
  pause
  exit /b 1
)

echo Loading images (offline)...
call "%SCRIPT_DIR%Load Images.bat"

if not exist "%COMPOSE_FILE%" (
  echo Compose file not found: %COMPOSE_FILE%
  pause
  exit /b 1
)

echo Starting WaraqStation...
 docker compose -f "%COMPOSE_FILE%" up -d
if %ERRORLEVEL% NEQ 0 (
  echo Failed to start containers.
  pause
  exit /b 1
)

echo Opening http://localhost:7780 ...
start "" "http://localhost:7780"

echo WaraqStation is starting in the background.
pause
endlocal