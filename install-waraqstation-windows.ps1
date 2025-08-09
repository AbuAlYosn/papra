# WaraqStation Windows Installation Script (PowerShell)
# محطة إدارة الوثائق العربية - سكريبت التثبيت لنظام ويندوز
# 
# This script will install WaraqStation on your Windows computer
# يقوم هذا السكريبت بتثبيت WaraqStation على جهاز الكمبيوتر الخاص بك

param(
    [string]$InstallPath = "$env:USERPROFILE\WaraqStation",
    [int]$Port = 1221,
    [switch]$SkipDockerCheck,
    [switch]$Quiet
)

# Requires elevated privileges
#Requires -RunAsAdministrator

function Write-Message {
    param(
        [string]$Message,
        [string]$ArabicMessage = "",
        [string]$Level = "INFO"
    )
    
    $color = switch ($Level) {
        "ERROR" { "Red" }
        "SUCCESS" { "Green" }
        "WARNING" { "Yellow" }
        default { "White" }
    }
    
    Write-Host "[$Level] $Message" -ForegroundColor $color
    if ($ArabicMessage) {
        Write-Host "[$Level] $ArabicMessage" -ForegroundColor $color
    }
}

function Test-AdminPrivileges {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-DockerInstallation {
    try {
        $dockerVersion = docker --version 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Message "Docker is installed: $dockerVersion" "Docker مثبت: $dockerVersion" "SUCCESS"
            return $true
        }
    }
    catch {
        # Docker not found
    }
    
    Write-Message "Docker is not installed or not accessible." "Docker غير مثبت أو غير متاح." "ERROR"
    Write-Message "Please install Docker Desktop for Windows first." "يرجى تثبيت Docker Desktop لنظام ويندوز أولاً." "ERROR"
    Write-Message "Download from: https://docs.docker.com/desktop/install/windows-install/" "تحميل من: https://docs.docker.com/desktop/install/windows-install/" "ERROR"
    return $false
}

