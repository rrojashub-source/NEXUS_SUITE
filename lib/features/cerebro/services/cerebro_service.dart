import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/api_service.dart';
import '../../../core/constants/api_constants.dart';
import '../models/episode.dart';
import '../models/cerebro_stats.dart';
import '../models/chat_message.dart';

/// CEREBRO Service provider
final cerebroServiceProvider = Provider<CerebroService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return CerebroService(apiService);
});

/// CEREBRO API service
class CerebroService {
  final ApiService _api;

  CerebroService(this._api);

  /// Send chat message and get response
  Future<ChatMessage> sendMessage(String message, {List<String>? contextEpisodes}) async {
    try {
      final response = await _api.post(
        ApiConstants.cerebroChat,
        data: {
          'message': message,
          if (contextEpisodes != null) 'context_episodes': contextEpisodes,
        },
      );

      final data = response.data as Map<String, dynamic>;
      return ChatMessage(
        content: data['response'] as String? ?? 'No response',
        isUser: false,
        timestamp: DateTime.now(),
        sources: (data['sources'] as List<dynamic>?)
            ?.map((e) => (e as Map<String, dynamic>)['episode_id'] as String)
            .toList(),
      );
    } catch (e) {
      return ChatMessage(
        content: 'Error connecting to CEREBRO',
        isUser: false,
        timestamp: DateTime.now(),
        errorMessage: e.toString(),
      );
    }
  }

  /// Search memory episodes
  Future<List<Episode>> searchMemory(String query, {int limit = 10}) async {
    try {
      final response = await _api.get(
        ApiConstants.cerebroSearch,
        queryParameters: {
          'q': query,
          'limit': limit,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>? ?? [];
      
      return results
          .map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Search error: $e');
      return [];
    }
  }

  /// Get recent episodes
  Future<List<Episode>> getRecentEpisodes({int limit = 20}) async {
    try {
      final response = await _api.get(
        ApiConstants.cerebroRecent,
        queryParameters: {'limit': limit},
      );

      final data = response.data as Map<String, dynamic>;
      final episodes = data['episodes'] as List<dynamic>? ?? [];
      
      return episodes
          .map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Recent episodes error: $e');
      return [];
    }
  }

  /// Record new episode
  Future<Episode?> recordEpisode({
    required String content,
    List<String> tags = const [],
    double importance = 0.5,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.cerebroEpisodes,
        data: {
          'content': content,
          'tags': tags,
          'importance_score': importance,
          if (metadata != null) 'metadata': metadata,
        },
      );

      final data = response.data as Map<String, dynamic>;
      return Episode.fromJson(data['episode'] as Map<String, dynamic>);
    } catch (e) {
      print('Record episode error: $e');
      return null;
    }
  }

  /// Get CEREBRO stats
  Future<CerebroStats> getStats() async {
    try {
      final response = await _api.get(ApiConstants.cerebroStats);
      return CerebroStats.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      print('Stats error: $e');
      return CerebroStats.empty();
    }
  }

  /// Check health
  Future<bool> checkHealth() async {
    try {
      final response = await _api.get(ApiConstants.health);
      final data = response.data as Map<String, dynamic>;
      return data['status'] == 'healthy' || data['status'] == 'ok';
    } catch (e) {
      return false;
    }
  }
}
