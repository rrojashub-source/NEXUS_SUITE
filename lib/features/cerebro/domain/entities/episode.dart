import 'package:equatable/equatable.dart';

/// Episode entity - a memory unit in CEREBRO
class Episode extends Equatable {
  final String id;
  final String content;
  final List<String> tags;
  final Map<String, dynamic> metadata;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final double? relevanceScore;

  const Episode({
    required this.id,
    required this.content,
    required this.tags,
    required this.metadata,
    required this.createdAt,
    this.updatedAt,
    this.relevanceScore,
  });

  @override
  List<Object?> get props => [
        id,
        content,
        tags,
        metadata,
        createdAt,
        updatedAt,
        relevanceScore,
      ];

  Episode copyWith({
    String? id,
    String? content,
    List<String>? tags,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? relevanceScore,
  }) {
    return Episode(
      id: id ?? this.id,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      relevanceScore: relevanceScore ?? this.relevanceScore,
    );
  }
}