function Install-WaraqStation {
    param(
        [string]$Path,
        [int]$Port
    )
    
    Write-Host ""
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host "   WaraqStation Installation" -ForegroundColor Cyan
    Write-Host "   محطة إدارة الوثائق العربية" -ForegroundColor Cyan
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host ""
    
    # Check admin privileges
    Write-Message "Checking administrator privileges..." "جاري فحص صلاحيات المدير..."
    if (-not (Test-AdminPrivileges)) {
        Write-Message "This script requires administrator privileges." "يتطلب هذا السكريبت صلاحيات المدير." "ERROR"
        Write-Message "Please run PowerShell as Administrator." "يرجى تشغيل PowerShell كمسؤول." "ERROR"
        exit 1
    }
    Write-Message "Administrator privileges confirmed." "تم تأكيد صلاحيات المدير." "SUCCESS"
    
    # Check Docker installation
    if (-not $SkipDockerCheck) {
        Write-Message "Checking Docker installation..." "جاري فحص تثبيت Docker..."
        if (-not (Test-DockerInstallation)) {
            exit 1
        }
    }
    
    # Create WaraqStation directory
    Write-Message "Creating WaraqStation directory: $Path" "جاري إنشاء مجلد WaraqStation: $Path"
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Message "Directory created." "تم إنشاء المجلد." "SUCCESS"
    } else {
        Write-Message "Directory already exists." "المجلد موجود بالفعل."
    }
    
    # Create data directory
    $dataDir = Join-Path $Path "data"
    if (-not (Test-Path $dataDir)) {
        New-Item -ItemType Directory -Path $dataDir -Force | Out-Null
        Write-Message "Created data directory for document storage." "تم إنشاء مجلد البيانات لتخزين الوثائق."
    }
    
    # Stop existing container
    Write-Message "Stopping any existing WaraqStation containers..." "جاري إيقاف أي حاويات WaraqStation موجودة..."
    docker stop waraqstation 2>$null | Out-Null
    docker rm waraqstation 2>$null | Out-Null
    Write-Message "Cleanup completed." "تم تنظيف الحاويات السابقة."
    
    # Check for WaraqStation image
    Write-Message "Checking for WaraqStation Docker image..." "جاري فحص صورة WaraqStation..."
    $imageExists = docker image inspect waraqstation:latest 2>$null
    if ($LASTEXITCODE -ne 0) {
        # Try to build from Dockerfile if available (prefer lite version)
        $dockerfileLite = "docker\Dockerfile.waraqstation-lite"
        $dockerfileFull = "docker\Dockerfile.waraqstation"
        
        if (Test-Path $dockerfileLite) {
            Write-Message "Building WaraqStation Lite from source..." "جاري بناء WaraqStation المخفف من المصدر..."
            docker build -t waraqstation:latest -f $dockerfileLite .
        } elseif (Test-Path $dockerfileFull) {
            Write-Message "Building WaraqStation from source..." "جاري بناء WaraqStation من المصدر..."
            docker build -t waraqstation:latest -f $dockerfileFull .
            if ($LASTEXITCODE -ne 0) {
                Write-Message "Failed to build WaraqStation image." "فشل في بناء صورة WaraqStation." "ERROR"
                exit 1
            }
        } else {
            Write-Message "WaraqStation image not found and no Dockerfile available." "صورة WaraqStation غير موجودة ولا يوجد Dockerfile متاح." "ERROR"
            Write-Message "Please ensure the WaraqStation image is available." "يرجى التأكد من توفر صورة WaraqStation." "ERROR"
            exit 1
        }
    } else {
        Write-Message "WaraqStation image found." "تم العثور على صورة WaraqStation." "SUCCESS"
    }
    
    # Start WaraqStation container
    Write-Message "Starting WaraqStation container..." "جاري تشغيل حاوية WaraqStation..."
    
    $dockerArgs = @(
        "run", "-d",
        "--name", "waraqstation",
        "--restart", "unless-stopped",
        "-p", "${Port}:1221",
        "-v", "${dataDir}:/app/app-data",
        "waraqstation:latest"
    )
    
    & docker $dockerArgs
    
    if ($LASTEXITCODE -eq 0) {
        Write-Message "WaraqStation started successfully!" "تم تشغيل WaraqStation بنجاح!" "SUCCESS"
        Write-Host ""
        Write-Host "================================" -ForegroundColor Green
        Write-Host "   Installation Complete!" -ForegroundColor Green
        Write-Host "   اكتمل التثبيت!" -ForegroundColor Green
        Write-Host "================================" -ForegroundColor Green
        Write-Host ""
        Write-Message "Access WaraqStation at: http://localhost:$Port" "الوصول إلى WaraqStation على: http://localhost:$Port"
        Write-Message "Your documents will be stored in: $dataDir" "ستُحفظ وثائقك في: $dataDir"
        
        # Create desktop shortcut
        $shortcutPath = "$env:USERPROFILE\Desktop\WaraqStation.url"
        $shortcutContent = @"
[InternetShortcut]
URL=http://localhost:$Port
IconFile=shell32.dll
IconIndex=13
"@
        $shortcutContent | Out-File -FilePath $shortcutPath -Encoding ASCII
        Write-Message "Desktop shortcut created." "تم إنشاء اختصار على سطح المكتب." "SUCCESS"
        
        # Create management scripts
        Write-Message "Creating management scripts..." "جاري إنشاء سكريبتات الإدارة..."
        Create-ManagementScripts -Path $Path -Port $Port -DataDir $dataDir
        
        # Create Windows Service (optional)
        Create-WindowsService -Path $Path
        
        if (-not $Quiet) {
            Write-Message "Opening WaraqStation in your browser..." "جاري فتح WaraqStation في المتصفح..."
            Start-Sleep -Seconds 5
            Start-Process "http://localhost:$Port"
        }
        
    } else {
        Write-Message "Failed to start WaraqStation container." "فشل في تشغيل حاوية WaraqStation." "ERROR"
        Write-Message "Please check Docker logs: docker logs waraqstation" "يرجى فحص سجلات Docker: docker logs waraqstation" "ERROR"
        exit 1
    }
}

