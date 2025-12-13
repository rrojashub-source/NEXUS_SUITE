/// API Configuration for NEXUS Suite
///
/// Contains all API endpoints and configuration.
/// IMPORTANT: Use environment variables for sensitive data.
library;

class ApiConfig {
  ApiConfig._();

  /// Base URL for the VPS backend
  /// Override with environment variable in production
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.nexus.example.com/api/v1',
  );

  /// Request timeout in milliseconds
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // ============================================
  // CEREBRO Endpoints
  // ============================================

  static const String cerebroChat = '/cerebro/chat';
  static const String cerebroSearch = '/cerebro/search';
  static const String cerebroEpisodes = '/cerebro/episodes';

  // ============================================
  // PDF Tools Endpoints
  // ============================================

  static const String pdfMerge = '/pdf/merge';
  static const String pdfSplit = '/pdf/split';
  static const String pdfCompress = '/pdf/compress';
  static const String pdfOcr = '/pdf/ocr';

  // ============================================
  // ARIA Endpoints (Future)
  // ============================================

  static const String ariaEmails = '/aria/emails';
  static const String ariaTasks = '/aria/tasks';
  static const String ariaRemind = '/aria/remind';
}
