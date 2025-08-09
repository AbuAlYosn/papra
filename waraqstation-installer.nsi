; WaraqStation Windows Installer Script (NSIS)
; محطة إدارة الوثائق العربية - برنامج التثبيت لنظام ويندوز
;
; This script creates a Windows installer executable (.exe) for WaraqStation
; يقوم هذا السكريبت بإنشاء ملف تثبيت قابل للتنفيذ (.exe) لـ WaraqStation
;
; To compile: Right-click this file and select "Compile NSIS Script"
; للترجمة: انقر بالزر الأيمن على هذا الملف واختر "Compile NSIS Script"

; Include modern UI
!include "MUI2.nsh"
!include "nsDialogs.nsh"
!include "LogicLib.nsh"

; Application Information
!define APPNAME "WaraqStation"
!define APPVERSION "1.0.0"
!define DESCRIPTION "Arabic Document Management Platform - محطة إدارة الوثائق العربية"
!define COMPANYNAME "WaraqStation Team"
!define HELPURL "https://github.com/waraqstation/waraqstation"

; Registry keys
!define REGKEY "SOFTWARE\WaraqStation"
!define UNINSTKEY "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WaraqStation"

; Installer properties
Name "${APPNAME}"
OutFile "WaraqStation-Installer-v${APPVERSION}.exe"
InstallDir "$PROGRAMFILES64\WaraqStation"
RequestExecutionLevel admin
ShowInstDetails show
ShowUnInstDetails show

; Version information
VIProductVersion "${APPVERSION}.0"
VIAddVersionKey "ProductName" "${APPNAME}"
VIAddVersionKey "ProductVersion" "${APPVERSION}"
VIAddVersionKey "CompanyName" "${COMPANYNAME}"
VIAddVersionKey "FileDescription" "${DESCRIPTION}"
VIAddVersionKey "FileVersion" "${APPVERSION}"

; Modern UI configuration
!define MUI_ABORTWARNING
!define MUI_UNABORTWARNING
!define MUI_ICON "waraqstation.ico"
!define MUI_UNICON "waraqstation.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "header.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "welcome.bmp"

; Welcome page customization
!define MUI_WELCOMEPAGE_TITLE "Welcome to WaraqStation Installation$\r$\nمرحباً بك في تثبيت WaraqStation"
!define MUI_WELCOMEPAGE_TEXT "WaraqStation is your specialized platform for managing Arabic documents.$\r$\n$\r$\nWaraqStation هي منصتك المتخصصة لإدارة الوثائق العربية.$\r$\n$\r$\nThis installer will guide you through the setup process.$\r$\nسيرشدك هذا المثبت خلال عملية الإعداد."

; Finish page customization
!define MUI_FINISHPAGE_TITLE "WaraqStation Installation Complete$\r$\nاكتمل تثبيت WaraqStation"
!define MUI_FINISHPAGE_TEXT "WaraqStation has been successfully installed.$\r$\n$\r$\nتم تثبيت WaraqStation بنجاح.$\r$\n$\r$\nClick Finish to complete the setup.$\r$\nانقر إنهاء لاستكمال الإعداد."
!define MUI_FINISHPAGE_RUN "$INSTDIR\start-waraqstation.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Start WaraqStation now (تشغيل WaraqStation الآن)"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README_WARAQSTATION.md"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show User Guide (عرض دليل المستخدم)"

; Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
Page custom DockerCheckPage DockerCheckPageLeave
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Languages
!insertmacro MUI_LANGUAGE "English"

; Variables
Var DockerInstalled
Var DockerRunning
Var UserDataDir

