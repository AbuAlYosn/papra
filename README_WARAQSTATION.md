# WaraqStation - محطة إدارة الوثائق العربية

<div align="center">

![WaraqStation](https://img.shields.io/badge/WaraqStation-1.0.0-blue?style=for-the-badge)
![Arabic Support](https://img.shields.io/badge/Arabic-Optimized-green?style=for-the-badge)
![Docker](https://img.shields.io/badge/Docker-Ready-blue?style=for-the-badge)
![RTL Support](https://img.shields.io/badge/RTL-Interface-orange?style=for-the-badge)

**Arabic Document Management Platform**  
**منصة إدارة الوثائق العربية**

</div>

## What is WaraqStation? | ما هو WaraqStation؟

WaraqStation is a specialized document management platform optimized for Arabic users. Built on the robust Papra foundation, it features:

WaraqStation هي منصة إدارة وثائق متخصصة ومحسّنة للمستخدمين العرب. مبنية على أساس Papra القوي، وتتميز بـ:

- 🌐 **RTL Interface** - Native Arabic right-to-left interface  
- 🔍 **Arabic OCR** - Advanced Arabic text extraction from scanned documents  
- 📄 **Document Management** - Organize, tag, and search Arabic documents  
- 🔒 **Local Storage** - Your data stays on your computer  
- 🚀 **Easy Installation** - One-click Windows installation scripts  

## Quick Installation | التثبيت السريع

### Windows Users | مستخدمو ويندوز

1. **Download** Docker Desktop for Windows from [docker.com](https://docs.docker.com/desktop/install/windows-install/)
2. **Run as Administrator** one of these files:
   - `install-waraqstation-windows.bat` (Batch script)
   - `install-waraqstation-windows.ps1` (PowerShell script)
3. **Wait** for installation to complete
4. **Access** WaraqStation at `http://localhost:1221`

### Manual Installation | التثبيت اليدوي

```bash
# Build WaraqStation
docker build -t waraqstation:latest -f docker/Dockerfile.waraqstation .

# Run WaraqStation
docker run -d \
  --name waraqstation \
  --restart unless-stopped \
  -p 1221:1221 \
  -v waraqstation-data:/app/app-data \
  waraqstation:latest
```

## Features | الميزات

### 📄 Document Management | إدارة الوثائق
- Upload documents via drag & drop
- Support for PDF, images (JPG, PNG, TIFF, BMP, WebP)
- Automatic Arabic text extraction (OCR)
- Full-text search in Arabic content
- Tag and organize documents

### 🌐 Arabic Interface | الواجهة العربية
- Complete Arabic translation
- Right-to-left (RTL) layout support
- Arabic fonts and typography
- Optimized for Arabic reading patterns

### 🔍 Advanced OCR | استخراج النص المتقدم
- Arabic + English text recognition
- High accuracy for printed Arabic text
- Support for scanned documents and images
- Automatic document classification

### 👥 Collaboration | التعاون
- Create organizations for teams
- User management and permissions
- Secure document sharing
- Role-based access control

## System Requirements | متطلبات النظام

- **OS**: Windows 10/11 (64-bit)
- **RAM**: 4 GB minimum, 8 GB recommended
- **Storage**: 10 GB free space
- **Docker**: Docker Desktop for Windows

## File Structure | هيكل الملفات

```
WaraqStation/
├── 📁 apps/
│   ├── 📁 papra-client/       # Frontend (Arabic interface)
│   └── 📁 papra-server/       # Backend (Arabic OCR)
├── 📁 docker/
│   ├── 📄 Dockerfile.waraqstation    # Optimized Docker image
│   └── 📄 Dockerfile                 # Original Dockerfile
├── 📁 packages/
│   └── 📁 lecture/            # Document processing engine
├── 📄 install-waraqstation-windows.bat    # Windows installer (Batch)
├── 📄 install-waraqstation-windows.ps1    # Windows installer (PowerShell)
├── 📄 WARAQSTATION_USER_GUIDE.md          # Complete user guide
└── 📄 README_WARAQSTATION.md              # This file
```

## Management Scripts | سكريبتات الإدارة

After installation, these scripts will be created in your WaraqStation directory:

### `start-waraqstation` | تشغيل WaraqStation
Start the WaraqStation service

### `stop-waraqstation` | إيقاف WaraqStation
Stop the WaraqStation service

### `update-waraqstation` | تحديث WaraqStation
Update WaraqStation to the latest version

### `backup-waraqstation` | نسخ احتياطي
Create backup of your documents and data

## Configuration | التكوين

### Default Settings | الإعدادات الافتراضية

- **Port**: 1221
- **Language**: Arabic (العربية)
- **OCR Languages**: Arabic + English
- **Interface Direction**: RTL (Right-to-Left)
- **Database**: SQLite (local file)

### Environment Variables | متغيرات البيئة

```bash
# Arabic-optimized defaults
DATABASE_URL=file:./app-data/db/waraqstation.sqlite
DOCUMENTS_OCR_LANGUAGES=ara,eng
DEFAULT_LANGUAGE=ar
DOCUMENT_STORAGE_FILESYSTEM_ROOT=./app-data/documents
```

## Supported File Types | أنواع الملفات المدعومة

| Type | Extensions | Max Size | OCR Support |
|------|------------|----------|-------------|
| **PDF** | `.pdf` | 50 MB | ✅ Yes |
| **Images** | `.jpg`, `.jpeg`, `.png`, `.tiff`, `.bmp`, `.webp` | 50 MB | ✅ Yes |
| **Text** | `.txt` | 10 MB | ➖ N/A |

## Arabic OCR Optimization | تحسين استخراج النص العربي

For best Arabic OCR results:

للحصول على أفضل نتائج استخراج النص العربي:

1. **High Resolution** - Scan at 300 DPI or higher
2. **Good Contrast** - Ensure clear text on clean background
3. **Proper Alignment** - Keep documents straight
4. **Good Lighting** - Avoid shadows and glare

## Security | الأمان

- 🔒 **Local Storage** - All data stays on your computer
- 🚫 **No Cloud Sync** - Documents never leave your system
- 🛡️ **Encrypted Database** - SQLite with security features
- 👤 **User Authentication** - Secure login system
- 🔐 **Role-based Access** - Control who sees what

## Docker Commands | أوامر Docker

### Basic Operations | العمليات الأساسية

```bash
# Build WaraqStation
docker build -t waraqstation:latest -f docker/Dockerfile.waraqstation .

# Run WaraqStation
docker run -d --name waraqstation -p 1221:1221 waraqstation:latest

# Stop WaraqStation
docker stop waraqstation

# Start WaraqStation
docker start waraqstation

# View logs
docker logs waraqstation

# Remove container
docker rm waraqstation
```

### Data Persistence | استمرارية البيانات

```bash
# Run with persistent data storage
docker run -d \
  --name waraqstation \
  --restart unless-stopped \
  -p 1221:1221 \
  -v C:\WaraqStation\data:/app/app-data \
  waraqstation:latest
```

## Troubleshooting | استكشاف الأخطاء

### Common Issues | المشاكل الشائعة

#### WaraqStation won't start
1. Check if Docker Desktop is running
2. Ensure port 1221 is not in use: `netstat -an | findstr :1221`
3. Restart Docker Desktop

#### Arabic interface not showing
1. Clear browser cache
2. Go to Settings → Language → العربية
3. Refresh the page

#### OCR not working for Arabic
1. Ensure document quality is good (300+ DPI)
2. Check file format (PDF or high-quality images)
3. Verify Arabic text is clear and not too small

### Get Help | الحصول على المساعدة

1. **Check logs**: `docker logs waraqstation`
2. **Restart service**: Use stop/start scripts
3. **Read full guide**: See `WARAQSTATION_USER_GUIDE.md`

## Version Information | معلومات الإصدار

- **WaraqStation Version**: 1.0.0
- **Based on**: Papra (AGPL-3.0-or-later)
- **OCR Engine**: Tesseract with Arabic support
- **Frontend**: SolidJS with RTL support
- **Backend**: HonoJS with Arabic optimization
- **Database**: SQLite
- **Container**: Docker (~400MB)

## License | الترخيص

WaraqStation is licensed under **AGPL-3.0-or-later**

- ✅ Free for personal and commercial use
- ✅ Open source - view and modify code
- ✅ Share improvements back to community

## Credits | الشكر والتقدير

WaraqStation is built upon:
- **Papra** - Original document management platform
- **Tesseract OCR** - Text recognition engine
- **SolidJS** - Reactive frontend framework
- **HonoJS** - Fast web framework
- **Docker** - Containerization platform

Special thanks to Arabic typography and RTL interface contributors.

---

<div align="center">

**Happy Document Managing! | إدارة سعيدة للوثائق!**

**[Complete User Guide](WARAQSTATION_USER_GUIDE.md)** | **[دليل المستخدم الكامل](WARAQSTATION_USER_GUIDE.md)**

</div>