@echo off
setlocal ENABLEDELAYEDEXPANSION

set SCRIPT_DIR=%~dp0
set ROOT=%SCRIPT_DIR%..\..\
set IMAGES_DIR=%ROOT%images

if not exist "%IMAGES_DIR%" (
  echo Images folder not found: %IMAGES_DIR%
  echo Skipping image load.
  exit /b 0
)

echo Loading Docker images from %IMAGES_DIR% ...
for %%F in ("%IMAGES_DIR%\*.tar") do (
  echo Loading %%~nxF
  docker load -i "%%~fF"
)

echo Done loading images.
endlocal