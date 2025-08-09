# WaraqStation Installer Assets

This directory contains all the assets needed to compile the NSIS installer script into a professional Windows executable.

## Required Files for NSIS Compilation

### 1. **waraqstation.ico** (32x32, 16x16 icons)
- **Purpose**: Application icon displayed in installer and shortcuts
- **Format**: .ICO file with multiple sizes (16x16, 32x32, 48x48, 64x64)
- **Recommendation**: Use an Arabic document or folder icon with Arabic text
- **Tools**: Use GIMP, IconBuddy, or online icon converters

### 2. **header.bmp** (150x57 pixels)
- **Purpose**: Header image shown in installer pages
- **Format**: 24-bit BMP, 150x57 pixels
- **Content**: WaraqStation logo with Arabic text
- **Colors**: Professional blue/green matching your brand

### 3. **welcome.bmp** (164x314 pixels)
- **Purpose**: Welcome page sidebar image
- **Format**: 24-bit BMP, 164x314 pixels
- **Content**: WaraqStation branding with Arabic elements
- **Style**: Vertical layout with Arabic calligraphy or document icons

### 4. **start-waraqstation.exe** (Optional)
- **Purpose**: Compiled wrapper for the start script
- **Alternative**: Use batch file if you don't want to create this
- **Tools**: Use tools like Bat To Exe Converter

## Creating the Assets

### Option 1: Simple Text-Based Icons (Quick)
```bash
# Use free tools to create simple icons
# 1. Create text logo with "WaraqStation" in Arabic and English
# 2. Use simple document/folder icon from free icon sets
# 3. Convert to required formats
```

### Option 2: Professional Design (Recommended)
```bash
# 1. Design custom logo with Arabic calligraphy
# 2. Create consistent brand identity
# 3. Use professional design tools
```

## Free Resources

### Icon Creation:
- **GIMP** (Free): For icon editing
- **Paint.NET** (Free): Simple icon creation
- **IconBuddy** (Free): ICO file creation
- **Online ICO converters**: Convert PNG to ICO

### Image Resources:
- **Unsplash**: Free stock photos
- **Arabic fonts**: Google Fonts Arabic collection
- **Icon sets**: Feather Icons, Heroicons (free)

### Color Scheme Suggestions:
- **Primary**: #2563eb (Professional Blue)
- **Secondary**: #059669 (Arabic Green)  
- **Accent**: #dc2626 (Red for emphasis)
- **Background**: #f8fafc (Light Gray)

## Asset Specifications

```
waraqstation.ico:
├── 16x16 pixels (small icon)
├── 32x32 pixels (standard icon)
├── 48x48 pixels (large icon)
└── 64x64 pixels (extra large)

header.bmp:
├── Size: 150x57 pixels
├── Format: 24-bit BMP
├── Content: Logo + "WaraqStation" text
└── Style: Professional header

welcome.bmp:
├── Size: 164x314 pixels
├── Format: 24-bit BMP
├── Content: Vertical branding
└── Style: Welcome sidebar
```

## Compilation Steps

1. **Place all assets** in the same directory as `waraqstation-installer.nsi`

2. **Install NSIS** from https://nsis.sourceforge.io/

3. **Right-click** on `waraqstation-installer.nsi` → "Compile NSIS Script"

4. **Result**: `WaraqStation-Installer-v1.0.0.exe` will be created

## Testing the Installer

1. **Test on clean Windows VM** to ensure all dependencies work
2. **Verify Arabic text** displays correctly in installer
3. **Check shortcuts** are created properly
4. **Test uninstaller** removes everything cleanly

## Distribution Package

Include in your distribution:
```
WaraqStation-Package/
├── WaraqStation-Installer-v1.0.0.exe  # Main installer
├── README.txt                         # Simple instructions
├── System-Requirements.txt             # Hardware/software requirements
└── Quick-Start-Guide.pdf              # Optional user guide
```