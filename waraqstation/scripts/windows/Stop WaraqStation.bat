@echo off
setlocal

set SCRIPT_DIR=%~dp0
set ROOT=%SCRIPT_DIR%..\..\
set COMPOSE_FILE=%ROOT%docker-compose.yml

where docker >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
  echo Docker Desktop is not installed.
  pause
  exit /b 1
)

echo Stopping WaraqStation...
 docker compose -f "%COMPOSE_FILE%" down

echo Done.
pause
endlocal