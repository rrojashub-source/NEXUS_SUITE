import '../../../../core/config/api_config.dart';
import '../../../../shared/services/api_service.dart';
import '../models/chat_message_model.dart';
import '../models/episode_model.dart';

/// Remote data source for CEREBRO API calls
class CerebroRemoteDataSource {
  final ApiService _apiService;

  CerebroRemoteDataSource(this._apiService);

  /// Send message to CEREBRO
  Future<ChatMessageModel> sendMessage(
    String message, {
    List<String>? contextEpisodeIds,
  }) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      ApiConfig.cerebroChat,
      data: {
        'message': message,
        if (contextEpisodeIds != null) 'context_episodes': contextEpisodeIds,
      },
    );

    return ChatMessageModel.fromApiResponse(response.data!);
  }

  /// Search episodes
  Future<List<EpisodeModel>> searchEpisodes(
    String query, {
    int limit = 10,
  }) async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiConfig.cerebroSearch,
      queryParameters: {
        'q': query,
        'limit': limit,
      },
    );

    final episodes = response.data!['episodes'] as List<dynamic>;
    return episodes
        .map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get episodes list
  Future<List<EpisodeModel>> getEpisodes({
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiConfig.cerebroEpisodes,
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );

    final episodes = response.data!['episodes'] as List<dynamic>;
    return episodes
        .map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get single episode
  Future<EpisodeModel?> getEpisodeById(String id) async {
    final response = await _apiService.get<Map<String, dynamic>>(
      '${ApiConfig.cerebroEpisodes}/$id',
    );

    if (response.data == null) return null;
    return EpisodeModel.fromJson(response.data!);
  }

  /// Create episode
  Future<EpisodeModel> createEpisode({
    required String content,
    required List<String> tags,
    Map<String, dynamic>? metadata,
  }) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      ApiConfig.cerebroEpisodes,
      data: {
        'content': content,
        'tags': tags,
        if (metadata != null) 'metadata': metadata,
      },
    );

    return EpisodeModel.fromJson(response.data!['episode'] as Map<String, dynamic>);
  }
}
