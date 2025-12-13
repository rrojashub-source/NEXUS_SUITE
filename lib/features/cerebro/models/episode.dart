/// Episode model - represents a memory episode from CEREBRO
class Episode {
  final String id;
  final String content;
  final double importanceScore;
  final List<String> tags;
  final DateTime createdAt;
  final bool hasEmbedding;
  final double? similarityScore;
  final Map<String, dynamic>? metadata;

  Episode({
    required this.id,
    required this.content,
    required this.importanceScore,
    required this.tags,
    required this.createdAt,
    this.hasEmbedding = false,
    this.similarityScore,
    this.metadata,
  });

  /// Create from API response
  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['episode_id'] as String? ?? json['id'] as String,
      content: json['content'] as String,
      importanceScore: (json['importance_score'] as num?)?.toDouble() ?? 0.5,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
      hasEmbedding: json['has_embedding'] as bool? ?? false,
      similarityScore: (json['similarity_score'] as num?)?.toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'episode_id': id,
      'content': content,
      'importance_score': importanceScore,
      'tags': tags,
      'created_at': createdAt.toIso8601String(),
      'has_embedding': hasEmbedding,
      if (similarityScore != null) 'similarity_score': similarityScore,
      if (metadata != null) 'metadata': metadata,
    };
  }

  /// Get content preview (first 100 chars)
  String get preview {
    if (content.length <= 100) return content;
    return '${content.substring(0, 100)}...';
  }

  /// Get formatted date
  String get formattedDate {
    final now = DateTime.now();
    final diff = now.difference(createdAt);

    if (diff.inMinutes < 1) return 'Ahora';
    if (diff.inMinutes < 60) return 'Hace ${diff.inMinutes}m';
    if (diff.inHours < 24) return 'Hace ${diff.inHours}h';
    if (diff.inDays < 7) return 'Hace ${diff.inDays}d';

    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  /// Copy with modifications
  Episode copyWith({
    String? id,
    String? content,
    double? importanceScore,
    List<String>? tags,
    DateTime? createdAt,
    bool? hasEmbedding,
    double? similarityScore,
    Map<String, dynamic>? metadata,
  }) {
    return Episode(
      id: id ?? this.id,
      content: content ?? this.content,
      importanceScore: importanceScore ?? this.importanceScore,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      hasEmbedding: hasEmbedding ?? this.hasEmbedding,
      similarityScore: similarityScore ?? this.similarityScore,
      metadata: metadata ?? this.metadata,
    );
  }
}
