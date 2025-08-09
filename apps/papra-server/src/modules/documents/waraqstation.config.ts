import { defineConfig } from 'c12';

// WaraqStation Configuration
// محطة إدارة الوثائق العربية - تكوين محسّن للوثائق العربية

export const waraqStationConfig = defineConfig({
  // Arabic OCR Configuration
  documents: {
    // Default to Arabic and English for OCR
    ocrLanguages: ['ara', 'eng'],
    
    // Arabic-specific processing settings
    arabic: {
      // Enable Arabic text direction detection
      textDirection: 'rtl',
      
      // Arabic-specific Tesseract configurations
      tesseractOptions: {
        // Arabic script detection
        tessedit_pageseg_mode: '1', // Automatic page segmentation with OSD
        tessedit_ocr_engine_mode: '2', // Use LSTM OCR engine only
        
        // Arabic text processing optimizations
        preserve_interword_spaces: '1',
        tessedit_create_hocr: '1',
        
        // Language-specific improvements for Arabic
        textord_arabic_numerals: '1',
        textord_use_cjk_fp_model: '0',
        
        // Better handling of Arabic diacritics
        tessedit_char_whitelist: 'ابتثجحخدذرزسشصضطظعغفقكلمنهويءآأؤإئةى٠١٢٣٤٥٦٧٨٩.,:;!?()[]{}"\'-+=/*@#$%^&|\\~`<>', // Arabic chars + common symbols
      },
    },
    
    // Enhanced image preprocessing for Arabic documents
    preprocessing: {
      // Image enhancement for better Arabic OCR
      contrast: 1.2,
      brightness: 1.1,
      sharpening: true,
      
      // Noise reduction specific to Arabic scanned documents
      denoising: {
        enabled: true,
        threshold: 0.3,
      },
      
      // Deskewing for Arabic documents (important for RTL text)
      deskew: {
        enabled: true,
        sensitivity: 0.5,
      },
    },
    
    // File type specific processing
    fileTypes: {
      // PDF processing optimized for Arabic
      pdf: {
        // Higher DPI for Arabic text recognition
        extractionDpi: 300,
        
        // Better Arabic font handling
        fontSubstitution: true,
        preserveTextDirection: true,
      },
      
      // Image processing optimized for Arabic documents
      images: {
        // Support for common Arabic document formats
        supportedFormats: ['jpg', 'jpeg', 'png', 'tiff', 'bmp', 'webp'],
        
        // Minimum resolution for Arabic OCR
        minDpi: 200,
        maxDpi: 600,
        
        // Color processing for Arabic documents
        grayscaleConversion: true,
        contrastEnhancement: true,
      },
    },
  },
  
  // Arabic search configuration
  search: {
    // Arabic-aware text indexing
    textProcessing: {
      // Arabic normalization
      normalizeArabic: true,
      
      // Remove diacritics for better search
      removeDiacritics: true,
      
      // Support Arabic stemming
      enableStemming: true,
      
      // Arabic stop words
      removeStopWords: true,
    },
    
    // Search relevance for Arabic content
    scoring: {
      // Boost exact Arabic matches
      exactMatchBoost: 2.0,
      
      // Arabic phonetic matching
      phoneticMatching: true,
    },
  },
  
  // WaraqStation-specific features
  waraqstation: {
    // Default interface language
    defaultLanguage: 'ar',
    
    // Arabic document templates
    templates: {
      // Common Arabic document types
      enabled: true,
      types: [
        'contract', // عقد
        'invoice', // فاتورة
        'receipt', // إيصال
        'certificate', // شهادة
        'letter', // خطاب
        'report', // تقرير
        'memo', // مذكرة
        'form', // نموذج
      ],
    },
    
    // Document classification for Arabic documents
    classification: {
      // Auto-detect Arabic document types
      autoDetect: true,
      
      // Arabic keywords for classification
      keywords: {
        contract: ['عقد', 'اتفاقية', 'عقد عمل', 'عقد إيجار'],
        invoice: ['فاتورة', 'فاتورة ضريبية', 'حساب'],
        receipt: ['إيصال', 'وصل', 'إيصال دفع'],
        certificate: ['شهادة', 'شهادة ميلاد', 'شهادة وفاة', 'شهادة زواج'],
        letter: ['خطاب', 'رسالة', 'مراسلة'],
        report: ['تقرير', 'بحث', 'دراسة'],
        memo: ['مذكرة', 'تذكير', 'ملاحظة'],
        form: ['نموذج', 'استمارة', 'طلب'],
      },
    },
    
    // Metadata extraction for Arabic documents
    metadata: {
      // Extract Arabic date formats
      dateFormats: [
        'DD/MM/YYYY',
        'DD-MM-YYYY',
        'YYYY/MM/DD',
        'YYYY-MM-DD',
      ],
      
      // Extract Arabic numbers and amounts
      numberFormats: {
        decimal: '٫', // Arabic decimal separator
        thousands: '٬', // Arabic thousands separator
        currency: ['ريال', 'درهم', 'دينار', 'جنيه', 'ليرة'],
      },
      
      // Arabic name extraction patterns
      namePatterns: [
        /[\u0600-\u06FF\s]{2,50}/, // Arabic character range
      ],
    },
  },
  
  // Performance optimizations for Arabic processing
  performance: {
    // OCR worker pool configuration
    ocrWorkers: {
      maxWorkers: 2, // Limit for better Arabic processing quality
      workerTimeout: 120000, // 2 minutes for complex Arabic documents
    },
    
    // Caching for Arabic text extraction
    cache: {
      enabled: true,
      ttl: 86400000, // 24 hours
      maxSize: 1000, // Cache up to 1000 processed documents
    },
  },
  
  // Security considerations for Arabic documents
  security: {
    // Content filtering for Arabic text
    contentFiltering: {
      enabled: true,
      // Add Arabic-specific content filters if needed
    },
    
    // File validation
    fileValidation: {
      maxFileSize: 50 * 1024 * 1024, // 50MB for high-quality Arabic scans
      allowedMimeTypes: [
        'application/pdf',
        'image/jpeg',
        'image/png',
        'image/tiff',
        'image/bmp',
        'image/webp',
      ],
    },
  },
});

export default waraqStationConfig;