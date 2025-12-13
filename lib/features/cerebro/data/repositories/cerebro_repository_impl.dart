import '../../../../core/utils/logger.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/episode.dart';
import '../../domain/repositories/cerebro_repository.dart';
import '../datasources/cerebro_local_datasource.dart';
import '../datasources/cerebro_remote_datasource.dart';
import '../models/chat_message_model.dart';

/// Implementation of CerebroRepository
class CerebroRepositoryImpl implements CerebroRepository {
  final CerebroRemoteDataSource _remoteDataSource;
  final CerebroLocalDataSource _localDataSource;

  CerebroRepositoryImpl({
    required CerebroRemoteDataSource remoteDataSource,
    required CerebroLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<ChatMessage> sendMessage(
    String message, {
    List<String>? contextEpisodeIds,
  }) async {
    try {
      // Save user message locally
      final userMessage = ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: message,
        role: MessageRole.user,
        timestamp: DateTime.now(),
      );
      await _localDataSource.saveChatMessage(userMessage);

      // Send to API and get response
      final response = await _remoteDataSource.sendMessage(
        message,
        contextEpisodeIds: contextEpisodeIds,
      );

      // Save assistant response locally
      await _localDataSource.saveChatMessage(response);

      return response;
    } catch (e, st) {
      AppLogger.e('Failed to send message', e, st);
      rethrow;
    }
  }

  @override
  Future<List<Episode>> searchEpisodes(
    String query, {
    int limit = 10,
  }) async {
    try {
      return await _remoteDataSource.searchEpisodes(query, limit: limit);
    } catch (e, st) {
      AppLogger.e('Failed to search episodes', e, st);
      // Return cached episodes on error
      return _localDataSource.getCachedEpisodes();
    }
  }

  @override
  Future<List<Episode>> getEpisodes({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final episodes = await _remoteDataSource.getEpisodes(
        limit: limit,
        offset: offset,
      );

      // Cache the results
      await _localDataSource.cacheEpisodes(episodes);

      return episodes;
    } catch (e, st) {
      AppLogger.e('Failed to get episodes', e, st);
      // Return cached episodes on error
      return _localDataSource.getCachedEpisodes();
    }
  }

  @override
  Future<Episode?> getEpisodeById(String id) async {
    try {
      return await _remoteDataSource.getEpisodeById(id);
    } catch (e, st) {
      AppLogger.e('Failed to get episode by id', e, st);
      return null;
    }
  }

  @override
  Future<Episode> createEpisode({
    required String content,
    required List<String> tags,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      return await _remoteDataSource.createEpisode(
        content: content,
        tags: tags,
        metadata: metadata,
      );
    } catch (e, st) {
      AppLogger.e('Failed to create episode', e, st);
      rethrow;
    }
  }

  @override
  Future<List<ChatMessage>> getChatHistory() async {
    return _localDataSource.getChatHistory();
  }

  @override
  Future<void> clearChatHistory() async {
    await _localDataSource.clearChatHistory();
  }
}
