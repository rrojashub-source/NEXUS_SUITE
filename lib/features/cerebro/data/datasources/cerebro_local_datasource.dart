import '../../../../core/config/app_config.dart';
import '../../../../shared/services/storage_service.dart';
import '../models/chat_message_model.dart';
import '../models/episode_model.dart';

/// Local data source for CEREBRO caching
class CerebroLocalDataSource {
  static const String _chatHistoryKey = 'cerebro_chat_history';
  static const String _episodesCacheKey = 'cerebro_episodes_cache';

  final StorageService _storage;

  CerebroLocalDataSource(this._storage);

  /// Get cached chat history
  Future<List<ChatMessageModel>> getChatHistory() async {
    final cached = _storage.getCached<List<dynamic>>(_chatHistoryKey);
    if (cached == null) return [];

    return cached
        .map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Save chat message
  Future<void> saveChatMessage(ChatMessageModel message) async {
    final history = await getChatHistory();
    history.add(message);

    // Keep only last 100 messages
    final trimmed = history.length > 100
        ? history.sublist(history.length - 100)
        : history;

    await _storage.setCache(
      _chatHistoryKey,
      trimmed.map((m) => ChatMessageModel.fromEntity(m).toJson()).toList(),
      expiration: const Duration(days: 7),
    );
  }

  /// Clear chat history
  Future<void> clearChatHistory() async {
    await _storage.setCache(_chatHistoryKey, <Map<String, dynamic>>[]);
  }

  /// Cache episodes
  Future<void> cacheEpisodes(List<EpisodeModel> episodes) async {
    await _storage.setCache(
      _episodesCacheKey,
      episodes.map((e) => e.toJson()).toList(),
      expiration: Duration(hours: AppConfig.cacheDurationHours),
    );
  }

  /// Get cached episodes
  Future<List<EpisodeModel>> getCachedEpisodes() async {
    final cached = _storage.getCached<List<dynamic>>(_episodesCacheKey);
    if (cached == null) return [];

    return cached
        .map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
