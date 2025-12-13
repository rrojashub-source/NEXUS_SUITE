/// Application Configuration for NEXUS Suite
library;

class AppConfig {
  AppConfig._();

  /// Application name
  static const String appName = 'NEXUS Suite';

  /// Application version
  static const String version = '0.1.0';

  /// Build number
  static const int buildNumber = 1;

  /// Enable debug mode features
  static const bool isDebug = bool.fromEnvironment(
    'DEBUG',
    defaultValue: true,
  );

  /// Enable logging
  static const bool enableLogging = isDebug;

  /// Hive box names
  static const String userBoxName = 'user_preferences';
  static const String cacheBoxName = 'api_cache';
  static const String cerebroBoxName = 'cerebro_cache';

  /// Cache duration in hours
  static const int cacheDurationHours = 24;
}