function Create-ManagementScripts {
    param(
        [string]$Path,
        [int]$Port,
        [string]$DataDir
    )
    
    # Start script (PowerShell)
    $startScript = @"
# Start WaraqStation
Write-Host "Starting WaraqStation..." -ForegroundColor Green
Write-Host "جاري تشغيل WaraqStation..." -ForegroundColor Green
docker start waraqstation
if (`$LASTEXITCODE -eq 0) {
    Write-Host "WaraqStation started successfully!" -ForegroundColor Green
    Write-Host "تم تشغيل WaraqStation بنجاح!" -ForegroundColor Green
    Write-Host "Access at: http://localhost:$Port"
    Write-Host "الوصول على: http://localhost:$Port"
    Start-Process "http://localhost:$Port"
} else {
    Write-Host "Failed to start WaraqStation." -ForegroundColor Red
    Write-Host "فشل في تشغيل WaraqStation." -ForegroundColor Red
}
Read-Host "Press Enter to continue..."
"@
    $startScript | Out-File -FilePath "$Path\start-waraqstation.ps1" -Encoding UTF8
    
    # Stop script (PowerShell)
    $stopScript = @"
# Stop WaraqStation
Write-Host "Stopping WaraqStation..." -ForegroundColor Yellow
Write-Host "جاري إيقاف WaraqStation..." -ForegroundColor Yellow
docker stop waraqstation
Write-Host "WaraqStation stopped." -ForegroundColor Yellow
Write-Host "تم إيقاف WaraqStation." -ForegroundColor Yellow
Read-Host "Press Enter to continue..."
"@
    $stopScript | Out-File -FilePath "$Path\stop-waraqstation.ps1" -Encoding UTF8
    
    # Update script (PowerShell)
    $updateScript = @"
# Update WaraqStation
Write-Host "Updating WaraqStation..." -ForegroundColor Cyan
Write-Host "جاري تحديث WaraqStation..." -ForegroundColor Cyan
docker stop waraqstation
docker rm waraqstation
docker pull waraqstation:latest
docker run -d --name waraqstation --restart unless-stopped -p ${Port}:1221 -v "$DataDir:/app/app-data" waraqstation:latest
Write-Host "WaraqStation updated and restarted." -ForegroundColor Green
Write-Host "تم تحديث وإعادة تشغيل WaraqStation." -ForegroundColor Green
Read-Host "Press Enter to continue..."
"@
    $updateScript | Out-File -FilePath "$Path\update-waraqstation.ps1" -Encoding UTF8
    
    # Backup script (PowerShell)
    $backupScript = @"
# Backup WaraqStation Data
`$backupName = "waraqstation-backup-`$(Get-Date -Format 'yyyyMMdd-HHmmss')"
`$backupPath = "$env:USERPROFILE\Desktop\`$backupName.zip"
Write-Host "Creating backup: `$backupPath" -ForegroundColor Cyan
Write-Host "جاري إنشاء نسخة احتياطية: `$backupPath" -ForegroundColor Cyan
Compress-Archive -Path "$DataDir\*" -DestinationPath `$backupPath
Write-Host "Backup created successfully!" -ForegroundColor Green
Write-Host "تم إنشاء النسخة الاحتياطية بنجاح!" -ForegroundColor Green
Read-Host "Press Enter to continue..."
"@
    $backupScript | Out-File -FilePath "$Path\backup-waraqstation.ps1" -Encoding UTF8
    
    Write-Message "Management scripts created in: $Path" "تم إنشاء سكريبتات الإدارة في: $Path" "SUCCESS"
    Write-Host "Available scripts:" -ForegroundColor Yellow
    Write-Host "السكريبتات المتاحة:" -ForegroundColor Yellow
    Write-Host "- start-waraqstation.ps1 : Start WaraqStation / تشغيل WaraqStation"
    Write-Host "- stop-waraqstation.ps1  : Stop WaraqStation / إيقاف WaraqStation"
    Write-Host "- update-waraqstation.ps1: Update WaraqStation / تحديث WaraqStation"
    Write-Host "- backup-waraqstation.ps1: Backup Data / نسخ احتياطي للبيانات"
}

function Create-WindowsService {
    param([string]$Path)
    
    try {
        # Create NSSM service wrapper script (if NSSM is available)
        $serviceScript = @"
# WaraqStation Windows Service Management
# يمكنك استخدام NSSM لتشغيل WaraqStation كخدمة ويندوز

# To install as Windows Service (requires NSSM):
# 1. Download NSSM from: https://nssm.cc/download
# 2. Extract to C:\nssm
# 3. Run as Administrator:
#    C:\nssm\nssm.exe install WaraqStation docker
#    C:\nssm\nssm.exe set WaraqStation Parameters "start waraqstation"
#    C:\nssm\nssm.exe set WaraqStation DisplayName "WaraqStation - Arabic Document Management"
#    C:\nssm\nssm.exe set WaraqStation Description "محطة إدارة الوثائق العربية"
#    C:\nssm\nssm.exe start WaraqStation

Write-Host "Service management script created." -ForegroundColor Green
Write-Host "تم إنشاء سكريبت إدارة الخدمة." -ForegroundColor Green
"@
        $serviceScript | Out-File -FilePath "$Path\create-service.ps1" -Encoding UTF8
    }
    catch {
        # Service creation is optional
    }
}

# Main execution
try {
    Install-WaraqStation -Path $InstallPath -Port $Port
    Write-Host ""
    Write-Message "Installation script completed successfully." "اكتمل سكريبت التثبيت بنجاح." "SUCCESS"
}
catch {
    Write-Message "Installation failed: $($_.Exception.Message)" "فشل التثبيت: $($_.Exception.Message)" "ERROR"
    exit 1
}

if (-not $Quiet) {
    Read-Host "Press Enter to exit..."
}