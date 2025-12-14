/// API configuration constants
class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://nexus-api.yourdomain.com';
  static const String localUrl = 'http://localhost:8003';

  // VPS URL - CEREBRO V3.0.0 (Hostinger VPS - port 8003)
  static const String vpsUrl = 'http://72.60.115.169:8003';

  // API Version
  static const String apiVersion = 'v1';

  // Full API base (use VPS by default for CEREBRO)
  static String get apiBase => '$vpsUrl/api/$apiVersion';
  static String get localApiBase => '$localUrl/api/$apiVersion';
  static String get vpsApiBase => '$vpsUrl/api/$apiVersion';
  
  // Endpoints - CEREBRO (NEXUS V3.0.0 actual endpoints)
  static const String cerebroSearch = '/memory/search';
  static const String cerebroRecent = '/memory/episodic/recent';
  static const String cerebroAction = '/memory/action'; // For creating episodes
  static const String cerebroStats = '/stats';
  static const String cerebroHybridSearch = '/memory/hybrid';
  static const String cerebroFacts = '/memory/facts';

  // Endpoints - Brain Processing
  static const String brainProcess = '/brain/process';
  static const String brainProcessFast = '/brain/process/fast';
  static const String brainProcessFull = '/brain/process/full';
  static const String brainStatus = '/brain/status';

  // Endpoints - Health
  static const String health = '/health';
  static const String systemFullHealth = '/system/full-health';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const Duration sendTimeout = Duration(seconds: 30);
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}
