/// Chat message model
class ChatMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final List<String>? sources; // Episode IDs used as sources
  final String? errorMessage;

  ChatMessage({
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.sources,
    this.errorMessage,
  });

  /// Create from API response
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      content: json['content'] as String,
      isUser: json['is_user'] as bool? ?? false,
      timestamp: DateTime.parse(json['timestamp'] as String),
      sources: (json['sources'] as List<dynamic>?)?.cast<String>(),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'is_user': isUser,
      'timestamp': timestamp.toIso8601String(),
      if (sources != null) 'sources': sources,
    };
  }

  /// Copy with modifications
  ChatMessage copyWith({
    String? content,
    bool? isUser,
    DateTime? timestamp,
    List<String>? sources,
    String? errorMessage,
  }) {
    return ChatMessage(
      content: content ?? this.content,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      sources: sources ?? this.sources,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
