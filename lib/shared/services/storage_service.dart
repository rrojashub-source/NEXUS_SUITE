import 'package:hive_flutter/hive_flutter.dart';
import '../../core/config/app_config.dart';
import '../../core/utils/logger.dart';

/// Local storage service using Hive
class StorageService {
  static StorageService? _instance;
  static StorageService get instance => _instance ??= StorageService._();

  StorageService._();

  late Box<dynamic> _userBox;
  late Box<dynamic> _cacheBox;

  /// Initialize storage
  Future<void> init() async {
    await Hive.initFlutter();

    _userBox = await Hive.openBox(AppConfig.userBoxName);
    _cacheBox = await Hive.openBox(AppConfig.cacheBoxName);

    AppLogger.i('Storage service initialized');
  }

  // ============================================
  // User Preferences
  // ============================================

  /// Get user preference
  T? getUserPref<T>(String key, {T? defaultValue}) {
    return _userBox.get(key, defaultValue: defaultValue) as T?;
  }

  /// Set user preference
  Future<void> setUserPref<T>(String key, T value) async {
    await _userBox.put(key, value);
  }

  /// Remove user preference
  Future<void> removeUserPref(String key) async {
    await _userBox.delete(key);
  }

  // ============================================
  // Cache Management
  // ============================================

  /// Get cached data
  T? getCached<T>(String key) {
    final cached = _cacheBox.get(key);
    if (cached == null) return null;

    final expiresAt = cached['expiresAt'] as int?;
    if (expiresAt != null &&
        DateTime.now().millisecondsSinceEpoch > expiresAt) {
      _cacheBox.delete(key);
      return null;
    }

    return cached['data'] as T?;
  }

  /// Set cached data with expiration
  Future<void> setCache<T>(
    String key,
    T data, {
    Duration? expiration,
  }) async {
    final expiresAt = expiration != null
        ? DateTime.now().add(expiration).millisecondsSinceEpoch
        : DateTime.now()
            .add(Duration(hours: AppConfig.cacheDurationHours))
            .millisecondsSinceEpoch;

    await _cacheBox.put(key, {
      'data': data,
      'expiresAt': expiresAt,
    });
  }

  /// Clear all cache
  Future<void> clearCache() async {
    await _cacheBox.clear();
    AppLogger.i('Cache cleared');
  }

  /// Clear all data
  Future<void> clearAll() async {
    await _userBox.clear();
    await _cacheBox.clear();
    AppLogger.i('All storage cleared');
  }
}