; Custom Docker Check Page
Function DockerCheckPage
    nsDialogs::Create 1018
    Pop $0
    
    ${NSD_CreateLabel} 0 0 100% 20u "Checking Docker installation..."
    ${NSD_CreateLabel} 0 25 100% 20u "جاري فحص تثبيت Docker..."
    
    ${NSD_CreateLabel} 0 60 100% 40u "WaraqStation requires Docker Desktop for Windows to run.$\r$\nيتطلب WaraqStation تثبيت Docker Desktop لنظام ويندوز للعمل."
    
    ; Check if Docker is installed
    ExecWait 'docker --version' $0
    ${If} $0 == 0
        StrCpy $DockerInstalled "true"
        ${NSD_CreateLabel} 0 110 100% 20u "✓ Docker is installed - Docker مثبت"
        
        ; Check if Docker is running
        ExecWait 'docker ps' $0
        ${If} $0 == 0
            StrCpy $DockerRunning "true"
            ${NSD_CreateLabel} 0 135 100% 20u "✓ Docker is running - Docker يعمل"
        ${Else}
            StrCpy $DockerRunning "false"
            ${NSD_CreateLabel} 0 135 100% 20u "⚠ Docker is not running - Docker لا يعمل"
            ${NSD_CreateLabel} 0 160 100% 20u "Please start Docker Desktop before continuing."
            ${NSD_CreateLabel} 0 180 100% 20u "يرجى تشغيل Docker Desktop قبل المتابعة."
        ${EndIf}
    ${Else}
        StrCpy $DockerInstalled "false"
        ${NSD_CreateLabel} 0 110 100% 20u "✗ Docker is not installed - Docker غير مثبت"
        ${NSD_CreateLabel} 0 135 100% 60u "Please download and install Docker Desktop for Windows from:$\r$\nhttps://docs.docker.com/desktop/install/windows-install/$\r$\n$\r$\nيرجى تحميل وتثبيت Docker Desktop لنظام ويندوز من:"
    ${EndIf}
    
    nsDialogs::Show
FunctionEnd

Function DockerCheckPageLeave
    ${If} $DockerInstalled != "true"
        MessageBox MB_OK|MB_ICONEXCLAMATION "Docker Desktop is required to run WaraqStation.$\r$\nPlease install Docker Desktop and restart this installer.$\r$\n$\r$\nيتطلب Docker Desktop لتشغيل WaraqStation.$\r$\nيرجى تثبيت Docker Desktop وإعادة تشغيل هذا المثبت."
        Abort
    ${EndIf}
    
    ${If} $DockerRunning != "true"
        MessageBox MB_OK|MB_ICONEXCLAMATION "Docker Desktop is not running.$\r$\nPlease start Docker Desktop and restart this installer.$\r$\n$\r$\nDocker Desktop لا يعمل.$\r$\nيرجى تشغيل Docker Desktop وإعادة تشغيل هذا المثبت."
        Abort
    ${EndIf}
FunctionEnd

; Installation types
InstType "Full Installation (التثبيت الكامل)"
InstType "Minimal Installation (التثبيت الأساسي)"

