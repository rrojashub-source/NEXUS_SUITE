import '../../domain/entities/episode.dart';

/// Data model for Episode with JSON serialization
class EpisodeModel extends Episode {
  const EpisodeModel({
    required super.id,
    required super.content,
    required super.tags,
    required super.metadata,
    required super.createdAt,
    super.updatedAt,
    super.relevanceScore,
  });

  /// Create from JSON
  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] as String,
      content: json['content'] as String,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      relevanceScore: (json['relevance_score'] as num?)?.toDouble(),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'tags': tags,
      'metadata': metadata,
      'created_at': createdAt.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
      if (relevanceScore != null) 'relevance_score': relevanceScore,
    };
  }

  /// Create from domain entity
  factory EpisodeModel.fromEntity(Episode episode) {
    return EpisodeModel(
      id: episode.id,
      content: episode.content,
      tags: episode.tags,
      metadata: episode.metadata,
      createdAt: episode.createdAt,
      updatedAt: episode.updatedAt,
      relevanceScore: episode.relevanceScore,
    );
  }
}
