import '../entities/chat_message.dart';
import '../entities/episode.dart';

/// Abstract repository interface for CEREBRO operations
abstract class CerebroRepository {
  /// Send a message to CEREBRO and get a response
  Future<ChatMessage> sendMessage(
    String message, {
    List<String>? contextEpisodeIds,
  });

  /// Search episodes by semantic query
  Future<List<Episode>> searchEpisodes(
    String query, {
    int limit = 10,
  });

  /// Get recent episodes
  Future<List<Episode>> getEpisodes({
    int limit = 20,
    int offset = 0,
  });

  /// Get a single episode by ID
  Future<Episode?> getEpisodeById(String id);

  /// Create a new episode
  Future<Episode> createEpisode({
    required String content,
    required List<String> tags,
    Map<String, dynamic>? metadata,
  });

  /// Get cached chat history
  Future<List<ChatMessage>> getChatHistory();

  /// Clear chat history
  Future<void> clearChatHistory();
}