; Components
Section "WaraqStation Core (النواة الأساسية)" SecCore
    SectionIn 1 2 RO  ; Required section
    
    SetOutPath "$INSTDIR"
    
    ; Create user data directory
    StrCpy $UserDataDir "$PROFILE\WaraqStation\data"
    CreateDirectory "$UserDataDir"
    
    ; Copy installation files
    File "install-waraqstation-windows.bat"
    File "install-waraqstation-windows.ps1"
    File "README_WARAQSTATION.md"
    File "WARAQSTATION_USER_GUIDE.md"
    File /r "docker"
    File /r "apps"
    File /r "packages"
    File "package.json"
    File "pnpm-lock.yaml"
    File "pnpm-workspace.yaml"
    
    ; Create management scripts
    DetailPrint "Creating management scripts..."
    DetailPrint "جاري إنشاء سكريبتات الإدارة..."
    
    ; Create batch script wrapper for start
    FileOpen $0 "$INSTDIR\start-waraqstation.bat" w
    FileWrite $0 '@echo off$\r$\n'
    FileWrite $0 'echo Starting WaraqStation...$\r$\n'
    FileWrite $0 'echo جاري تشغيل WaraqStation...$\r$\n'
    FileWrite $0 'docker start waraqstation$\r$\n'
    FileWrite $0 'if %errorlevel% equ 0 ($\r$\n'
    FileWrite $0 '    echo WaraqStation started successfully!$\r$\n'
    FileWrite $0 '    echo تم تشغيل WaraqStation بنجاح!$\r$\n'
    FileWrite $0 '    start http://localhost:1221$\r$\n'
    FileWrite $0 ') else ($\r$\n'
    FileWrite $0 '    echo Failed to start WaraqStation.$\r$\n'
    FileWrite $0 '    echo فشل في تشغيل WaraqStation.$\r$\n'
    FileWrite $0 ')$\r$\n'
    FileWrite $0 'pause$\r$\n'
    FileClose $0
    
    ; Create executable wrapper for start script
    File "start-waraqstation.exe"  ; Pre-compiled wrapper if available
    
    ; Create stop script
    FileOpen $0 "$INSTDIR\stop-waraqstation.bat" w
    FileWrite $0 '@echo off$\r$\n'
    FileWrite $0 'echo Stopping WaraqStation...$\r$\n'
    FileWrite $0 'echo جاري إيقاف WaraqStation...$\r$\n'
    FileWrite $0 'docker stop waraqstation$\r$\n'
    FileWrite $0 'echo WaraqStation stopped.$\r$\n'
    FileWrite $0 'echo تم إيقاف WaraqStation.$\r$\n'
    FileWrite $0 'pause$\r$\n'
    FileClose $0
    
    ; Create update script
    FileOpen $0 "$INSTDIR\update-waraqstation.bat" w
    FileWrite $0 '@echo off$\r$\n'
    FileWrite $0 'echo Updating WaraqStation...$\r$\n'
    FileWrite $0 'echo جاري تحديث WaraqStation...$\r$\n'
    FileWrite $0 'docker stop waraqstation$\r$\n'
    FileWrite $0 'docker rm waraqstation$\r$\n'
    FileWrite $0 'cd /d "$INSTDIR"$\r$\n'
    FileWrite $0 'docker build -t waraqstation:latest -f docker\Dockerfile.waraqstation .$\r$\n'
    FileWrite $0 'docker run -d --name waraqstation --restart unless-stopped -p 1221:1221 -v "$UserDataDir:/app/app-data" waraqstation:latest$\r$\n'
    FileWrite $0 'echo WaraqStation updated and restarted.$\r$\n'
    FileWrite $0 'echo تم تحديث وإعادة تشغيل WaraqStation.$\r$\n'
    FileWrite $0 'pause$\r$\n'
    FileClose $0
    
    ; Write registry keys
    WriteRegStr HKLM "${REGKEY}" "InstallPath" "$INSTDIR"
    WriteRegStr HKLM "${REGKEY}" "DataPath" "$UserDataDir"
    WriteRegStr HKLM "${REGKEY}" "Version" "${APPVERSION}"
    
    ; Write uninstaller registry keys
    WriteRegStr HKLM "${UNINSTKEY}" "DisplayName" "${APPNAME}"
    WriteRegStr HKLM "${UNINSTKEY}" "DisplayVersion" "${APPVERSION}"
    WriteRegStr HKLM "${UNINSTKEY}" "Publisher" "${COMPANYNAME}"
    WriteRegStr HKLM "${UNINSTKEY}" "HelpLink" "${HELPURL}"
    WriteRegStr HKLM "${UNINSTKEY}" "UninstallString" '"$INSTDIR\uninstall.exe"'
    WriteRegDWORD HKLM "${UNINSTKEY}" "NoModify" 1
    WriteRegDWORD HKLM "${UNINSTKEY}" "NoRepair" 1
    
    ; Create uninstaller
    WriteUninstaller "$INSTDIR\uninstall.exe"
SectionEnd

Section "Desktop Shortcuts (اختصارات سطح المكتب)" SecDesktop
    SectionIn 1
    
    ; Create desktop shortcut
    CreateShortcut "$DESKTOP\WaraqStation.lnk" "$INSTDIR\start-waraqstation.exe" "" "$INSTDIR\waraqstation.ico" 0
SectionEnd

Section "Start Menu Shortcuts (اختصارات قائمة ابدأ)" SecStartMenu
    SectionIn 1
    
    CreateDirectory "$SMPROGRAMS\WaraqStation"
    CreateShortcut "$SMPROGRAMS\WaraqStation\WaraqStation.lnk" "$INSTDIR\start-waraqstation.exe" "" "$INSTDIR\waraqstation.ico" 0
    CreateShortcut "$SMPROGRAMS\WaraqStation\Stop WaraqStation.lnk" "$INSTDIR\stop-waraqstation.bat"
    CreateShortcut "$SMPROGRAMS\WaraqStation\Update WaraqStation.lnk" "$INSTDIR\update-waraqstation.bat"
    CreateShortcut "$SMPROGRAMS\WaraqStation\User Guide.lnk" "$INSTDIR\WARAQSTATION_USER_GUIDE.md"
    CreateShortcut "$SMPROGRAMS\WaraqStation\Uninstall WaraqStation.lnk" "$INSTDIR\uninstall.exe"
SectionEnd

