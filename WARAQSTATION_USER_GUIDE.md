# WaraqStation User Guide
# دليل مستخدم WaraqStation

![WaraqStation Logo](https://img.shields.io/badge/WaraqStation-Arabic%20Document%20Management-blue?style=for-the-badge)

## Welcome to WaraqStation | مرحباً بك في WaraqStation

**WaraqStation** is your specialized platform for managing Arabic documents and scanned files. Built on the robust Papra foundation, WaraqStation is optimized specifically for Arabic users with right-to-left interface support and enhanced Arabic OCR capabilities.

**WaraqStation** هي منصتك المتخصصة لإدارة الوثائق العربية والملفات الممسوحة ضوئياً. مبنية على أساس Papra القوي، WaraqStation محسّنة خصيصاً للمستخدمين العرب مع دعم الواجهة من اليمين إلى اليسار وقدرات متقدمة لاستخراج النص العربي.

---

## 🚀 Quick Start | البدء السريع

### Windows Installation | التثبيت على ويندوز

#### Option 1: Automated Installation (Recommended) | الخيار 1: التثبيت التلقائي (مُوصى به)

1. **Download** the WaraqStation package
   **تحميل** حزمة WaraqStation

2. **Run as Administrator** one of these installation scripts:
   **تشغيل كمدير** أحد سكريبتات التثبيت التالية:

   - **Batch Script**: `install-waraqstation-windows.bat`
   - **PowerShell Script**: `install-waraqstation-windows.ps1`

3. **Follow** the on-screen instructions
   **اتباع** التعليمات على الشاشة

4. **Access** WaraqStation at `http://localhost:1221`
   **الدخول** إلى WaraqStation على `http://localhost:1221`

#### Option 2: Manual Docker Installation | الخيار 2: التثبيت اليدوي عبر Docker

##### Prerequisites | المتطلبات الأساسية

- **Docker Desktop for Windows** installed
  **Docker Desktop لنظام ويندوز** مثبت
- **Administrator privileges** on your computer
  **صلاحيات المدير** على جهاز الكمبيوتر

##### Installation Steps | خطوات التثبيت

```bash
# 1. Build WaraqStation image
# بناء صورة WaraqStation
docker build -t waraqstation:latest -f docker/Dockerfile.waraqstation .

# 2. Create data directory
# إنشاء مجلد البيانات
mkdir C:\WaraqStation\data

# 3. Run WaraqStation
# تشغيل WaraqStation
docker run -d --name waraqstation --restart unless-stopped -p 1221:1221 -v C:\WaraqStation\data:/app/app-data waraqstation:latest
```

---

## 📋 System Requirements | متطلبات النظام

### Minimum Requirements | الحد الأدنى للمتطلبات

- **Operating System**: Windows 10/11 (64-bit)
  **نظام التشغيل**: ويندوز 10/11 (64-بت)
- **RAM**: 4 GB minimum, 8 GB recommended
  **الذاكرة**: 4 جيجابايت كحد أدنى، 8 جيجابايت مُوصى به
- **Storage**: 10 GB free space
  **التخزين**: 10 جيجابايت مساحة فارغة
- **Docker Desktop**: Latest version
  **Docker Desktop**: أحدث إصدار

### Recommended Requirements | المتطلبات المُوصى بها

- **Operating System**: Windows 11 (64-bit)
  **نظام التشغيل**: ويندوز 11 (64-بت)
- **RAM**: 16 GB or more
  **الذاكرة**: 16 جيجابايت أو أكثر
- **Storage**: 50 GB free space (SSD preferred)
  **التخزين**: 50 جيجابايت مساحة فارغة (SSD مُفضل)
- **Internet**: Stable connection for updates
  **الإنترنت**: اتصال مستقر للتحديثات

---

## 🖥️ Interface Overview | نظرة عامة على الواجهة

### Main Features | الميزات الرئيسية

#### 📄 Document Management | إدارة الوثائق
- **Upload** documents by drag & drop or click
  **رفع** الوثائق بالسحب والإفلات أو النقر
- **Organize** with tags and folders
  **تنظيم** بالعلامات والمجلدات  
- **Search** through Arabic text content
  **البحث** في محتوى النص العربي

#### 🔍 Arabic OCR | استخراج النص العربي
- **Automatic** text extraction from scanned documents
  **تلقائي** استخراج النص من الوثائق المسحوبة ضوئياً
- **Support** for Arabic and English text
  **دعم** للنص العربي والإنجليزي
- **High accuracy** for printed Arabic text
  **دقة عالية** للنص العربي المطبوع

#### 🌐 RTL Interface | واجهة من اليمين لليسار
- **Native Arabic** interface support
  **دعم أصلي** للواجهة العربية
- **Right-to-left** text and layout
  **من اليمين لليسار** النص والتخطيط
- **Arabic fonts** and typography
  **خطوط عربية** وطباعة

#### 👥 Organization Management | إدارة المؤسسات
- **Create** organizations for team collaboration
  **إنشاء** مؤسسات للتعاون الجماعي
- **Invite** members with different roles
  **دعوة** أعضاء بأدوار مختلفة
- **Share** documents securely
  **مشاركة** الوثائق بأمان

---

## 📖 How to Use | كيفية الاستخدام

### Getting Started | البدء

1. **Open** your web browser and go to `http://localhost:1221`
   **افتح** متصفح الويب واذهب إلى `http://localhost:1221`

2. **Create** your first account
   **أنشئ** حسابك الأول

3. **Set** interface language to Arabic (العربية)
   **اضبط** لغة الواجهة على العربية

### Uploading Documents | رفع الوثائق

#### Supported File Types | أنواع الملفات المدعومة

- **PDF** documents | وثائق PDF
- **Images**: JPG, PNG, TIFF, BMP, WebP
  **الصور**: JPG، PNG، TIFF، BMP، WebP
- **Maximum file size**: 50 MB
  **الحد الأقصى لحجم الملف**: 50 ميجابايت

#### Upload Methods | طرق الرفع

1. **Drag & Drop**: Drag files directly to the upload area
   **سحب وإفلات**: اسحب الملفات مباشرة إلى منطقة الرفع

2. **Click Upload**: Click the upload button and select files
   **نقر للرفع**: انقر على زر الرفع واختر الملفات

3. **Bulk Upload**: Select multiple files at once
   **رفع جماعي**: اختر عدة ملفات في مرة واحدة

### Document Processing | معالجة الوثائق

#### Automatic OCR | استخراج النص التلقائي

WaraqStation automatically processes uploaded documents to extract Arabic text:

تقوم WaraqStation تلقائياً بمعالجة الوثائق المرفوعة لاستخراج النص العربي:

1. **Image Enhancement**: Improves image quality for better OCR
   **تحسين الصورة**: يحسن جودة الصورة لاستخراج نص أفضل

2. **Text Recognition**: Extracts Arabic and English text
   **التعرف على النص**: يستخرج النص العربي والإنجليزي

3. **Content Indexing**: Makes text searchable
   **فهرسة المحتوى**: يجعل النص قابلاً للبحث

#### Document Classification | تصنيف الوثائق

WaraqStation can automatically detect and classify Arabic documents:

يمكن لـ WaraqStation التعرف تلقائياً على الوثائق العربية وتصنيفها:

- **Contracts** | العقود
- **Invoices** | الفواتير  
- **Receipts** | الإيصالات
- **Certificates** | الشهادات
- **Letters** | الخطابات
- **Reports** | التقارير

### Search & Organization | البحث والتنظيم

#### Searching Documents | البحث في الوثائق

1. **Text Search**: Search within document content
   **البحث النصي**: البحث داخل محتوى الوثيقة

2. **Tag Search**: Search by tags and categories
   **البحث بالعلامات**: البحث بالعلامات والفئات

3. **Date Range**: Filter by upload or creation date
   **المدى الزمني**: التصفية بتاريخ الرفع أو الإنشاء

4. **Advanced Search**: Combine multiple criteria
   **البحث المتقدم**: دمج عدة معايير

#### Tagging System | نظام العلامات

- **Auto-tagging**: Automatic tag suggestion based on content
  **التعليم التلقائي**: اقتراح علامات تلقائية بناءً على المحتوى

- **Custom Tags**: Create your own organizational system
  **علامات مخصصة**: أنشئ نظام التنظيم الخاص بك

- **Hierarchical Tags**: Create nested tag structures
  **علامات هرمية**: أنشئ هياكل علامات متداخلة

---

## 🔧 Management Scripts | سكريبتات الإدارة

After installation, you'll find these helpful scripts in your WaraqStation directory:

بعد التثبيت، ستجد هذه السكريبتات المفيدة في مجلد WaraqStation:

### Available Scripts | السكريبتات المتاحة

#### `start-waraqstation` | تشغيل WaraqStation
- **Purpose**: Start the WaraqStation service
  **الغرض**: تشغيل خدمة WaraqStation
- **Usage**: Double-click or run from command line
  **الاستخدام**: نقر مزدوج أو تشغيل من سطر الأوامر

#### `stop-waraqstation` | إيقاف WaraqStation  
- **Purpose**: Stop the WaraqStation service
  **الغرض**: إيقاف خدمة WaraqStation
- **Usage**: Use when you need to stop the service
  **الاستخدام**: استخدم عندما تحتاج لإيقاف الخدمة

#### `update-waraqstation` | تحديث WaraqStation
- **Purpose**: Update WaraqStation to the latest version
  **الغرض**: تحديث WaraqStation لأحدث إصدار
- **Usage**: Run periodically to get new features
  **الاستخدام**: تشغيل دوري للحصول على ميزات جديدة

#### `backup-waraqstation` | نسخ احتياطي لـ WaraqStation
- **Purpose**: Create backup of your documents and data
  **الغرض**: إنشاء نسخة احتياطية من وثائقك وبياناتك
- **Usage**: Run regularly to protect your data
  **الاستخدام**: تشغيل منتظم لحماية بياناتك

---

## 🛡️ Security & Privacy | الأمان والخصوصية

### Data Storage | تخزين البيانات

- **Local Storage**: All data stored on your computer
  **التخزين المحلي**: جميع البيانات محفوظة على جهاز الكمبيوتر
- **No Cloud Sync**: Documents never leave your system
  **بدون مزامنة سحابية**: الوثائق لا تغادر نظامك أبداً
- **Encrypted Database**: SQLite database with security features
  **قاعدة بيانات مشفرة**: قاعدة بيانات SQLite مع ميزات أمنية

### Access Control | التحكم في الوصول

- **User Authentication**: Secure login system
  **مصادقة المستخدم**: نظام تسجيل دخول آمن
- **Role-based Access**: Different permission levels
  **الوصول المبني على الأدوار**: مستويات صلاحيات مختلفة
- **Session Management**: Automatic logout for security
  **إدارة الجلسات**: تسجيل خروج تلقائي للأمان

### Best Practices | أفضل الممارسات

1. **Regular Backups**: Use the backup script weekly
   **النسخ الاحتياطي المنتظم**: استخدم سكريبت النسخ الاحتياطي أسبوعياً

2. **Strong Passwords**: Use complex passwords for accounts
   **كلمات مرور قوية**: استخدم كلمات مرور معقدة للحسابات

3. **Keep Updated**: Run update script monthly
   **ابق محدّثاً**: شغل سكريبت التحديث شهرياً

4. **Monitor Access**: Review user activities regularly
   **راقب الوصول**: راجع أنشطة المستخدمين بانتظام

---

## 🚨 Troubleshooting | استكشاف الأخطاء

### Common Issues | المشاكل الشائعة

#### Problem: WaraqStation won't start | المشكلة: WaraqStation لا يبدأ تشغيله

**Solutions | الحلول:**

1. **Check Docker**: Ensure Docker Desktop is running
   **فحص Docker**: تأكد من تشغيل Docker Desktop

2. **Check Port**: Ensure port 1221 is not in use
   **فحص المنفذ**: تأكد من أن المنفذ 1221 غير مستخدم

3. **Restart Docker**: Restart Docker Desktop service
   **إعادة تشغيل Docker**: أعد تشغيل خدمة Docker Desktop

#### Problem: OCR not working for Arabic | المشكلة: استخراج النص لا يعمل للعربية

**Solutions | الحلول:**

1. **Image Quality**: Ensure documents are clear and high resolution
   **جودة الصورة**: تأكد من وضوح الوثائق وجودتها العالية

2. **File Format**: Use PDF or high-quality image formats
   **تنسيق الملف**: استخدم PDF أو تنسيقات صور عالية الجودة

3. **Text Size**: Ensure Arabic text is not too small
   **حجم النص**: تأكد من أن النص العربي ليس صغيراً جداً

#### Problem: Interface not in Arabic | المشكلة: الواجهة ليست بالعربية

**Solutions | الحلول:**

1. **Language Settings**: Go to Settings → Language → العربية
   **إعدادات اللغة**: اذهب إلى الإعدادات ← اللغة ← العربية

2. **Browser Cache**: Clear browser cache and reload
   **ذاكرة التخزين المؤقت**: امسح ذاكرة المتصفح المؤقت وأعد التحميل

3. **Browser Compatibility**: Use Chrome, Firefox, or Edge
   **توافق المتصفح**: استخدم Chrome أو Firefox أو Edge

### Getting Help | طلب المساعدة

#### Log Files | ملفات السجل

Check Docker logs for detailed error information:
فحص سجلات Docker للحصول على معلومات تفصيلية عن الأخطاء:

```bash
docker logs waraqstation
```

#### Community Support | دعم المجتمع

- **GitHub Issues**: Report bugs and request features
  **مشاكل GitHub**: أبلغ عن الأخطاء واطلب ميزات جديدة
- **Documentation**: Check online documentation
  **التوثيق**: راجع التوثيق عبر الإنترنت

---

## 🔄 Updates & Maintenance | التحديثات والصيانة

### Automatic Updates | التحديثات التلقائية

Use the update script to get the latest features and security improvements:
استخدم سكريبت التحديث للحصول على أحدث الميزات وتحسينات الأمان:

```bash
# Windows
update-waraqstation.bat

# PowerShell
.\update-waraqstation.ps1
```

### Manual Maintenance | الصيانة اليدوية

#### Database Optimization | تحسين قاعدة البيانات

WaraqStation automatically optimizes the database, but you can force optimization:
تقوم WaraqStation بتحسين قاعدة البيانات تلقائياً، لكن يمكنك فرض التحسين:

1. **Stop** WaraqStation
   **أوقف** WaraqStation

2. **Restart** the container
   **أعد تشغيل** الحاوية

#### Storage Cleanup | تنظيف التخزين

Remove old temporary files and logs:
إزالة الملفات المؤقتة والسجلات القديمة:

```bash
docker system prune
```

---

## 📚 Advanced Configuration | التكوين المتقدم

### Environment Variables | متغيرات البيئة

You can customize WaraqStation behavior with these environment variables:
يمكنك تخصيص سلوك WaraqStation بهذه متغيرات البيئة:

```bash
# Database location
DATABASE_URL=file:./app-data/db/waraqstation.sqlite

# Document storage
DOCUMENT_STORAGE_FILESYSTEM_ROOT=./app-data/documents

# OCR languages (Arabic + English by default)
DOCUMENTS_OCR_LANGUAGES=ara,eng

# Interface language
DEFAULT_LANGUAGE=ar
```

### Custom Docker Configuration | تكوين Docker المخصص

For advanced users, you can modify the Docker run command:
للمستخدمين المتقدمين، يمكنك تعديل أمر تشغيل Docker:

```bash
docker run -d \
  --name waraqstation \
  --restart unless-stopped \
  -p 1221:1221 \
  -v /path/to/data:/app/app-data \
  -e DOCUMENTS_OCR_LANGUAGES=ara,eng \
  -e DEFAULT_LANGUAGE=ar \
  waraqstation:latest
```

---

## 📝 Document Templates | قوالب الوثائق

WaraqStation includes pre-configured templates for common Arabic documents:
تتضمن WaraqStation قوالب مُعدّة مسبقاً للوثائق العربية الشائعة:

### Available Templates | القوالب المتاحة

- **Contract Template** | قالب العقد
- **Invoice Template** | قالب الفاتورة
- **Receipt Template** | قالب الإيصال
- **Certificate Template** | قالب الشهادة
- **Letter Template** | قالب الخطاب
- **Report Template** | قالب التقرير

### Using Templates | استخدام القوالب

1. **Select** "New Document" from the menu
   **اختر** "وثيقة جديدة" من القائمة

2. **Choose** a template type
   **اختر** نوع القالب

3. **Fill** in the required information
   **املأ** المعلومات المطلوبة

4. **Save** and organize your document
   **احفظ** ونظم وثيقتك

---

## 🎯 Tips for Best Results | نصائح لأفضل النتائج

### Arabic OCR Optimization | تحسين استخراج النص العربي

1. **High Resolution**: Scan documents at 300 DPI or higher
   **دقة عالية**: امسح الوثائق بدقة 300 DPI أو أعلى

2. **Good Lighting**: Ensure even lighting when scanning
   **إضاءة جيدة**: تأكد من إضاءة متساوية عند المسح

3. **Clean Documents**: Remove dust and marks before scanning
   **وثائق نظيفة**: أزل الغبار والعلامات قبل المسح

4. **Straight Alignment**: Keep documents straight and flat
   **محاذاة مستقيمة**: احتفظ بالوثائق مستقيمة ومسطحة

### Organization Tips | نصائح التنظيم

1. **Consistent Naming**: Use consistent file naming conventions
   **تسمية متسقة**: استخدم اتفاقيات تسمية متسقة

2. **Regular Tagging**: Tag documents immediately after upload
   **وضع علامات منتظم**: ضع علامات على الوثائق فور الرفع

3. **Folder Structure**: Create logical folder hierarchies
   **هيكل المجلدات**: أنشئ تسلسلات مجلدات منطقية

4. **Backup Schedule**: Set up regular backup reminders
   **جدول النسخ الاحتياطي**: أعد تذكيرات منتظمة للنسخ الاحتياطي

---

## 📞 Support & Contact | الدعم والاتصال

### Technical Support | الدعم الفني

If you encounter issues that aren't covered in this guide:
إذا واجهت مشاكل غير مغطاة في هذا الدليل:

1. **Check Logs**: Review Docker logs first
   **فحص السجلات**: راجع سجلات Docker أولاً

2. **Restart Services**: Try restarting WaraqStation
   **إعادة تشغيل الخدمات**: جرب إعادة تشغيل WaraqStation

3. **Community Help**: Ask in community forums
   **مساعدة المجتمع**: اسأل في منتديات المجتمع

### Contributing | المساهمة

WaraqStation is open source and welcomes contributions:
WaraqStation مفتوح المصدر ويرحب بالمساهمات:

- **Bug Reports**: Report issues on GitHub
  **تقارير الأخطاء**: أبلغ عن المشاكل على GitHub
- **Feature Requests**: Suggest new features
  **طلبات الميزات**: اقترح ميزات جديدة
- **Code Contributions**: Submit pull requests
  **مساهمات الكود**: أرسل طلبات السحب
- **Translations**: Help improve Arabic translations
  **الترجمات**: ساعد في تحسين الترجمات العربية

---

## 📄 License | الترخيص

WaraqStation is licensed under AGPL-3.0-or-later. This means:
WaraqStation مرخص تحت AGPL-3.0-or-later. هذا يعني:

- **Free to use** for personal and commercial purposes
  **مجاني للاستخدام** للأغراض الشخصية والتجارية
- **Open source** - you can view and modify the code
  **مفتوح المصدر** - يمكنك عرض وتعديل الكود
- **Share improvements** - modifications must be shared back
  **شارك التحسينات** - يجب مشاركة التعديلات

---

## 🏁 Conclusion | الخاتمة

Thank you for choosing WaraqStation for your Arabic document management needs. This platform is designed specifically with Arabic users in mind, providing a comprehensive solution for organizing, processing, and searching your important documents.

شكراً لك لاختيار WaraqStation لاحتياجات إدارة الوثائق العربية. هذه المنصة مصممة خصيصاً مع وضع المستخدمين العرب في الاعتبار، وتوفر حلاً شاملاً لتنظيم ومعالجة والبحث في وثائقك المهمة.

For the latest updates and announcements, please check our GitHub repository and community channels.

للتحديثات والإعلانات الأخيرة، يرجى فحص مستودع GitHub ومجتمع القنوات الخاص بنا.

**Happy Document Managing! | إدارة سعيدة للوثائق!**

---

*This guide is available in both English and Arabic to serve our diverse user community.*
*هذا الدليل متوفر باللغتين الإنجليزية والعربية لخدمة مجتمع المستخدمين المتنوع.*