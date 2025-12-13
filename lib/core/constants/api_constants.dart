/// API configuration constants
class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://nexus-api.yourdomain.com';
  static const String localUrl = 'http://localhost:8000';
  
  // VPS URL (to be configured)
  static const String vpsUrl = 'http://YOUR_VPS_IP:8000';
  
  // API Version
  static const String apiVersion = 'v1';
  
  // Full API base
  static String get apiBase => '$baseUrl/api/$apiVersion';
  static String get localApiBase => '$localUrl/api/$apiVersion';
  
  // Endpoints - CEREBRO
  static const String cerebroChat = '/cerebro/chat';
  static const String cerebroSearch = '/cerebro/search';
  static const String cerebroEpisodes = '/cerebro/episodes';
  static const String cerebroRecent = '/cerebro/recent';
  static const String cerebroStats = '/cerebro/stats';
  
  // Endpoints - Health
  static const String health = '/health';
  static const String systemInfo = '/system/info';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const Duration sendTimeout = Duration(seconds: 30);
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}
