// WaraqStation Offline Configuration
// تكوين WaraqStation للاستخدام دون اتصال

import { defineConfig } from 'c12';

export const offlineConfig = defineConfig({
  // Disable all email features
  emails: {
    enabled: false,
    dryRun: true,
    smtp: {
      enabled: false,
    },
    intake: {
      enabled: false,
    },
    notifications: {
      enabled: false,
    },
  },
  
  // Disable webhook features (optional, for pure offline use)
  webhooks: {
    enabled: false,
  },
  
  // Optimize for offline use
  features: {
    emailIngestion: false,
    emailNotifications: false,
    externalIntegrations: false,
    cloudSync: false,
  },
  
  // Security optimizations for local use
  security: {
    // Less strict CORS for local-only use
    cors: {
      origin: ['http://localhost:1221', 'http://127.0.0.1:1221'],
    },
    
    // Local authentication only
    auth: {
      enableSocialLogin: false,
      enableEmailVerification: false,
    },
  },
  
  // Performance optimizations for local use
  performance: {
    // Reduce worker count for single-user local use
    maxWorkers: 1,
    
    // Optimize for local storage
    caching: {
      enabled: true,
      maxMemoryUsage: '256MB',
    },
  },
});

export default offlineConfig;