Section "Build and Start WaraqStation (بناء وتشغيل WaraqStation)" SecBuild
    SectionIn 1
    
    DetailPrint "Building WaraqStation Docker image..."
    DetailPrint "جاري بناء صورة WaraqStation..."
    
    ; Change to installation directory
    SetOutPath "$INSTDIR"
    
    ; Build Docker image
    ExecWait 'docker build -t waraqstation:latest -f docker\Dockerfile.waraqstation .' $0
    ${If} $0 == 0
        DetailPrint "✓ Docker image built successfully"
        DetailPrint "✓ تم بناء صورة Docker بنجاح"
        
        DetailPrint "Starting WaraqStation container..."
        DetailPrint "جاري تشغيل حاوية WaraqStation..."
        
        ; Run WaraqStation container
        ExecWait 'docker run -d --name waraqstation --restart unless-stopped -p 1221:1221 -v "$UserDataDir:/app/app-data" waraqstation:latest' $0
        ${If} $0 == 0
            DetailPrint "✓ WaraqStation started successfully!"
            DetailPrint "✓ تم تشغيل WaraqStation بنجاح!"
            DetailPrint "Access WaraqStation at: http://localhost:1221"
            DetailPrint "الوصول إلى WaraqStation على: http://localhost:1221"
        ${Else}
            DetailPrint "✗ Failed to start WaraqStation container"
            DetailPrint "✗ فشل في تشغيل حاوية WaraqStation"
        ${EndIf}
    ${Else}
        DetailPrint "✗ Failed to build Docker image"
        DetailPrint "✗ فشل في بناء صورة Docker"
    ${EndIf}
SectionEnd

; Component descriptions
LangString DESC_SecCore ${LANG_ENGLISH} "Core WaraqStation files and scripts (required)$\r$\nملفات وسكريبتات WaraqStation الأساسية (مطلوب)"
LangString DESC_SecDesktop ${LANG_ENGLISH} "Create desktop shortcut for easy access$\r$\nإنشاء اختصار سطح المكتب للوصول السهل"
LangString DESC_SecStartMenu ${LANG_ENGLISH} "Create Start Menu shortcuts$\r$\nإنشاء اختصارات قائمة ابدأ"
LangString DESC_SecBuild ${LANG_ENGLISH} "Build Docker image and start WaraqStation$\r$\nبناء صورة Docker وتشغيل WaraqStation"

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecCore} $(DESC_SecCore)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDesktop} $(DESC_SecDesktop)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecStartMenu} $(DESC_SecStartMenu)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecBuild} $(DESC_SecBuild)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

; Uninstaller
Section "Uninstall"
    ; Stop WaraqStation if running
    DetailPrint "Stopping WaraqStation..."
    DetailPrint "جاري إيقاف WaraqStation..."
    ExecWait 'docker stop waraqstation'
    ExecWait 'docker rm waraqstation'
    
    ; Remove WaraqStation image (optional, ask user)
    MessageBox MB_YESNO|MB_ICONQUESTION "Do you want to remove the WaraqStation Docker image?$\r$\nهل تريد إزالة صورة WaraqStation Docker؟" IDYES RemoveImage IDNO SkipImage
    RemoveImage:
        ExecWait 'docker rmi waraqstation:latest'
        DetailPrint "Docker image removed"
        DetailPrint "تم إزالة صورة Docker"
    SkipImage:
    
    ; Remove files
    Delete "$INSTDIR\*.*"
    RMDir /r "$INSTDIR\docker"
    RMDir /r "$INSTDIR\apps"
    RMDir /r "$INSTDIR\packages"
    RMDir "$INSTDIR"
    
    ; Remove shortcuts
    Delete "$DESKTOP\WaraqStation.lnk"
    RMDir /r "$SMPROGRAMS\WaraqStation"
    
    ; Remove registry keys
    DeleteRegKey HKLM "${UNINSTKEY}"
    DeleteRegKey HKLM "${REGKEY}"
    
    ; Ask about user data
    MessageBox MB_YESNO|MB_ICONQUESTION "Do you want to keep your documents and data?$\r$\nهل تريد الاحتفاظ بوثائقك وبياناتك؟" IDYES KeepData IDNO RemoveData
    RemoveData:
        ReadRegStr $UserDataDir HKLM "${REGKEY}" "DataPath"
        RMDir /r "$UserDataDir"
        DetailPrint "User data removed"
        DetailPrint "تم إزالة بيانات المستخدم"
    KeepData:
        DetailPrint "User data preserved"
        DetailPrint "تم الاحتفاظ ببيانات المستخدم"
        
SectionEnd

; Installation finished
Function .onInstSuccess
    MessageBox MB_OK "WaraqStation has been installed successfully!$\r$\n$\r$\nتم تثبيت WaraqStation بنجاح!$\r$\n$\r$\nYou can access it at: http://localhost:1221$\r$\nيمكنك الوصول إليه على: http://localhost:1221"
FunctionEnd