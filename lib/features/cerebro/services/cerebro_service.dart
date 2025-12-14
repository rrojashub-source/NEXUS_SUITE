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

/// CEREBRO API service for NEXUS V3.0.0
class CerebroService {
  final ApiService _api;

  CerebroService(this._api);

  /// Send message to CEREBRO brain for processing
  Future<ChatMessage> sendMessage(String message, {List<String>? contextEpisodes}) async {
    try {
      // Use /brain/process to get cognitive processing
      final response = await _api.post(
        ApiConstants.brainProcess,
        data: {
          'query': message,
          'emotion': 'neutral',
        },
      );

      final data = response.data as Map<String, dynamic>;

      // Extract relevant information from brain processing
      final layersProcessed = data['layers_processed'] as List? ?? [];
      final labsActivated = data['labs_activated'] as int? ?? 0;
      final totalTime = data['total_processing_time_ms'] as num? ?? 0;
      final consciousness = data['consciousness_state'] as Map<String, dynamic>?;

      // Build response text from processing results
      final responseText = _buildBrainResponse(layersProcessed, labsActivated, totalTime, consciousness);

      return ChatMessage(
        content: responseText,
        isUser: false,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return ChatMessage(
        content: 'Error conectando a CEREBRO: ${e.toString()}',
        isUser: false,
        timestamp: DateTime.now(),
        errorMessage: e.toString(),
      );
    }
  }

  String _buildBrainResponse(List layersProcessed, int labsActivated, num totalTime, Map<String, dynamic>? consciousness) {
    final phi = consciousness?['phi'] as num? ?? 0;
    final level = consciousness?['level'] as String? ?? 'unknown';

    return '''Procesamiento cerebral completado:
• LABs activados: $labsActivated
• Capas procesadas: ${layersProcessed.length}
• Tiempo: ${totalTime.toStringAsFixed(2)}ms
• Consciencia: φ=${phi.toStringAsFixed(3)} ($level)

Tu mensaje fue procesado por la red neuronal de NEXUS.''';
  }

  /// Search memory episodes
  Future<List<Episode>> searchMemory(String query, {int limit = 10}) async {
    try {
      final response = await _api.post(
        ApiConstants.cerebroSearch,
        data: {
          'query': query,
          'limit': limit,
          'min_similarity': 0.5,
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
        ApiConstants.cerebroAction,
        data: {
          'action_type': 'chat_message',
          'action_details': {
            'content': content,
            'importance_score': importance,
          },
          'tags': tags,
          if (metadata != null) 'context_state': metadata,
        },
      );

      final data = response.data as Map<String, dynamic>;
      // Return a placeholder Episode since action endpoint doesn't return full episode
      return Episode(
        id: data['episode_id'] as String? ?? '',
        content: content,
        tags: tags,
        importanceScore: importance,
        createdAt: DateTime.now(),
      );
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
