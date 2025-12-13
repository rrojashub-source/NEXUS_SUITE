import '../../domain/entities/chat_message.dart';
import '../../domain/entities/episode.dart';
import 'episode_model.dart';

/// Data model for ChatMessage with JSON serialization
class ChatMessageModel extends ChatMessage {
  const ChatMessageModel({
    required super.id,
    required super.content,
    required super.role,
    required super.timestamp,
    super.sources,
    super.isLoading,
  });

  /// Create from JSON
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      content: json['content'] as String,
      role: MessageRole.values.firstWhere(
        (r) => r.name == json['role'],
        orElse: () => MessageRole.user,
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isLoading: json['is_loading'] as bool? ?? false,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'role': role.name,
      'timestamp': timestamp.toIso8601String(),
      if (sources != null)
        'sources': sources!
            .map((e) => EpisodeModel.fromEntity(e).toJson())
            .toList(),
      'is_loading': isLoading,
    };
  }

  /// Create from API response
  factory ChatMessageModel.fromApiResponse(Map<String, dynamic> json) {
    final List<Episode>? sources = json['sources'] != null
        ? (json['sources'] as List<dynamic>)
            .map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : null;

    return ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: json['response'] as String,
      role: MessageRole.assistant,
      timestamp: DateTime.now(),
      sources: sources,
    );
  }

  /// Create from domain entity
  factory ChatMessageModel.fromEntity(ChatMessage message) {
    return ChatMessageModel(
      id: message.id,
      content: message.content,
      role: message.role,
      timestamp: message.timestamp,
      sources: message.sources,
      isLoading: message.isLoading,
    );
  }
}
